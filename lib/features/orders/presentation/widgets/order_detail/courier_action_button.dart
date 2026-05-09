import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/app_colors.dart';

class CourierActionButton extends StatelessWidget {
  final AppColors colors;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const CourierActionButton({
    super.key,
    required this.colors,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: isPrimary ? colors.primary : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isPrimary
                  ? colors.primary.withValues(alpha: 0.3)
                  : colors.shadow.withValues(alpha: 0.1),
              blurRadius: isPrimary ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isPrimary ? Colors.white : colors.primary,
          size: 20.w,
        ),
      ),
    );
  }
}
