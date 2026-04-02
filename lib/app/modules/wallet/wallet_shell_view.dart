import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/wallet_shell_controller.dart';
import 'tabs/activity_tab_view.dart';
import 'tabs/cards_tab_view.dart';
import 'tabs/home_tab_view.dart';
import 'tabs/profile_tab_view.dart';

class WalletShellView extends StatelessWidget {
  const WalletShellView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletShellController());

    const pages = [
      HomeTabView(),
      CardsTabView(),
      ActivityTabView(),
      ProfileTabView(),
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeTab,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.credit_card_outlined),
              selectedIcon: Icon(Icons.credit_card_rounded),
              label: 'Cards',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long_rounded),
              label: 'Activity',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
