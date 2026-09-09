import 'package:delivery_app/core/design_system/components/app_navigation.dart';
import 'package:delivery_app/core/routing/app_router.dart';
import 'package:delivery_app/core/routing/constants/app_routes.dart';
import 'package:delivery_app/core/routing/models/app_router_config.dart';
import 'package:delivery_app/core/routing/models/i_auth_checker.dart';
import 'package:delivery_app/features/main/application/main_shell_intent.dart';
import 'package:delivery_app/features/main/application/main_shell_state.dart';
import 'package:delivery_app/features/main/presentation/views/main_shell_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  group('Customer Navigation Shell — Task 3', () {
    testWidgets('switches between all four tabs and preserves tab state', (
      tester,
    ) async {
      var selectedIndex = 0;

      await pumpTestApp(
        tester,
        child: StatefulBuilder(
          builder: (context, setState) {
            return MainShellView(
              state: MainShellViewState(
                tab: switch (selectedIndex) {
                  0 => MainTab.home,
                  1 => MainTab.orders,
                  2 => MainTab.cart,
                  _ => MainTab.account,
                },
                index: selectedIndex,
              ),
              pages: const [
                _TabContent(title: 'HOME_PAGE', inputKey: 'input_home'),
                _TabContent(title: 'ORDERS_PAGE', inputKey: 'input_orders'),
                _TabContent(title: 'CART_PAGE', inputKey: 'input_cart'),
                _TabContent(title: 'ACCOUNT_PAGE', inputKey: 'input_account'),
              ],
              onIntent: (intent) {
                if (intent is MainTabSelected) {
                  setState(() => selectedIndex = intent.index);
                }
              },
            );
          },
        ),
      );

      // 1. Initial tab is Home
      expect(find.text('HOME_PAGE'), findsOneWidget);
      expect(find.byKey(const Key('bottom_nav_home')), findsOneWidget);
      expect(find.byKey(const Key('bottom_nav_orders')), findsOneWidget);
      expect(find.byKey(const Key('bottom_nav_cart')), findsOneWidget);
      expect(find.byKey(const Key('bottom_nav_account')), findsOneWidget);

      // Enter text into Home tab input
      await tester.enterText(
        find.byKey(const Key('input_home')),
        'Saved in Home',
      );
      await tester.pumpAndSettle();

      // Switch to orders and retain its local state.
      await tester.tap(find.byKey(const Key('bottom_nav_orders')));
      await tester.pumpAndSettle();
      expect(selectedIndex, 1);
      expect(find.text('ORDERS_PAGE'), findsOneWidget);

      // Enter text into orders tab input.
      await tester.enterText(
        find.byKey(const Key('input_orders')),
        'Query pizza',
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('bottom_nav_cart')));
      await tester.pumpAndSettle();
      expect(selectedIndex, 2);
      expect(find.text('CART_PAGE'), findsOneWidget);

      // Switch to Account tab.
      await tester.tap(find.byKey(const Key('bottom_nav_account')));
      await tester.pumpAndSettle();
      expect(selectedIndex, 3);
      expect(find.text('ACCOUNT_PAGE'), findsOneWidget);

      // Switch back to orders — verify state is preserved.
      await tester.tap(find.byKey(const Key('bottom_nav_orders')));
      await tester.pumpAndSettle();
      expect(selectedIndex, 1);
      expect(find.text('Query pizza'), findsOneWidget);

      // 5. Switch back to Home tab — verify state is preserved!
      await tester.tap(find.byKey(const Key('bottom_nav_home')));
      await tester.pumpAndSettle();
      expect(selectedIndex, 0);
      expect(find.text('Saved in Home'), findsOneWidget);
    });

    testWidgets(
      'AppBottomNavBar displays badge count and handles touch targets',
      (tester) async {
        var tappedIndex = -1;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              bottomNavigationBar: AppBottomNavBar(
                currentIndex: 0,
                onTap: (i) => tappedIndex = i,
                items: const [
                  AppNavItem(
                    key: Key('item_home'),
                    icon: Icons.home_outlined,
                    label: 'Home',
                  ),
                  AppNavItem(
                    key: Key('item_cart'),
                    icon: Icons.shopping_bag_outlined,
                    label: 'Cart',
                    badgeCount: 3,
                  ),
                  AppNavItem(
                    key: Key('item_overflow'),
                    icon: Icons.notifications_outlined,
                    label: 'Alerts',
                    badgeCount: 120,
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('3'), findsOneWidget);
        expect(find.text('99+'), findsOneWidget);

        final homeFinder = find.byKey(const Key('item_home'));
        expect(homeFinder, findsOneWidget);
        final homeSize = tester.getSize(homeFinder);
        // Accessible touch target is at least 48x48
        expect(homeSize.height, greaterThanOrEqualTo(48.0));

        await tester.tap(find.byKey(const Key('item_cart')));
        expect(tappedIndex, 1);
      },
    );

    testWidgets('sticky CTA sits above bottom navigation bar without occlusion', (
      tester,
    ) async {
      await pumpTestApp(
        tester,
        child: Scaffold(
          body: const Column(
            children: [
              Expanded(child: Center(child: Text('Content area'))),
              AppStickyAction(
                key: Key('sticky_cta'),
                child: Text('STICKY_ACTION_BUTTON'),
              ),
            ],
          ),
          bottomNavigationBar: AppBottomNavBar(
            key: const Key('test_bottom_nav'),
            currentIndex: 0,
            onTap: (_) {},
            items: const [
              AppNavItem(icon: Icons.home, label: 'Home'),
              AppNavItem(icon: Icons.search, label: 'Search'),
            ],
          ),
        ),
      );

      final ctaBottom = tester
          .getBottomLeft(find.byKey(const Key('sticky_cta')))
          .dy;
      final navTop = tester
          .getTopLeft(find.byKey(const Key('test_bottom_nav')))
          .dy;

      // The bottom of the sticky CTA is above or equal to the top of bottom nav
      expect(ctaBottom, lessThanOrEqualTo(navTop + 0.1));
    });

    testWidgets('router preserves deep links and supports back navigation', (
      tester,
    ) async {
      final auth = _TestAuthNotifier(authenticated: true);
      final router = createAppRouter(
        authNotifier: auth,
        config: const AppRouterConfig(initialLocation: AppRoutes.main),
        pages: const _NavTestPages(),
      );
      addTearDown(router.dispose);

      await pumpTestRouter(tester, router: router);
      await tester.pumpAndSettle();

      // Starts at MAIN_SHELL
      expect(find.text('MAIN_SHELL'), findsOneWidget);

      // Deep link to /orders
      router.go(AppRoutes.orders);
      await tester.pumpAndSettle();
      expect(find.text('ORDERS_SCREEN'), findsOneWidget);

      // Deep link to /orders/99
      router.go('/orders/99');
      await tester.pumpAndSettle();
      expect(find.text('ORDER 99'), findsOneWidget);

      // Deep link to /search
      router.go(AppRoutes.search);
      await tester.pumpAndSettle();
      expect(find.text('SEARCH_SCREEN'), findsOneWidget);

      // Push /cart from search
      router.push(AppRoutes.cart);
      await tester.pumpAndSettle();
      expect(find.text('CART_SCREEN'), findsOneWidget);

      // Pop from /cart returns to /search
      router.pop();
      await tester.pumpAndSettle();
      expect(find.text('SEARCH_SCREEN'), findsOneWidget);

      // Push /restaurants/42
      router.push('/restaurants/42');
      await tester.pumpAndSettle();
      expect(find.text('RESTAURANT 42'), findsOneWidget);

      // Pop from restaurant detail returns to /search
      router.pop();
      await tester.pumpAndSettle();
      expect(find.text('SEARCH_SCREEN'), findsOneWidget);
    });
  });
}

