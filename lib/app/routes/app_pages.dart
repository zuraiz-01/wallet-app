import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/auth/forgot_password_view.dart';
import '../modules/auth/login_view.dart';
import '../modules/auth/register_view.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/shared/placeholder_screen.dart';
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

Widget _walletPage() => const PlaceholderScreen(
      title: 'Wallet Dashboard',
      nextRoute: AppRoutes.sendMoney,
    );

Widget _sendMoneyPage() => const PlaceholderScreen(
      title: 'Send Money',
      nextRoute: AppRoutes.requestMoney,
    );

Widget _requestMoneyPage() => const PlaceholderScreen(
      title: 'Request Money',
      nextRoute: AppRoutes.analytics,
    );

Widget _analyticsPage() => const PlaceholderScreen(
      title: 'Analytics',
      nextRoute: AppRoutes.notifications,
    );

Widget _notificationsPage() => const PlaceholderScreen(
      title: 'Notifications',
      nextRoute: AppRoutes.settings,
    );

Widget _settingsPage() => const PlaceholderScreen(
      title: 'Settings',
    );
