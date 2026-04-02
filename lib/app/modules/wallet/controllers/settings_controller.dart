import 'package:get/get.dart';

import '../../../data/local_wallet_store.dart';

class SettingsController extends GetxController {
  final pushAlerts = true.obs;
  final emailAlerts = false.obs;
  final biometricLock = true.obs;
  final quickPayments = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> setPushAlerts(bool value) async {
    pushAlerts.value = value;
    await _save();
  }

  Future<void> setEmailAlerts(bool value) async {
    emailAlerts.value = value;
    await _save();
  }

  Future<void> setBiometricLock(bool value) async {
    biometricLock.value = value;
    await _save();
  }

  Future<void> setQuickPayments(bool value) async {
    quickPayments.value = value;
    await _save();
  }

  void _loadSettings() {
    final raw = LocalWalletStore.box.get(
      LocalWalletStore.keySettings,
      defaultValue: {
        'pushAlerts': true,
        'emailAlerts': false,
        'biometricLock': true,
        'quickPayments': true,
      },
    );

    final settingsMap = Map<String, dynamic>.from(raw as Map);
    pushAlerts.value = settingsMap['pushAlerts'] as bool? ?? true;
    emailAlerts.value = settingsMap['emailAlerts'] as bool? ?? false;
    biometricLock.value = settingsMap['biometricLock'] as bool? ?? true;
    quickPayments.value = settingsMap['quickPayments'] as bool? ?? true;
  }

  Future<void> _save() async {
    await LocalWalletStore.box.put(
      LocalWalletStore.keySettings,
      {
        'pushAlerts': pushAlerts.value,
        'emailAlerts': emailAlerts.value,
        'biometricLock': biometricLock.value,
        'quickPayments': quickPayments.value,
      },
    );
  }
}
