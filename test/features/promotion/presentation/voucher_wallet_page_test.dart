import 'package:delivery_app/features/cart/di/checkout_voucher_provider.dart';
import 'package:delivery_app/features/promotion/presentation/pages/voucher_wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final brightness in Brightness.values) {
    testWidgets(
      'voucher wallet native empty state and filters in $brightness',
      (tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              checkoutVoucherWalletProvider.overrideWith((ref) async => []),
            ],
            child: MaterialApp(
              theme: ThemeData(brightness: brightness),
              home: const VoucherWalletPage(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Chưa có mã ưu đãi nào'), findsOneWidget);
        await tester.tap(find.text('Freeship'));
        await tester.pumpAndSettle();
        expect(find.text('Chưa có mã ưu đãi nào'), findsOneWidget);
        expect(tester.widget<AppBar>(find.byType(AppBar)).toolbarHeight, 52);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
