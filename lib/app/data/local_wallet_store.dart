import 'package:hive_flutter/hive_flutter.dart';

abstract final class LocalWalletStore {
  static const boxName = 'wallet_box';

  static const keyIsSeeded = 'is_seeded';
  static const keyUserName = 'user_name';
  static const keyMemberSince = 'member_since';
  static const keyTotalBalance = 'total_balance';
  static const keyContacts = 'contacts';
  static const keyCards = 'cards';
  static const keyTransactions = 'transactions';
  static const keyNotifications = 'notifications';
  static const keySettings = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(boxName);
  }

  static Box<dynamic> get box => Hive.box<dynamic>(boxName);
}
