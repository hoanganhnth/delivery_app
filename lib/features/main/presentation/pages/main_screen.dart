import 'package:delivery_app/features/home/presentation/pages/home_page.dart';
import 'package:delivery_app/features/livestream/presentation/screens/all_livestreams_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/features/cart/presentation/pages/cart_page.dart';
import 'package:delivery_app/features/profile/presentation/pages/profile_page.dart';
import 'package:delivery_app/features/main/presentation/providers/navigation_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(selectedTabProvider);

    const pages = <Widget>[
      HomePage(),
      CartPage(),
      AllLivestreamsScreen(),
      ProfilePage(),
    ];

    // Map AppTab to physical index for IndexedStack
    int getPageIndex(AppTab tab) {
      switch (tab) {
        case AppTab.home:
          return 0;
        case AppTab.cart:
          return 1;
        case AppTab.livestreams:
          return 2;
        case AppTab.profile:
          return 3;
        default:
          return 0; // Default to home if on restaurants or other
      }
    }

    // Map physical index back to AppTab for currentTab.notifier
    AppTab getTabFromIndex(int index) {
      switch (index) {
        case 0:
          return AppTab.home;
        case 1:
          return AppTab.cart;
        case 2:
          return AppTab.livestreams;
        case 3:
          return AppTab.profile;
        default:
          return AppTab.home;
      }
    }

    final currentIndex = getPageIndex(currentTab);

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      extendBody: true,
      bottomNavigationBar: AmberBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(selectedTabProvider.notifier).setTab(getTabFromIndex(index));
        },
      ),
    );
  }
}
