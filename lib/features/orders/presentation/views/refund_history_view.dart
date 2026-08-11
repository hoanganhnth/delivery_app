import 'package:delivery_app/features/orders/application/refund_history_intent.dart';
import 'package:delivery_app/features/orders/application/refund_history_state.dart';
import 'package:delivery_app/features/orders/presentation/components/refund_status_case_card.dart';
import 'package:flutter/material.dart';

/// Pure refund-history UI; row taps and retry/navigation are typed intents.
class RefundHistoryView extends StatelessWidget {
  const RefundHistoryView({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final RefundHistoryViewState state;
  final ValueChanged<RefundHistoryIntent> onIntent;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Lịch sử hoàn tiền'),
      leading: IconButton(
        tooltip: 'Quay lại',
        onPressed: () => onIntent(const RefundHistoryBackRequested()),
        icon: const Icon(Icons.arrow_back),
      ),
    ),
    body: switch ((state.isLoading, state.hasError, state.isEmpty)) {
      (true, _, _) => const Center(child: CircularProgressIndicator()),
      (_, true, _) => _RefundHistoryError(
        onRetry: () => onIntent(const RefundHistoryRetryRequested()),
      ),
      (_, _, true) => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 180),
          Center(child: Text('Chưa có yêu cầu hoàn tiền.')),
        ],
      ),
      _ => RefreshIndicator(
        onRefresh: () async => onIntent(const RefundHistoryRefreshRequested()),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: state.cases.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final refundCase = state.cases[index];
            return RefundStatusCaseCard(
              refundCase: refundCase,
              showOrderId: true,
              onTap: () =>
                  onIntent(RefundHistoryOrderRequested(refundCase.orderId)),
            );
          },
        ),
      ),
    },
  );
}

class _RefundHistoryError extends StatelessWidget {
  const _RefundHistoryError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
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
