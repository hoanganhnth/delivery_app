import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

/// Filter TabBar - Editorial rounded-full pills
class OrdersTabBar extends StatelessWidget {
  final TabController tabController;

  const OrdersTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AnimatedBuilder(
      animation: tabController,
      builder: (context, _) {
        return Container(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.m),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildTabChip(
                context,
                colors,
                S.of(context).all,
                0,
                tabController.index == 0,
              ),
              SizedBox(width: ResponsiveSize.s),
              _buildTabChip(
                context,
                colors,
                'Active',
                1,
                tabController.index == 1,
              ),
              SizedBox(width: ResponsiveSize.s),
              _buildTabChip(
                context,
                colors,
                'Completed',
                2,
                tabController.index == 2,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabChip(
    BuildContext context,
    AppColors colors,
    String label,
    int index,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => tabController.animateTo(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.m + 4.w,
          vertical: ResponsiveSize.s,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary
              : colors.cardBackground.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(100), // Full rounded
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: ResponsiveSize.fontM,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
