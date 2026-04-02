import 'dart:math';

import 'package:get/get.dart';

import '../../../data/local_wallet_store.dart';
import '../../../data/mock_wallet_data.dart';
import '../../../utils/wallet_formatters.dart';

class WalletController extends GetxController {
  final userName = MockWalletData.userName.obs;
  final memberSince = MockWalletData.memberSince.obs;
  final totalBalance = MockWalletData.initialTotalBalance.obs;

  final contacts = <ContactModel>[].obs;
  final cards = <CardModel>[].obs;
  final transactions = <TransactionModel>[].obs;
  final notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadOrSeed();
  }

  String get totalBalanceLabel => WalletFormatters.formatCurrency(totalBalance.value);

  double get monthlyIncomeValue {
    final now = DateTime.now();
    return transactions
        .where((t) =>
            t.isCredit &&
            t.createdAt.year == now.year &&
            t.createdAt.month == now.month)
        .fold(0.0, (sum, t) => sum + t.amountValue);
  }

  double get monthlySpendValue {
    final now = DateTime.now();
    return transactions
        .where((t) =>
            !t.isCredit &&
            t.createdAt.year == now.year &&
            t.createdAt.month == now.month)
        .fold(0.0, (sum, t) => sum + t.amountValue);
  }

  String get monthlyIncomeLabel => WalletFormatters.formatCurrency(monthlyIncomeValue);
  String get monthlySpendLabel => WalletFormatters.formatCurrency(monthlySpendValue);

  int get unreadNotificationsCount =>
      notifications.where((notification) => notification.isUnread).length;

  List<SpendingCategoryStat> get spendingStats {
    final now = DateTime.now();
    final monthlyExpenses = transactions.where(
      (transaction) =>
          !transaction.isCredit &&
          transaction.createdAt.year == now.year &&
          transaction.createdAt.month == now.month,
    );

    final totals = <String, double>{};
    for (final transaction in monthlyExpenses) {
      totals.update(
        transaction.category,
        (value) => value + transaction.amountValue,
        ifAbsent: () => transaction.amountValue,
      );
    }

    final totalExpense = totals.values.fold(0.0, (sum, value) => sum + value);
    if (totalExpense == 0) {
      return [];
    }

    final stats = totals.entries
        .map(
          (entry) => SpendingCategoryStat(
            name: entry.key,
            amountValue: entry.value,
            percentage: entry.value / totalExpense,
          ),
        )
        .toList()
      ..sort((a, b) => b.amountValue.compareTo(a.amountValue));

    return stats;
  }

  List<double> get weeklySpendRatios {
    final now = DateTime.now();
    final dailyExpenseTotals = List<double>.generate(7, (index) {
      final target = DateTime(now.year, now.month, now.day - (6 - index));
      return transactions
          .where(
            (transaction) =>
                !transaction.isCredit &&
                transaction.createdAt.year == target.year &&
                transaction.createdAt.month == target.month &&
                transaction.createdAt.day == target.day,
          )
          .fold(0.0, (sum, transaction) => sum + transaction.amountValue);
    });

    final maxValue = dailyExpenseTotals.fold(0.0, max);
    if (maxValue == 0) {
      return List<double>.filled(7, 0.1);
    }

    return dailyExpenseTotals.map((value) => value / maxValue).toList();
  }

  Future<String?> sendMoney({
    required String recipient,
    required double amount,
    required String note,
  }) async {
    if (amount <= 0) {
      return 'Please enter a valid amount.';
    }
    if (totalBalance.value < amount) {
      return 'Insufficient balance for this transfer.';
    }

    totalBalance.value -= amount;
    final transaction = TransactionModel(
      title: 'Sent to $recipient',
      subtitle: note.isEmpty ? 'Peer Transfer' : note,
      amountValue: amount,
      isCredit: false,
      createdAt: DateTime.now(),
      category: 'Transfer',
    );
    transactions.insert(0, transaction);

    _addNotification(
      title: 'Transfer Successful',
      message:
          '${WalletFormatters.formatCurrency(amount)} sent to $recipient.',
    );

    await _persistWalletState();
    return null;
  }

  Future<String?> requestMoney({
    required String requester,
    required double amount,
    required String reason,
  }) async {
    if (amount <= 0) {
      return 'Please enter a valid amount.';
    }

    totalBalance.value += amount;
    final transaction = TransactionModel(
      title: 'Received from $requester',
      subtitle: reason.isEmpty ? 'Money Request' : reason,
      amountValue: amount,
      isCredit: true,
      createdAt: DateTime.now(),
      category: 'Transfer',
    );
    transactions.insert(0, transaction);

    _addNotification(
      title: 'Request Paid',
      message:
          '${WalletFormatters.formatCurrency(amount)} received from $requester.',
    );

    await _persistWalletState();
    return null;
  }

  Future<void> addVirtualCard() async {
    final random = Random();
    final suffix = (1000 + random.nextInt(8999)).toString();
    final month = (1 + random.nextInt(12)).toString().padLeft(2, '0');
    final year = (27 + random.nextInt(4)).toString();

    cards.add(
      CardModel(
        label: 'Virtual Card',
        number: '**** $suffix',
        expiry: '$month/$year',
        brand: random.nextBool() ? 'VISA' : 'Mastercard',
        balanceValue: max(1000, totalBalance.value * 0.1),
      ),
    );
    await _persistCards();

    _addNotification(
      title: 'Card Created',
      message: 'A new virtual card ending in $suffix is now active.',
    );
    await _persistNotifications();
  }

  Future<void> markAllNotificationsRead() async {
    notifications.assignAll(
      notifications.map((notification) => notification.copyWith(isUnread: false)),
    );
    await _persistNotifications();
  }

  Future<void> markNotificationRead(int index) async {
    if (index < 0 || index >= notifications.length) {
      return;
    }

    final notification = notifications[index];
    notifications[index] = notification.copyWith(isUnread: false);
    notifications.refresh();
    await _persistNotifications();
  }

  Future<void> _loadOrSeed() async {
    final box = LocalWalletStore.box;
    final isSeeded = box.get(LocalWalletStore.keyIsSeeded, defaultValue: false);

    if (isSeeded != true) {
      await _seedDefaults();
    }

    userName.value =
        box.get(LocalWalletStore.keyUserName, defaultValue: MockWalletData.userName)
            as String;
    memberSince.value = box.get(
      LocalWalletStore.keyMemberSince,
      defaultValue: MockWalletData.memberSince,
    ) as String;
    totalBalance.value = (box.get(
      LocalWalletStore.keyTotalBalance,
      defaultValue: MockWalletData.initialTotalBalance,
    ) as num)
        .toDouble();

    final contactMaps = List<Map<String, dynamic>>.from(
      (box.get(LocalWalletStore.keyContacts, defaultValue: <Map<String, dynamic>>[])
              as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map)),
    );
    contacts.assignAll(contactMaps.map(ContactModel.fromMap));

    final cardMaps = List<Map<String, dynamic>>.from(
      (box.get(LocalWalletStore.keyCards, defaultValue: <Map<String, dynamic>>[])
              as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map)),
    );
    cards.assignAll(cardMaps.map(CardModel.fromMap));

    final transactionMaps = List<Map<String, dynamic>>.from(
      (box.get(
        LocalWalletStore.keyTransactions,
        defaultValue: <Map<String, dynamic>>[],
      ) as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map)),
    );
    transactions.assignAll(transactionMaps.map(TransactionModel.fromMap));

    final notificationMaps = List<Map<String, dynamic>>.from(
      (box.get(
        LocalWalletStore.keyNotifications,
        defaultValue: <Map<String, dynamic>>[],
      ) as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map)),
    );
    notifications.assignAll(notificationMaps.map(NotificationModel.fromMap));
  }

  Future<void> _seedDefaults() async {
    final box = LocalWalletStore.box;
    await box.put(LocalWalletStore.keyUserName, MockWalletData.userName);
    await box.put(LocalWalletStore.keyMemberSince, MockWalletData.memberSince);
    await box.put(LocalWalletStore.keyTotalBalance, MockWalletData.initialTotalBalance);
    await box.put(
      LocalWalletStore.keyContacts,
      MockWalletData.contacts.map((contact) => contact.toMap()).toList(),
    );
    await box.put(
      LocalWalletStore.keyCards,
      MockWalletData.cards.map((card) => card.toMap()).toList(),
    );
    await box.put(
      LocalWalletStore.keyTransactions,
      MockWalletData.transactions.map((transaction) => transaction.toMap()).toList(),
    );
    await box.put(
      LocalWalletStore.keyNotifications,
      MockWalletData.notifications
          .map((notification) => notification.toMap())
          .toList(),
    );
    await box.put(
      LocalWalletStore.keySettings,
      {
        'pushAlerts': true,
        'emailAlerts': false,
        'biometricLock': true,
        'quickPayments': true,
      },
    );
    await box.put(LocalWalletStore.keyIsSeeded, true);
  }

  void _addNotification({
    required String title,
    required String message,
  }) {
    notifications.insert(
      0,
      NotificationModel(
        title: title,
        message: message,
        createdAt: DateTime.now(),
        isUnread: true,
      ),
    );
  }

  Future<void> _persistWalletState() async {
    await LocalWalletStore.box.put(LocalWalletStore.keyTotalBalance, totalBalance.value);
    await _persistTransactions();
    await _persistNotifications();
  }

  Future<void> _persistTransactions() async {
    await LocalWalletStore.box.put(
      LocalWalletStore.keyTransactions,
      transactions.map((transaction) => transaction.toMap()).toList(),
    );
  }

  Future<void> _persistNotifications() async {
    await LocalWalletStore.box.put(
      LocalWalletStore.keyNotifications,
      notifications.map((notification) => notification.toMap()).toList(),
    );
  }

  Future<void> _persistCards() async {
    await LocalWalletStore.box.put(
      LocalWalletStore.keyCards,
      cards.map((card) => card.toMap()).toList(),
    );
  }
}
