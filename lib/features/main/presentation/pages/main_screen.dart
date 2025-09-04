import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../orders/presentation/pages/orders_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../providers/navigation_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(selectedTabProvider);

    const pages = <Widget>[
      HomePage(),
      CartPage(),
      OrdersPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: pages[currentTab.tabIndex], // dùng tabIndex từ AppTab
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ],
        ),
        child: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: GNav(
                
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.orange,
                color: Colors.grey[600],
                tabs: const [
                  GButton(icon: Icons.home, text: 'Home'),
                  GButton(icon: Icons.shopping_cart, text: 'Cart'),
                  GButton(icon: Icons.receipt_long, text: 'Orders'),
                  GButton(icon: Icons.person, text: 'Profile'),
                ],
                selectedIndex: currentTab.tabIndex, // chọn tab bằng AppTab
                onTabChange: (index) {
                  ref.read(selectedTabProvider.notifier).state =
                      AppTab.values[index]; // gán lại AppTab thay vì int
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
