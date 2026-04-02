import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/wallet_controller.dart';

class RequestMoneyView extends StatefulWidget {
  const RequestMoneyView({super.key});

  @override
  State<RequestMoneyView> createState() => _RequestMoneyViewState();
}

class _RequestMoneyViewState extends State<RequestMoneyView> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _requesterController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _requesterController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Request Money')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Payment Request',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount (PKR)',
                  prefixIcon: Icon(Icons.currency_rupee_rounded),
                ),
                validator: (value) {
                  final amount = double.tryParse(value?.trim() ?? '');
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _requesterController,
                decoration: const InputDecoration(
                  labelText: 'Requester Name',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Requester name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _reasonController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.notes_rounded),
                ),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.qr_code_2_rounded,
                      size: 132,
                      color: Color(0xFF0F172A),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Demo Receive',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This action adds a real credit transaction to Hive data.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF64748B),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    final amount = double.parse(_amountController.text.trim());
                    final error = await walletController.requestMoney(
                      requester: _requesterController.text.trim(),
                      amount: amount,
                      reason: _reasonController.text.trim(),
                    );

                    if (error != null) {
                      Get.snackbar(
                        'Request Failed',
                        error,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xFFFEE2E2),
                      );
                      return;
                    }

                    _amountController.clear();
                    _reasonController.clear();
                    Get.snackbar(
                      'Request Completed',
                      'Amount received and wallet updated.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text('Request & Receive'),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Text(
                  'Updated Balance: ${walletController.totalBalanceLabel}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF475569),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
