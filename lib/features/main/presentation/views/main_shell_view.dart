import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/components/app_navigation.dart';
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
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: state.index,
        onTap: (index) => onIntent(MainTabSelected(index)),
        items: [
          AppNavItem(
            key: const Key('bottom_nav_home'),
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: strings.navHome,
            semanticLabel: strings.navHome,
          ),
          AppNavItem(
            key: const Key('bottom_nav_search'),
            icon: Icons.search_outlined,
            activeIcon: Icons.search,
            label: strings.navSearch,
            semanticLabel: strings.navSearch,
          ),
          AppNavItem(
            key: const Key('bottom_nav_account'),
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
