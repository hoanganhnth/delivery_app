import 'dart:async';

import 'package:delivery_app/features/cart/di/checkout_providers.dart';
import 'package:delivery_app/features/cart/di/checkout_voucher_provider.dart';
import 'package:delivery_app/features/promotion/presentation/pages/voucher_wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

CheckoutVoucher voucher([Map<String, dynamic> changes = const {}]) =>
    CheckoutVoucher.fromJson({
      'id': 1,
      'code': 'SHOP20',
      'name': 'Shop offer',
      'rewardType': 'PERCENTAGE',
      'discountValue': 20,
      'creatorType': 'SHOP',
      'scopeType': 'SHOP',
      'scopeRefId': 42,
      'active': true,
      'approvalStatus': 'APPROVED',
      'startTime': '2020-01-01T00:00:00',
      'endTime': '2099-01-02T03:04:00',
      'totalQuantity': 10,
      'usedQuantity': 2,
      'maxDiscountValue': 30000,
      ...changes,
    });

Future<void> wallet(
  WidgetTester tester,
  CheckoutVoucher value, {
  CheckoutVoucherGateway? gateway,
}) async {
  final router = GoRouter(
    initialLocation: '/wallet',
    routes: [
      GoRoute(path: '/wallet', builder: (_, __) => const VoucherWalletPage()),
      GoRoute(
        path: '/restaurants',
        builder: (_, __) => const Scaffold(body: Text('Restaurant list')),
      ),
      GoRoute(
        path: '/restaurants/:restaurantId',
        builder: (_, state) => Scaffold(
          body: Text('Restaurant ${state.pathParameters['restaurantId']}'),
        ),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        checkoutVoucherWalletProvider.overrideWith((ref) async => [value]),
        if (gateway != null)
          checkoutVoucherGatewayProvider.overrideWithValue(gateway),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

class PendingCollection implements CheckoutVoucherGateway {
  int calls = 0;
  final pending = Completer<void>();
  @override
  Future<void> collect(String code) {
    calls++;
    return pending.future;
  }

  @override
  Future<List<CheckoutVoucher>> getWallet() async => [];
  @override
  Future<CheckoutVoucherCapability> getCapability() =>
      throw UnimplementedError();
}

void main() {
  test('model preserves UTC lifecycle and quota contract', () {
    final CheckoutVoucher value = voucher();
    expect(value.startTime, DateTime.utc(2020));
    expect(value.endTime, DateTime.utc(2099, 1, 2, 3, 4));
    expect(value.endTime!.isUtc, isTrue);
    expect(value.active, isTrue);
    expect(value.approvalStatus, 'APPROVED');
    expect(value.totalQuantity, 10);
    expect(value.usedQuantity, 2);
    expect(value.maxDiscountValue, 30000);
    final CheckoutVoucher offset = voucher({
      'endTime': '2099-01-02T10:04:00+07:00',
    });
    expect(offset.endTime, value.endTime);
    expect(value.unavailableReasonAt(value.endTime!), 'Đã hết hạn');
    expect(
      value.unavailableReasonAt(
        value.endTime!.subtract(const Duration(microseconds: 1)),
      ),
      isNull,
    );
  });
  testWidgets('shop wallet shows deadline, scope and discount cap', (
    tester,
  ) async {
    await wallet(tester, voucher());
    expect(find.textContaining('Hạn dùng:'), findsOneWidget);
    expect(find.text('Chỉ áp dụng tại quán #42'), findsOneWidget);
    expect(find.textContaining('30000đ'), findsOneWidget);
    expect(find.text('Áp dụng cho mọi đơn'), findsNothing);
  });
  for (final entry in <String, Map<String, dynamic>>{
    'expired': {'endTime': '2020-01-01T00:00:00'},
    'paused': {'active': false},
    'pending': {'approvalStatus': 'PENDING'},
    'rejected': {'approvalStatus': 'REJECTED'},
    'exhausted': {'usedQuantity': 10},
    'scheduled': {'startTime': '2098-01-01T00:00:00'},
  }.entries) {
    testWidgets('${entry.key} voucher cannot be used', (tester) async {
      await wallet(tester, voucher(entry.value));
      final button = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, 'Dùng ngay'),
      );
      expect(button.onPressed, isNull);
    });
  }
  testWidgets('shop use opens its canonical restaurant detail', (tester) async {
    await wallet(tester, voucher());
    await tester.tap(find.text('Dùng ngay'));
    await tester.pumpAndSettle();
    expect(find.text('Restaurant 42'), findsOneWidget);
  });
  testWidgets('ALL use opens restaurant list', (tester) async {
    await wallet(tester, voucher({'scopeType': 'ALL'}));
    await tester.tap(find.text('Dùng ngay'));
    await tester.pumpAndSettle();
    expect(find.text('Restaurant list'), findsOneWidget);
  });
  testWidgets('keyboard submission cannot duplicate pending collection', (
    tester,
  ) async {
    final gateway = PendingCollection();
    await wallet(tester, voucher(), gateway: gateway);
    await tester.enterText(find.byType(TextField), 'SHOP20');
    final submit = tester
        .widget<TextField>(find.byType(TextField))
        .onSubmitted!;
    submit('SHOP20');
    submit('SHOP20');
    expect(gateway.calls, 1);
    gateway.pending.complete();
    await tester.pumpAndSettle();
  });
}
