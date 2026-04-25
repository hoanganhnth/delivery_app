import 'package:delivery_app/features/home/presentation/pages/home_page.dart';
import 'package:delivery_app/features/orders/orders.dart';
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
      OrdersScreen(),
      ProfilePage(),
    ];

    return Scaffold(
      body: pages[currentTab.tabIndex], // dùng tabIndex từ AppTab
      extendBody: true,
      bottomNavigationBar: AmberBottomNavBar(
        currentIndex: currentTab.tabIndex,
        onTap: (index) {
          ref.read(selectedTabProvider.notifier).setTab(
            AppTab.values[index],
          );
        },
      ),
    );
  }
}
