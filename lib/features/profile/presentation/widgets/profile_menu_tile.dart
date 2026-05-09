import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final AppColors colors;
  final Widget? trailing;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.colors,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveSize.m),
        child: Row(
          children: [
            // Background Icon
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
              ),
              child: Icon(
                icon,
                color: colors.primary,
                size: 22.w,
              ),
            ),
            SizedBox(width: ResponsiveSize.m),
            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontM,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontS,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Trailing
            trailing ??
                Icon(
                  Icons.chevron_right,
                  color: colors.textSecondary,
                  size: 24.w,
                ),
          ],
        ),
      ),
    );
  }
}
