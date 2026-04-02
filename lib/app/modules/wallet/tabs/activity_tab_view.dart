import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/mock_wallet_data.dart';
import '../controllers/wallet_controller.dart';

class ActivityTabView extends StatefulWidget {
  const ActivityTabView({super.key});

  @override
  State<ActivityTabView> createState() => _ActivityTabViewState();
}

class _ActivityTabViewState extends State<ActivityTabView> {
  static const _filters = ['All', 'Income', 'Expense', 'Cards', 'Transfers'];
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletController>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              'Transactions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: _filters
                  .map(
                    (filter) => _FilterChip(
                      label: filter,
                      isSelected: _selectedFilter == filter,
                      onTap: () => setState(() => _selectedFilter = filter),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(
              () {
                final filtered = _applyFilter(walletController.transactions);
                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      'No transactions for $_selectedFilter yet.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF64748B),
                          ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  itemCount: filtered.length,
                  separatorBuilder: (_, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return _ActivityTile(transaction: filtered[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<TransactionModel> _applyFilter(List<TransactionModel> source) {
    switch (_selectedFilter) {
      case 'Income':
        return source.where((transaction) => transaction.isCredit).toList();
      case 'Expense':
        return source.where((transaction) => !transaction.isCredit).toList();
      case 'Cards':
        return source
            .where(
              (transaction) =>
                  transaction.subtitle.toLowerCase().contains('card') ||
                  transaction.category.toLowerCase() == 'cards',
            )
            .toList();
      case 'Transfers':
        return source
            .where((transaction) => transaction.category.toLowerCase() == 'transfer')
            .toList();
      case 'All':
      default:
        return source;
    }
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        onPressed: onTap,
        label: Text(label),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF334155),
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: isSelected ? const Color(0xFF1D4ED8) : Colors.white,
        side: BorderSide(
          color: isSelected ? const Color(0xFF1D4ED8) : const Color(0xFFE2E8F0),
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final amountColor = transaction.isCredit
        ? const Color(0xFF16A34A)
        : const Color(0xFFDC2626);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: transaction.isCredit
                ? const Color(0xFFE8FBEF)
                : const Color(0xFFFEECEC),
            child: Icon(
              transaction.isCredit
                  ? Icons.call_received_rounded
                  : Icons.call_made_rounded,
              color: amountColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF64748B),
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.amount,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: amountColor,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                transaction.time,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF94A3B8),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
