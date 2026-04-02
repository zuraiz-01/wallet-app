import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    this.nextRoute,
    this.nextLabel = 'Next',
  });

  final String title;
  final String? nextRoute;
  final String nextLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$title will be designed in the next step.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              if (nextRoute != null)
                FilledButton(
                  onPressed: () => Get.toNamed(nextRoute!),
                  child: Text(nextLabel),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
