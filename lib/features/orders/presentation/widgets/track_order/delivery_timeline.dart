import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/foundations/app_spacing.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/generated/l10n.dart';

/// Order Timeline Widget - Hiển thị 4 bước cơ bản của đơn hàng
/// Đây là trạng thái ĐƠN HÀNG (order), không phải delivery tracking
class DeliveryTimeline extends StatelessWidget {
  final OrderStatus status;
  final String? rawBackendStatus; // Để hiển thị subtitle chi tiết hơn

  const DeliveryTimeline({
    super.key,
    required this.status,
    this.rawBackendStatus,
  });

  @override
  Widget build(BuildContext context) {
    final currentStepIndex = _getStepIndex(status, rawBackendStatus);

    return Column(
      children: [
        // Step 1: Chờ nhận đơn
        _TimelineStep(
          icon: Icons.receipt_long,
          title: 'Chờ nhận đơn',
          subtitle: _getSubtitle(context, 0, currentStepIndex),
          isCompleted: currentStepIndex > 0,
          isActive: currentStepIndex == 0,
        ),

        // Step 2: Chờ lấy đơn
        _TimelineStep(
          icon: Icons.store,
          title: 'Chờ lấy đơn',
          subtitle: _getSubtitle(context, 1, currentStepIndex),
          isCompleted: currentStepIndex > 1,
          isActive: currentStepIndex == 1,
        ),

        // Step 3: Đang giao
        _TimelineStep(
          icon: Icons.delivery_dining,
          title: 'Đang giao',
          subtitle: _getSubtitle(context, 2, currentStepIndex),
          isCompleted: currentStepIndex > 2,
          isActive: currentStepIndex == 2,
          isLarge: currentStepIndex == 2, // Highlight khi đang active
        ),

        // Step 4: Thành công
        _TimelineStep(
          icon: Icons.task_alt,
          title: 'Thành công',
          subtitle: 'Chúc bạn ngon miệng!',
          isCompleted: currentStepIndex >= 3,
          isActive: false,
          isLast: true,
        ),
      ],
    );
  }

  /// Xác định step hiện tại dựa trên OrderStatus và rawBackendStatus
  int _getStepIndex(OrderStatus status, String? raw) {
    // Ưu tiên raw backend status nếu có
    if (raw != null) {
      switch (raw.toUpperCase()) {
        case 'PENDING':
        case 'PENDING_PAYMENT':
        case 'CONFIRMED':
        case 'CONFIRMED_BY_RESTAURANT':
          return 0; // Chờ nhận đơn
        case 'FINDING_SHIPPER':
        case 'ASSIGNED_TO_SHIPPER':
        case 'ASSIGNED':
          return 1; // Chờ lấy đơn
        case 'IN_DELIVERY':
        case 'DELIVERING':
        case 'PICKED_UP':
          return 2; // Đang giao
        case 'DELIVERED':
          return 3; // Thành công
        case 'SHIPPER_NOT_FOUND':
          return 0; // Terminal matching failure; detail screen hides timeline.
        default:
          break;
      }
    }

    // Fallback dùng OrderStatus enum
    switch (status) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.delivering:
        return 2;
      case OrderStatus.shipperNotFound:
        return 0;
      case OrderStatus.delivered:
        return 3;
      case OrderStatus.cancelled:
        return 0;
    }
  }

  /// Lấy subtitle phù hợp cho từng step
  String _getSubtitle(
    BuildContext context,
    int stepIndex,
    int currentStepIndex,
  ) {
    if (stepIndex > currentStepIndex) {
      // Chưa đến bước này
      return '';
    }

    switch (stepIndex) {
      case 0:
        if (currentStepIndex == 0) return 'Đang chờ nhà hàng xác nhận';
        return 'Nhà hàng đã xác nhận';
      case 1:
        if (currentStepIndex == 1) return S.of(context).findingDriver;
        return 'Tài xế đã nhận đơn';
      case 2:
        if (currentStepIndex == 2) return 'Tài xế đang trên đường giao';
        return 'Đã giao thành công';
      default:
        return '';
    }
  }
}

/// Single Timeline Step
class _TimelineStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isLarge;
  final bool isLast;

  const _TimelineStep({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isActive,
    this.isLarge = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final iconSize = isLarge ? 40.0 : 32.0;
    final titleSize = isLarge ? 16.0 : 14.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon + Line
        Column(
          children: [
            AnimatedContainer(
              duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 300),
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: isCompleted || isActive
                    ? colors.primary
                    : colors.outlineVariant,
                shape: BoxShape.circle,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
                border: isActive
                    ? Border.all(
                        color: colors.primary.withValues(alpha: 0.3),
                        width: 4,
                      )
                    : null,
              ),
              child: Icon(
                icon,
                color: isCompleted || isActive
                    ? Colors.white
                    : colors.onSurfaceVariant,
                size: isLarge ? 20.0 : 16.0,
              ),
            ),
            if (!isLast)
              Container(
                width: 2.0,
                height: isLarge ? 48.0 : 40.0,
                color: isCompleted ? colors.primary : colors.outlineVariant,
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.sm),
        // Text
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: isActive ? FontWeight.w900 : FontWeight.bold,
                    color: isActive
                        ? colors.primary
                        : isCompleted
                        ? colors.onSurface
                        : colors.onSurfaceVariant,
                    letterSpacing: isActive ? -0.5 : 0,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isCompleted
                          ? colors.onSurfaceVariant
                          : colors.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
