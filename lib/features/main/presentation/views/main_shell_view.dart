import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/components/app_navigation.dart';
import 'package:delivery_app/core/design_system/components/preview_page_shell.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/main_shell_intent.dart';
import '../../application/main_shell_state.dart';

class MainShellView extends StatelessWidget {
  const MainShellView({
    super.key,
    required this.state,
    required this.pages,
    required this.onIntent,
  });

  final MainShellViewState state;
  final List<Widget> pages;
  final ValueChanged<MainShellIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      body: IndexedStack(index: state.index, children: pages),
      extendBody: false,
      bottomNavigationBar: PreviewTypography(
        child: AppBottomNavBar(
          elevation: 0,
          currentIndex: state.index,
          onTap: (index) => onIntent(MainTabSelected(index)),
          items: [
            AppNavItem(
              key: const Key('bottom_nav_home'),
              icon: Icons.home_outlined,
              activeIcon: Icons.home_outlined,
              label: strings.home,
              semanticLabel: strings.home,
            ),
            AppNavItem(
              key: const Key('bottom_nav_orders'),
              icon: Icons.receipt_long_outlined,
              activeIcon: Icons.receipt_long_outlined,
              label: strings.navOrders,
              semanticLabel: strings.navOrders,
            ),
            AppNavItem(
              key: const Key('bottom_nav_cart'),
              icon: Icons.shopping_bag_outlined,
              activeIcon: Icons.shopping_bag_outlined,
              label: strings.navCart,
              semanticLabel: strings.navCart,
              badgeCount: state.cartItemCount,
            ),
            AppNavItem(
              key: const Key('bottom_nav_account'),
              icon: Icons.person_outline,
              activeIcon: Icons.person_outline,
              label: strings.navAccount,
              semanticLabel: strings.navAccount,
            ),
          ],
        ),
      ),
    );
  }
}
