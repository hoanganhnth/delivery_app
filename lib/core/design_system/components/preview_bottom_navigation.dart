import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'app_navigation.dart';
import 'preview_page_shell.dart';

/// Bottom navigation used by the phone preview routes that sit outside the
/// indexed main shell (Search, Cart and similar deep links).
class PreviewBottomNavigation extends StatelessWidget {
  const PreviewBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartItemCount = 0,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final int cartItemCount;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return PreviewTypography(
      child: AppBottomNavBar(
        elevation: 0,
        topBorderColor: PreviewUi.divider(context),
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          AppNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: strings.home,
            semanticLabel: strings.home,
          ),
          AppNavItem(
            icon: Icons.receipt_long_outlined,
            activeIcon: Icons.receipt_long,
            label: strings.navOrders,
            semanticLabel: strings.navOrders,
          ),
          AppNavItem(
            icon: Icons.shopping_bag_outlined,
            activeIcon: Icons.shopping_bag,
            label: strings.navCart,
            semanticLabel: strings.navCart,
            badgeCount: cartItemCount,
          ),
          AppNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: strings.navAccount,
            semanticLabel: strings.navAccount,
          ),
        ],
      ),
    );
  }
}
