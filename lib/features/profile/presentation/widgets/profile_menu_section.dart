import 'package:flutter/material.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';

class ProfileMenuSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final AppColors colors;

  const ProfileMenuSection({
    super.key,
    required this.title,
    required this.children,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveSize.fontL,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        SizedBox(height: ResponsiveSize.s),
        Container(
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
            boxShadow: [
              BoxShadow(
                color: colors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
        SizedBox(height: ResponsiveSize.l),
      ],
    );
  }
}

class ProfileMenuDivider extends StatelessWidget {
  final AppColors colors;

  const ProfileMenuDivider({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.m),
      child: Divider(
        height: 1,
        color: colors.divider,
      ),
    );
  }
}
