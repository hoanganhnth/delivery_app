import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/orders/presentation/providers/refund_status_providers.dart';
import 'package:delivery_app/features/orders/presentation/widgets/order_detail/customer_refund_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Customer refund history. It is deliberately read-only: selecting an item
/// opens the corresponding order detail rather than changing the refund case.
class RefundStatusHistoryScreen extends ConsumerWidget {
  const RefundStatusHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refundCases = ref.watch(customerRefundCasesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Lịch sử hoàn tiền')),
      body: refundCases.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _RefundHistoryError(
          onRetry: () => ref.invalidate(customerRefundCasesProvider),
        ),
        data: (cases) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(customerRefundCasesProvider),
          child: cases.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: 180),
                    Center(child: Text('Chưa có yêu cầu hoàn tiền.')),
                  ],
                )
              : ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: cases.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final refundCase = cases[index];
                    return RefundStatusCaseCard(
                      refundCase: refundCase,
                      showOrderId: true,
                      onTap: () => context.pushOrderDetail(
                        refundCase.orderId.toString(),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _RefundHistoryError extends StatelessWidget {
  const _RefundHistoryError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Không thể tải lịch sử hoàn tiền.'),
          const SizedBox(height: 8),
          TextButton(onPressed: onRetry, child: const Text('Thử lại')),
        ],
      ),
    );
  }
}
