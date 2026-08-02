import 'package:delivery_app/core/routing/app_router.dart';
import 'package:delivery_app/core/routing/models/app_router_config.dart';
import 'package:delivery_app/core/routing/models/i_auth_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';

void main() {
  testWidgets('router redirects guests to login and reacts to authentication', (
    tester,
  ) async {
    final auth = _FakeAuthNotifier();
    final router = createAppRouter(
      authNotifier: auth,
      config: const AppRouterConfig(initialLocation: '/orders'),
      pages: const _TestPages(),
    );
    addTearDown(router.dispose);

    await pumpTestRouter(tester, router: router);
    await tester.pumpAndSettle();
    expect(find.text('LOGIN'), findsOneWidget);

    auth.authenticate();
    await tester.pumpAndSettle();
    expect(find.text('HOME'), findsOneWidget);
  });

  testWidgets('router redirects authenticated users away from guest pages', (
    tester,
  ) async {
    final auth = _FakeAuthNotifier(authenticated: true);
    final router = createAppRouter(
      authNotifier: auth,
      config: const AppRouterConfig(initialLocation: '/login'),
      pages: const _TestPages(),
    );
    addTearDown(router.dispose);

    await pumpTestRouter(tester, router: router);
    await tester.pumpAndSettle();
    expect(find.text('HOME'), findsOneWidget);
    expect(find.text('LOGIN'), findsNothing);
  });

  testWidgets('router validates dynamic IDs before building feature pages', (
    tester,
  ) async {
    final auth = _FakeAuthNotifier(authenticated: true);
    final router = createAppRouter(
      authNotifier: auth,
      config: const AppRouterConfig(initialLocation: '/orders/not-a-number'),
      pages: const _TestPages(),
    );
    addTearDown(router.dispose);

    await pumpTestRouter(tester, router: router);
    await tester.pumpAndSettle();
    expect(find.text('NOT FOUND'), findsOneWidget);

    router.go('/orders/42');
    await tester.pumpAndSettle();
    expect(find.text('ORDER 42'), findsOneWidget);

    router.go('/refunds');
    await tester.pumpAndSettle();
    expect(find.text('REFUNDS'), findsOneWidget);
  });
}

class _FakeAuthNotifier extends ChangeNotifier implements IAuthNotifier {
  _FakeAuthNotifier({bool authenticated = false})
    : _authenticated = authenticated;

  bool _authenticated;

  void authenticate() {
    _authenticated = true;
    notifyListeners();
  }

  @override
  bool get isAuthenticated => _authenticated;

  @override
  UserRole get userRole => _authenticated ? UserRole.regular : UserRole.guest;
}

class _TestPages extends AppRouterPages {
  const _TestPages();

  Widget _page(String text) => Scaffold(body: Center(child: Text(text)));

  @override
  Widget login() => _page('LOGIN');

  @override
  Widget home() => _page('HOME');

  @override
  Widget orders() => _page('ORDERS');

  @override
  Widget refundHistory() => _page('REFUNDS');

  @override
  Widget orderDetail(int orderId) => _page('ORDER $orderId');

  @override
  Widget notFound() => _page('NOT FOUND');

  @override
  Widget error() => _page('ERROR');
}
