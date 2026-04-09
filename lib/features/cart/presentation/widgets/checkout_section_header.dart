import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';

/// Widget header cho các section trong checkout
class CheckoutSectionHeader extends ConsumerWidget {
  final String title;
  final IconData icon;

  const CheckoutSectionHeader({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Icon(icon, size: 20, color: ref.colors.primary),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ref.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
