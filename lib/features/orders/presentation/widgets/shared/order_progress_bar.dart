import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Thanh tiến trình đơn hàng với animation
///
/// Usage:
/// ```dart
/// OrderProgressBar(progress: 0.66) // 66% complete
/// ```
class OrderProgressBar extends ConsumerStatefulWidget {
  final double progress; // 0.0 to 1.0

  const OrderProgressBar({
    super.key,
    required this.progress,
  }) : assert(progress >= 0.0 && progress <= 1.0);

  @override
  ConsumerState<OrderProgressBar> createState() => _OrderProgressBarState();
}

class _OrderProgressBarState extends ConsumerState<OrderProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: widget.progress).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(OrderProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress bar
        SizedBox(
          height: 6.h,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: LinearProgressIndicator(
                  value: _animation.value,
                  backgroundColor: colors.textSecondary.withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                  minHeight: 6.h,
                ),
              );
            },
          ),
        ),
        
        SizedBox(height: 8.h),
        
        // Percentage
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final percentage = (_animation.value * 100).round();
            return Text(
              '$percentage% hoàn thành',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            );
          },
        ),
      ],
    );
  }
}
