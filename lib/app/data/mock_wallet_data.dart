import '../utils/wallet_formatters.dart';

class ContactModel {
  ContactModel({
    required this.name,
    required this.avatarLabel,
  });

  final String name;
  final String avatarLabel;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatarLabel': avatarLabel,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      name: map['name'] as String? ?? 'Unknown',
      avatarLabel: map['avatarLabel'] as String? ?? 'U',
    );
  }
}

class TransactionModel {
  TransactionModel({
    required this.title,
    required this.subtitle,
    required this.amountValue,
    required this.isCredit,
    required this.createdAt,
    required this.category,
  });

  final String title;
  final String subtitle;
  final double amountValue;
  final bool isCredit;
  final DateTime createdAt;
  final String category;

  String get amount => WalletFormatters.formatSignedCurrency(
        amount: amountValue,
        isCredit: isCredit,
      );

  String get time => WalletFormatters.formatTransactionTime(createdAt);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'amountValue': amountValue,
      'isCredit': isCredit,
      'createdAt': createdAt.toIso8601String(),
      'category': category,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    final amountValue = (map['amountValue'] as num?)?.toDouble() ??
        WalletFormatters.parseCurrency(map['amount'] as String? ?? 'PKR 0');
    return TransactionModel(
      title: map['title'] as String? ?? 'Transaction',
      subtitle: map['subtitle'] as String? ?? 'Wallet',
      amountValue: amountValue,
      isCredit: map['isCredit'] as bool? ?? amountValue >= 0,
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ??
          DateTime.now(),
      category: map['category'] as String? ?? 'Other',
    );
  }
}

class CardModel {
  CardModel({
    required this.label,
    required this.number,
    required this.expiry,
    required this.brand,
    required this.balanceValue,
  });

  final String label;
  final String number;
  final String expiry;
  final String brand;
  final double balanceValue;

  String get balance => WalletFormatters.formatCurrency(balanceValue);

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'number': number,
      'expiry': expiry,
      'brand': brand,
      'balanceValue': balanceValue,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      label: map['label'] as String? ?? 'Card',
      number: map['number'] as String? ?? '**** 0000',
      expiry: map['expiry'] as String? ?? '01/30',
      brand: map['brand'] as String? ?? 'VISA',
      balanceValue: (map['balanceValue'] as num?)?.toDouble() ??
          WalletFormatters.parseCurrency(map['balance'] as String? ?? 'PKR 0'),
    );
  }
}

class NotificationModel {
  NotificationModel({
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isUnread,
  });

  final String title;
  final String message;
  final DateTime createdAt;
  final bool isUnread;

  String get time => WalletFormatters.formatRelativeTime(createdAt);

  NotificationModel copyWith({
    String? title,
    String? message,
    DateTime? createdAt,
    bool? isUnread,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isUnread: isUnread ?? this.isUnread,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'isUnread': isUnread,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String? ?? 'Notification',
      message: map['message'] as String? ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ??
          DateTime.now(),
      isUnread: map['isUnread'] as bool? ?? false,
    );
  }
}

class SpendingCategoryStat {
  SpendingCategoryStat({
    required this.name,
    required this.amountValue,
    required this.percentage,
  });

  final String name;
  final double amountValue;
  final double percentage;

  String get amountLabel => WalletFormatters.formatCurrency(amountValue);
}

abstract final class MockWalletData {
  static const userName = 'Zuraiz Khan';
  static const memberSince = 'Member since Jan 2026';
  static const initialTotalBalance = 284500.0;

  static final contacts = [
    ContactModel(name: 'Ali', avatarLabel: 'A'),
    ContactModel(name: 'Sana', avatarLabel: 'S'),
    ContactModel(name: 'Usman', avatarLabel: 'U'),
    ContactModel(name: 'Hina', avatarLabel: 'H'),
    ContactModel(name: 'Daniyal', avatarLabel: 'D'),
  ];

  static final cards = [
    CardModel(
      label: 'Primary Card',
      number: '**** 4587',
      expiry: '09/28',
      brand: 'VISA',
      balanceValue: 184200,
    ),
    CardModel(
      label: 'Travel Card',
      number: '**** 9064',
      expiry: '12/27',
      brand: 'Mastercard',
      balanceValue: 73900,
    ),
    CardModel(
      label: 'Virtual Card',
      number: '**** 1320',
      expiry: '04/29',
      brand: 'VISA',
      balanceValue: 26400,
    ),
  ];

  static final transactions = [
    TransactionModel(
      title: 'Salary Credit',
      subtitle: 'Wallet Top-Up',
      amountValue: 92000,
      isCredit: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 9)),
      category: 'Income',
    ),
    TransactionModel(
      title: 'Grocery Mart',
      subtitle: 'POS Payment',
      amountValue: 8450,
      isCredit: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      category: 'Food',
    ),
    TransactionModel(
      title: 'Netflix',
      subtitle: 'Subscription',
      amountValue: 2200,
      isCredit: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
      category: 'Entertainment',
    ),
    TransactionModel(
      title: 'Received From Ali',
      subtitle: 'Peer Transfer',
      amountValue: 4500,
      isCredit: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
      category: 'Transfer',
    ),
    TransactionModel(
      title: 'Fuel Station',
      subtitle: 'Card Payment',
      amountValue: 5200,
      isCredit: false,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      category: 'Transport',
    ),
    TransactionModel(
      title: 'Electricity Bill',
      subtitle: 'Bill Payment',
      amountValue: 12600,
      isCredit: false,
      createdAt: DateTime.now().subtract(const Duration(days: 4, hours: 2)),
      category: 'Bills',
    ),
  ];

  static final notifications = [
    NotificationModel(
      title: 'Transfer Successful',
      message: 'PKR 2,500 sent to Sana.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      isUnread: true,
    ),
    NotificationModel(
      title: 'Utility Bill Reminder',
      message: 'Your gas bill is due in 2 days.',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      isUnread: true,
    ),
    NotificationModel(
      title: 'Spending Insight',
      message: 'Food spending is 18% lower than last month.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isUnread: false,
    ),
    NotificationModel(
      title: 'New Device Login',
      message: 'Your account logged in from Pixel 8.',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      isUnread: false,
    ),
  ];
}
