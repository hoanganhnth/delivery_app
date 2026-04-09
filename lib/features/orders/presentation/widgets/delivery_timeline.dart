import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';

/// Delivery Timeline Widget - Vertical stepper với animated progress
class DeliveryTimeline extends ConsumerWidget {
  final String currentStep; // 'confirming', 'preparing', 'delivering', 'delivered'
  
  const DeliveryTimeline({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Step 1: Confirming
        _TimelineStep(
          icon: Icons.check_circle,
          iconFilled: true,
          title: 'Confirming',
          subtitle: 'Nhà hàng đã nhận đơn',
          isCompleted: true,
          isActive: currentStep == 'confirming',
        ),
        
        // Step 2: Preparing
        _TimelineStep(
          icon: Icons.restaurant,
          iconFilled: true,
          title: 'Preparing',
          subtitle: 'Đầu bếp đang chuẩn bị món ăn',
          isCompleted: _isStepCompleted('preparing'),
          isActive: currentStep == 'preparing',
        ),
        
        // Step 3: Out for delivery
        _TimelineStep(
          icon: Icons.delivery_dining,
          iconFilled: true,
          title: 'Out for delivery',
          subtitle: 'Tài xế đang trên đường tới',
          isCompleted: _isStepCompleted('delivering'),
          isActive: currentStep == 'delivering',
          isLarge: true, // Highlight active step
        ),
        
        // Step 4: Delivered
        _TimelineStep(
          icon: Icons.task_alt,
          iconFilled: false,
          title: 'Delivered',
          subtitle: 'Chúc bạn ngon miệng!',
          isCompleted: currentStep == 'delivered',
          isActive: false,
          isLast: true,
        ),
      ],
    );
  }
  
  bool _isStepCompleted(String step) {
    const steps = ['confirming', 'preparing', 'delivering', 'delivered'];
    final currentIndex = steps.indexOf(currentStep);
    final stepIndex = steps.indexOf(step);
    return currentIndex >= stepIndex;
  }
}

/// Single Timeline Step
class _TimelineStep extends ConsumerWidget {
  final IconData icon;
  final bool iconFilled;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isLarge;
  final bool isLast;
  
  const _TimelineStep({
    required this.icon,
    required this.iconFilled,
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
                color: isCompleted ? colors.primary : colors.border,
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
                color: isCompleted ? Colors.white : colors.textSecondary,
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
            ),
          ),
        ),
      ],
    );
  }
}
