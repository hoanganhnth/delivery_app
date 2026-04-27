import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import '../../domain/entities/order_entity.dart';

/// Order Timeline Widget - Hiển thị 4 bước cơ bản của đơn hàng
/// Đây là trạng thái ĐƠN HÀNG (order), không phải delivery tracking
class DeliveryTimeline extends ConsumerWidget {
  final OrderStatus status;
  final String? rawBackendStatus; // Để hiển thị subtitle chi tiết hơn

  const DeliveryTimeline({
    super.key,
    required this.status,
    this.rawBackendStatus,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStepIndex = _getStepIndex(status, rawBackendStatus);

    return Column(
      children: [
        // Step 1: Chờ nhận đơn
        _TimelineStep(
          icon: Icons.receipt_long,
          title: 'Chờ nhận đơn',
          subtitle: _getSubtitle(0, currentStepIndex),
          isCompleted: currentStepIndex > 0,
          isActive: currentStepIndex == 0,
        ),

        // Step 2: Chờ lấy đơn
        _TimelineStep(
          icon: Icons.store,
          title: 'Chờ lấy đơn',
          subtitle: _getSubtitle(1, currentStepIndex),
          isCompleted: currentStepIndex > 1,
          isActive: currentStepIndex == 1,
        ),

        // Step 3: Đang giao
        _TimelineStep(
          icon: Icons.delivery_dining,
          title: 'Đang giao',
          subtitle: _getSubtitle(2, currentStepIndex),
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
      case OrderStatus.delivered:
        return 3;
      case OrderStatus.cancelled:
        return 0;
    }
  }

  /// Lấy subtitle phù hợp cho từng step
  String _getSubtitle(int stepIndex, int currentStepIndex) {
    if (stepIndex > currentStepIndex) {
      // Chưa đến bước này
      return '';
    }

    switch (stepIndex) {
      case 0:
        if (currentStepIndex == 0) return 'Đang chờ nhà hàng xác nhận';
        return 'Nhà hàng đã xác nhận';
      case 1:
        if (currentStepIndex == 1) return 'Đang tìm tài xế giao hàng';
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
class _TimelineStep extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    final iconSize = isLarge ? 40.w : 32.w;
    final titleSize = isLarge ? ResponsiveSize.fontXl : ResponsiveSize.fontM;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon + Line
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: isCompleted || isActive ? colors.primary : colors.border,
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
                    : colors.textSecondary,
                size: isLarge ? 20.w : 16.w,
              ),
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: isLarge ? 48.h : 40.h,
                color: isCompleted ? colors.primary : colors.border,
              ),
          ],
        ),
        SizedBox(width: ResponsiveSize.m),
        // Text
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : ResponsiveSize.m),
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
                        ? colors.textPrimary
                        : colors.textSecondary,
                    letterSpacing: isActive ? -0.5 : 0,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontS,
                      fontWeight: FontWeight.w500,
                      color: isCompleted
                          ? colors.textSecondary
                          : colors.textSecondary.withValues(alpha: 0.5),
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
