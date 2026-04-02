class ContactModel {
  const ContactModel({
    required this.name,
    required this.avatarLabel,
  });

  final String name;
  final String avatarLabel;
}

class TransactionModel {
  const TransactionModel({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.time,
  });

  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;
  final String time;
}

class CardModel {
  const CardModel({
    required this.label,
    required this.number,
    required this.expiry,
    required this.brand,
    required this.balance,
  });

  final String label;
  final String number;
  final String expiry;
  final String brand;
  final String balance;
}

abstract final class MockWalletData {
  static const userName = 'Zuraiz Khan';
  static const memberSince = 'Member since Jan 2026';
  static const totalBalance = 'PKR 284,500';
  static const monthlyIncome = 'PKR 92,000';
  static const monthlySpend = 'PKR 61,400';

  static const contacts = [
    ContactModel(name: 'Ali', avatarLabel: 'A'),
    ContactModel(name: 'Sana', avatarLabel: 'S'),
    ContactModel(name: 'Usman', avatarLabel: 'U'),
    ContactModel(name: 'Hina', avatarLabel: 'H'),
    ContactModel(name: 'Daniyal', avatarLabel: 'D'),
  ];

  static const cards = [
    CardModel(
      label: 'Primary Card',
      number: '**** 4587',
      expiry: '09/28',
      brand: 'VISA',
      balance: 'PKR 184,200',
    ),
    CardModel(
      label: 'Travel Card',
      number: '**** 9064',
      expiry: '12/27',
      brand: 'Mastercard',
      balance: 'PKR 73,900',
    ),
    CardModel(
      label: 'Virtual Card',
      number: '**** 1320',
      expiry: '04/29',
      brand: 'VISA',
      balance: 'PKR 26,400',
    ),
  ];

  static const transactions = [
    TransactionModel(
      title: 'Salary Credit',
      subtitle: 'Wallet Top-Up',
      amount: '+PKR 92,000',
      isCredit: true,
      time: 'Today, 09:00 AM',
    ),
    TransactionModel(
      title: 'Grocery Mart',
      subtitle: 'POS Payment',
      amount: '-PKR 8,450',
      isCredit: false,
      time: 'Today, 07:10 PM',
    ),
    TransactionModel(
      title: 'Netflix',
      subtitle: 'Subscription',
      amount: '-PKR 2,200',
      isCredit: false,
      time: 'Yesterday, 10:40 PM',
    ),
    TransactionModel(
      title: 'Received From Ali',
      subtitle: 'Peer Transfer',
      amount: '+PKR 4,500',
      isCredit: true,
      time: 'Yesterday, 03:25 PM',
    ),
    TransactionModel(
      title: 'Fuel Station',
      subtitle: 'Card Payment',
      amount: '-PKR 5,200',
      isCredit: false,
      time: 'Mar 30, 08:10 PM',
    ),
    TransactionModel(
      title: 'Electricity Bill',
      subtitle: 'Bill Payment',
      amount: '-PKR 12,600',
      isCredit: false,
      time: 'Mar 29, 04:18 PM',
    ),
  ];

  static const notifications = [
    (
      title: 'Transfer Successful',
      message: 'PKR 2,500 sent to Sana.',
      time: '2m ago',
      isUnread: true,
    ),
    (
      title: 'Utility Bill Reminder',
      message: 'Your gas bill is due in 2 days.',
      time: '1h ago',
      isUnread: true,
    ),
    (
      title: 'Spending Insight',
      message: 'Food spending is 18% lower than last month.',
      time: 'Yesterday',
      isUnread: false,
    ),
    (
      title: 'New Device Login',
      message: 'Your account logged in from Pixel 8.',
      time: 'Mar 30',
      isUnread: false,
    ),
  ];

  static const spendByCategory = [
    ('Food', 0.34, 'PKR 20,900'),
    ('Transport', 0.22, 'PKR 13,700'),
    ('Bills', 0.26, 'PKR 16,100'),
    ('Shopping', 0.18, 'PKR 10,700'),
  ];
}
