import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'app/data/local_wallet_store.dart';
import 'app/modules/wallet/controllers/settings_controller.dart';
import 'app/modules/wallet/controllers/wallet_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalWalletStore.init();
  Get.put(WalletController(), permanent: true);
  Get.put(SettingsController(), permanent: true);
  runApp(const WalletApp());
}
