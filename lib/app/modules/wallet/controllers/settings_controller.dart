import 'package:get/get.dart';

class SettingsController extends GetxController {
  final pushAlerts = true.obs;
  final emailAlerts = false.obs;
  final biometricLock = true.obs;
  final quickPayments = true.obs;
}
