import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:delivery_app/features/orders/presentation/providers/refund_status_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Per-order status visibility only. It deliberately exposes no refund action.
class CustomerRefundStatusCard extends ConsumerWidget {
  const CustomerRefundStatusCard({super.key, required this.orderId});

  final num orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refundState = ref.watch(customerRefundForOrderProvider(orderId));
    return refundState.when(
      loading: SizedBox.shrink,
      data: (refundCase) => refundCase == null
          ? const SizedBox.shrink()
          : RefundStatusCaseCard(refundCase: refundCase),
      error: (_, _) => _RefundStatusLoadError(
        onRetry: () => ref.invalidate(customerRefundForOrderProvider(orderId)),
      ),
    );
  }
}

class RefundStatusCaseCard extends StatelessWidget {
  const RefundStatusCaseCard({
    super.key,
    required this.refundCase,
    this.showOrderId = false,
    this.onTap,
  });

  final RefundCaseEntity refundCase;
  final bool showOrderId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final presentation = _RefundStatusPresentation.from(refundCase.status);
    final timestamp =
        refundCase.processedAt ?? refundCase.updatedAt ?? refundCase.createdAt;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(presentation.icon, color: presentation.color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Trạng thái hoàn tiền',
                      maxLines: 2,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (showOrderId) ...[
                const SizedBox(height: 4),
                Text(
                  'Đơn #${refundCase.orderId}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                presentation.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: presentation.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(presentation.description, style: theme.textTheme.bodyMedium),
              if (refundCase.status != RefundCaseStatus.noRefundRequired) ...[
                const SizedBox(height: 12),
                Text(
                  '${presentation.amountLabel}: ${_formatAmount(refundCase)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              if (timestamp != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Cập nhật: ${DateFormat('dd/MM/yyyy HH:mm').format(timestamp.toLocal())}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatAmount(RefundCaseEntity refundCase) {
    if (refundCase.currency.toUpperCase() == 'VND') {
      return NumberFormat.currency(
        locale: 'vi_VN',
        symbol: '₫',
        decimalDigits: 0,
      ).format(refundCase.refundAmount);
    }
    return '${refundCase.refundAmount.toStringAsFixed(2)} ${refundCase.currency}';
  }
}

class _RefundStatusLoadError extends StatelessWidget {
  const _RefundStatusLoadError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.info_outline),
            const SizedBox(width: 8),
            const Expanded(child: Text('Không thể tải trạng thái hoàn tiền.')),
            TextButton(onPressed: onRetry, child: const Text('Thử lại')),
          ],
        ),
      ),
    );
  }
}

class _RefundStatusPresentation {
  const _RefundStatusPresentation({
    required this.title,
    required this.description,
    required this.amountLabel,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final String amountLabel;
  final IconData icon;
  final Color color;

  factory _RefundStatusPresentation.from(RefundCaseStatus status) {
    return switch (status) {
      RefundCaseStatus.requested => const _RefundStatusPresentation(
        title: 'Đã tiếp nhận',
        description: 'Yêu cầu hoàn tiền đang chờ được xử lý.',
        amountLabel: 'Số tiền được ghi nhận',
        icon: Icons.schedule_outlined,
        color: Colors.orange,
      ),
      RefundCaseStatus.processing => const _RefundStatusPresentation(
        title: 'Đang xử lý',
        description: 'Hoàn tiền đang được xử lý.',
        amountLabel: 'Số tiền được ghi nhận',
        icon: Icons.hourglass_top_outlined,
        color: Colors.blue,
      ),
      RefundCaseStatus.succeeded => const _RefundStatusPresentation(
        title: 'Hoàn tiền thành công',
        description: 'Khoản hoàn tiền trong yêu cầu đã được hoàn tất.',
        amountLabel: 'Đã hoàn',
        icon: Icons.check_circle_outline,
        color: Colors.green,
      ),
      RefundCaseStatus.partial => const _RefundStatusPresentation(
        title: 'Hoàn tiền một phần',
        description: 'Yêu cầu này đã được xử lý một phần.',
        amountLabel: 'Đã hoàn',
        icon: Icons.pie_chart_outline,
        color: Colors.teal,
      ),
      RefundCaseStatus.failed => const _RefundStatusPresentation(
        title: 'Cần kiểm tra thêm',
        description: 'Yêu cầu chưa thể hoàn tự động và đang cần được kiểm tra.',
        amountLabel: 'Số tiền được ghi nhận',
        icon: Icons.error_outline,
        color: Colors.red,
      ),
      RefundCaseStatus.manualReview => const _RefundStatusPresentation(
        title: 'Đang được kiểm tra',
        description: 'Yêu cầu đang được bộ phận hỗ trợ kiểm tra.',
        amountLabel: 'Số tiền được ghi nhận',
        icon: Icons.support_agent_outlined,
        color: Colors.deepOrange,
      ),
      RefundCaseStatus.noRefundRequired => const _RefundStatusPresentation(
        title: 'Không cần hoàn tiền',
        description: 'Đơn chưa phát sinh khoản tiền cần hoàn.',
        amountLabel: '',
        icon: Icons.info_outline,
        color: Colors.blueGrey,
      ),
      RefundCaseStatus.unknown => const _RefundStatusPresentation(
        title: 'Đang được kiểm tra',
        description: 'Trạng thái hoàn tiền đang được cập nhật.',
        amountLabel: 'Số tiền được ghi nhận',
        icon: Icons.help_outline,
        color: Colors.blueGrey,
      ),
    };
  }
}
