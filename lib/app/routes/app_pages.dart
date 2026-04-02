import 'package:get/get.dart';

import '../modules/auth/forgot_password_view.dart';
import '../modules/auth/login_view.dart';
import '../modules/auth/register_view.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/wallet/analytics_view.dart';
import '../modules/wallet/notifications_view.dart';
import '../modules/wallet/request_money_view.dart';
import '../modules/wallet/send_money_view.dart';
import '../modules/wallet/settings_view.dart';
import '../modules/wallet/wallet_shell_view.dart';
import 'app_routes.dart';

abstract final class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.onboarding,
      page: _onboardingPage,
    ),
    GetPage(
      name: AppRoutes.login,
      page: _loginPage,
    ),
    GetPage(
      name: AppRoutes.register,
      page: _registerPage,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: _forgotPasswordPage,
    ),
    GetPage(
      name: AppRoutes.wallet,
      page: _walletPage,
    ),
    GetPage(
      name: AppRoutes.sendMoney,
      page: _sendMoneyPage,
    ),
    GetPage(
      name: AppRoutes.requestMoney,
      page: _requestMoneyPage,
    ),
    GetPage(
      name: AppRoutes.analytics,
      page: _analyticsPage,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: _notificationsPage,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: _settingsPage,
    ),
  ];
}

OnboardingView _onboardingPage() => const OnboardingView();

LoginView _loginPage() => const LoginView();

RegisterView _registerPage() => const RegisterView();

ForgotPasswordView _forgotPasswordPage() => const ForgotPasswordView();

WalletShellView _walletPage() => const WalletShellView();

SendMoneyView _sendMoneyPage() => const SendMoneyView();

RequestMoneyView _requestMoneyPage() => const RequestMoneyView();

AnalyticsView _analyticsPage() => const AnalyticsView();

NotificationsView _notificationsPage() => const NotificationsView();

SettingsView _settingsPage() => const SettingsView();
