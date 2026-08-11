import 'package:flutter/material.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';

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
    return Scaffold(
      body: IndexedStack(index: state.index, children: pages),
      extendBody: true,
      bottomNavigationBar: AmberBottomNavBar(
        currentIndex: state.index,
        onTap: (index) => onIntent(MainTabSelected(index)),
      ),
    );
  }
}