class _TabContent extends StatefulWidget {
  const _TabContent({required this.title, required this.inputKey});

  final String title;
  final String inputKey;

  @override
  State<_TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<_TabContent> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title),
        TextField(key: Key(widget.inputKey), controller: _controller),
      ],
    );
  }
}

class _TestAuthNotifier extends ChangeNotifier implements IAuthNotifier {
  _TestAuthNotifier({bool authenticated = false})
    : _authenticated = authenticated;

  final bool _authenticated;

  @override
  bool get isAuthenticated => _authenticated;

  @override
  UserRole get userRole => _authenticated ? UserRole.regular : UserRole.guest;
}

class _NavTestPages extends AppRouterPages {
  const _NavTestPages();

  Widget _page(String text) => Scaffold(body: Center(child: Text(text)));

  @override
  Widget main() => _page('MAIN_SHELL');

  @override
  Widget home() => _page('HOME_SCREEN');

  @override
  Widget search() => _page('SEARCH_SCREEN');

  @override
  Widget orders() => _page('ORDERS_SCREEN');

  @override
  Widget profile() => _page('PROFILE_SCREEN');

  @override
  Widget cart() => _page('CART_SCREEN');

  @override
  Widget checkout() => _page('CHECKOUT_SCREEN');

  @override
  Widget orderDetail(int orderId) => _page('ORDER $orderId');

  @override
  Widget restaurantDetail(int restaurantId) =>
      _page('RESTAURANT $restaurantId');
}
