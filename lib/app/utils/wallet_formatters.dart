abstract final class WalletFormatters {
  static String formatCurrency(double amount) {
    final rounded = amount.round();
    final digits = rounded.toString();
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      final reverseIndex = digits.length - i;
      buffer.write(digits[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(',');
      }
    }

    return 'PKR ${buffer.toString()}';
  }

  static String formatSignedCurrency({
    required double amount,
    required bool isCredit,
  }) {
    final sign = isCredit ? '+' : '-';
    return '$sign${formatCurrency(amount)}';
  }

  static String formatTransactionTime(DateTime createdAt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final createdDay = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final dayDifference = today.difference(createdDay).inDays;

    final hour = createdAt.hour == 0
        ? 12
        : createdAt.hour > 12
            ? createdAt.hour - 12
            : createdAt.hour;
    final period = createdAt.hour >= 12 ? 'PM' : 'AM';
    final minute = createdAt.minute.toString().padLeft(2, '0');
    final time = '$hour:$minute $period';

    if (dayDifference == 0) {
      return 'Today, $time';
    }
    if (dayDifference == 1) {
      return 'Yesterday, $time';
    }

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final monthName = months[createdAt.month - 1];
    return '$monthName ${createdAt.day}, $time';
  }

  static String formatRelativeTime(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt);

    if (diff.inMinutes < 1) {
      return 'now';
    }
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    }
    if (diff.inDays == 1) {
      return 'Yesterday';
    }
    if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    }

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[createdAt.month - 1]} ${createdAt.day}';
  }

  static double parseCurrency(String value) {
    final isNegative = value.trim().startsWith('-');
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9.]'), '');
    final parsed = double.tryParse(digitsOnly) ?? 0;
    return isNegative ? -parsed : parsed;
  }
}
