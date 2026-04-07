import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';

/// Settings Card - Container cho nhóm settings tiles
class SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const SettingsCard({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

/// Settings Tile - Row với icon, title, subtitle, và trailing
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(ResponsiveSize.m),
            child: Row(
              children: [
                // Icon box
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
                  ),
                  child: Icon(
                    icon,
                    color: colors.primary,
                    size: 20.w,
                  ),
                ),
                SizedBox(width: ResponsiveSize.m),
                // Title & subtitle
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
                      if (subtitle != null) ...[
                        SizedBox(height: 2.h),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: ResponsiveSize.fontS,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Trailing
                if (trailing != null) trailing!,
              ],
            ),
          ),
          if (showDivider)
            Divider(height: 1, color: colors.divider, indent: 56.w),
        ],
      ),
    );
  }
}

/// Section Title - Title cho mỗi nhóm settings
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveSize.m,
        top: ResponsiveSize.l,
        bottom: ResponsiveSize.s,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveSize.fontS,
          fontWeight: FontWeight.w700,
          color: colors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
