import 'package:delivery_app/features/orders/application/refund_history_intent.dart';
import 'package:delivery_app/features/orders/application/refund_history_state.dart';
import 'package:delivery_app/features/orders/presentation/components/refund_status_case_card.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
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
    backgroundColor: PreviewUi.canvas(context),
    appBar: PreviewPageHeader(
      title: 'Lịch sử hoàn tiền',
      onBack: () => onIntent(const RefundHistoryBackRequested()),
    ),
    body: switch ((state.isLoading, state.hasError, state.isEmpty)) {
      (true, _, _) => const Center(
        child: CircularProgressIndicator(color: PreviewUi.accent),
      ),
      (_, true, _) => _RefundHistoryError(
        onRetry: () => onIntent(const RefundHistoryRetryRequested()),
      ),
      (_, _, true) => const PreviewEmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'Chưa có yêu cầu hoàn tiền.',
        message: 'Các yêu cầu hoàn tiền của bạn sẽ xuất hiện tại đây.',
      ),
      _ => RefreshIndicator(
        onRefresh: () async => onIntent(const RefundHistoryRefreshRequested()),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          itemCount: state.cases.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
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
    child: PreviewEmptyState(
      icon: Icons.error_outline,
      title: 'Không thể tải lịch sử hoàn tiền',
      message: 'Vui lòng kiểm tra kết nối và thử lại.',
      actionLabel: 'Thử lại',
      onAction: onRetry,
    ),
  );
}
