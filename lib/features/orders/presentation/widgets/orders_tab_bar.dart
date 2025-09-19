import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

/// Widget TabBar cho Orders Screen
class OrdersTabBar extends StatelessWidget {
  final TabController tabController;

  const OrdersTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.white,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        physics: const ScrollPhysics(),
        tabAlignment: TabAlignment.center,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
        unselectedLabelStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: 14.sp,
        ),
        dividerColor: Colors.transparent,
        tabs: [
          _buildTab(S.of(context).all, Icons.list_alt),
          _buildTab(S.of(context).pending, Icons.schedule),
          _buildTab(S.of(context).confirmed, Icons.check_circle_outline),
          _buildTab(S.of(context).delivered, Icons.done_all),
        ],
      ),
    );
  }

  Widget _buildTab(String text, IconData icon) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          SizedBox(width: 6.w),
          AutoSizeText(text),
        ],
      ),
    );
  }
}
