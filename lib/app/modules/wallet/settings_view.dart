import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          _SectionCard(
            title: 'Security',
            children: [
              Obx(
                () => SwitchListTile.adaptive(
                  value: controller.biometricLock.value,
                  onChanged: (value) => controller.setBiometricLock(value),
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Biometric Lock'),
                  subtitle: const Text('Use fingerprint or face unlock'),
                ),
              ),
              Obx(
                () => SwitchListTile.adaptive(
                  value: controller.quickPayments.value,
                  onChanged: (value) => controller.setQuickPayments(value),
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Quick Payments'),
                  subtitle: const Text('Allow one-tap transfers'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Alerts',
            children: [
              Obx(
                () => SwitchListTile.adaptive(
                  value: controller.pushAlerts.value,
                  onChanged: (value) => controller.setPushAlerts(value),
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Push Notifications'),
                  subtitle: const Text('Transaction and payment alerts'),
                ),
              ),
              Obx(
                () => SwitchListTile.adaptive(
                  value: controller.emailAlerts.value,
                  onChanged: (value) => controller.setEmailAlerts(value),
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Email Summary'),
                  subtitle: const Text('Weekly statements and insights'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            leading: const Icon(Icons.language_rounded),
            title: const Text('Language'),
            subtitle: const Text('English (Pakistan)'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
            subtitle: const Text('Walletly v1.0.0'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          ...children,
        ],
      ),
    );
  }
}
