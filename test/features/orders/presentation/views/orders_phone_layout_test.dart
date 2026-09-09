import 'package:delivery_app/features/orders/application/orders_list_state.dart';
import 'package:delivery_app/features/orders/application/order_detail_state.dart';
import 'package:delivery_app/features/orders/application/order_tracking_state.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/presentation/views/orders_list_view.dart';
import 'package:delivery_app/features/orders/presentation/views/order_detail_view.dart';
import 'package:delivery_app/features/orders/presentation/views/order_tracking_view.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  for (final locale in [const Locale('vi'), const Locale('en')]) {
    testWidgets('compact list respects dark theme and $locale title', (
      tester,
    ) async {
      final theme = ThemeData.dark();
      await pumpTestApp(
        tester,
        theme: theme,
        locale: locale,
        viewport: const Size(320, 700),
        child: OrdersListView(
          state: const OrdersListViewState(isLoading: false),
          onIntent: (_) {},
        ),
      );
      await tester.pumpAndSettle();
      final scaffold = tester.widget<Scaffold>(
        find.descendant(
          of: find.byType(OrdersListView),
          matching: find.byType(Scaffold),
        ),
      );
      expect(scaffold.backgroundColor, theme.scaffoldBackgroundColor);
      expect(find.text(S.current.orders), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
  for (final status in [OrderStatus.cancelled, OrderStatus.shipperNotFound]) {
    testWidgets(
      'terminal $status does not expose live tracking or cancellation',
      (tester) async {
        await pumpTestApp(
          tester,
          child: OrderDetailView(
            orderId: 601,
            state: OrderDetailViewState(
              isLoading: false,
              order: buildOrder(
                status: status,
                rawStatus: status == OrderStatus.cancelled
                    ? 'CANCELLED'
                    : 'SHIPPER_NOT_FOUND',
              ),
            ),
            tracking: const SizedBox(key: Key('real_map')),
            onIntent: (_) {},
          ),
        );
        expect(find.byKey(const Key('real_map')), findsNothing);
        expect(find.text('Hủy đơn hàng'), findsNothing);
        expect(find.text('Chờ nhận đơn'), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }
  testWidgets('phone list has compact header and preserves tab back wiring', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      child: OrdersListView(
        state: const OrdersListViewState(isLoading: false),
        showBackButton: false,
        onIntent: (_) {},
      ),
    );
    expect(find.byKey(const Key('orders_back')), findsNothing);
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.text(S.current.orders),
      ),
      findsOneWidget,
    );
    expect(find.byKey(const Key('orders_refund_history')), findsOneWidget);
  });

  testWidgets('detail puts live tracking before the timeline', (tester) async {
    await pumpTestApp(
      tester,
      child: OrderDetailView(
        orderId: 601,
        state: OrderDetailViewState(isLoading: false, order: buildOrder()),
        tracking: const SizedBox(height: 40, key: Key('real_map')),
        onIntent: (_) {},
      ),
    );
    expect(
      tester.getTopLeft(find.byKey(const Key('real_map'))).dy,
      lessThan(tester.getTopLeft(find.text('Chờ nhận đơn')).dy),
    );
    expect(find.byKey(const Key('order_status_hero')), findsOneWidget);
  });

  testWidgets('tracking keeps platform map first and exposes live phase', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      child: OrderTrackingView(
        state: const OrderTrackingViewState(
          phase: OrderTrackingPhase.delivering,
        ),
        map: const SizedBox(height: 80, key: Key('real_map')),
        onIntent: (_) {},
      ),
    );
    expect(
      tester.getTopLeft(find.byKey(const Key('real_map'))).dy,
      lessThan(tester.getTopLeft(find.text('Đơn hàng đang được giao')).dy),
    );
  });
}
