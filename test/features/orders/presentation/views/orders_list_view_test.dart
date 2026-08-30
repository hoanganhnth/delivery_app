import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/contracts/cart_contract.dart';
import 'package:delivery_app/core/contracts/cart_port_provider.dart';
import 'package:delivery_app/features/orders/application/orders_list_effect.dart';
import 'package:delivery_app/features/orders/application/orders_list_intent.dart';
import 'package:delivery_app/features/orders/application/orders_list_state.dart';
import 'package:delivery_app/features/orders/application/orders_list_view_model.dart';
import 'package:delivery_app/features/orders/domain/entities/order_creation_command.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/domain/repositories/order_repository.dart';
import 'package:delivery_app/features/orders/di/order_providers.dart';
import 'package:delivery_app/features/orders/application/state/orders/orders_list_notifier.dart';
import 'package:delivery_app/features/orders/presentation/views/orders_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  test(
    'OrdersListViewModel owns filters, cancellation and reorder cart writes',
    () async {
      final orders = _FakeOrderRepository();
      final cart = _FakeCartCommands();
      final container = ProviderContainer(
        overrides: [
          orderRepositoryProvider.overrideWithValue(orders),
          cartCommandsPortProvider.overrideWithValue(cart),
        ],
      );
      addTearDown(container.dispose);
      container.read(ordersListViewModelProvider);
      await container.read(ordersListProvider.future);

      final notifier = container.read(ordersListViewModelProvider.notifier);
      expect(container.read(ordersListViewModelProvider).items, hasLength(2));
      await notifier.dispatch(
        const OrdersListFilterChanged(OrdersListFilter.active),
      );
      expect(
        container.read(ordersListViewModelProvider).filteredItems,
        hasLength(1),
      );

      await notifier.dispatch(const OrdersListDetailsRequested(601));
      expect(
        container.read(ordersListViewModelProvider).effects.last.effect,
        const OrdersListNavigateToDetails(601),
      );

      await notifier.dispatch(const OrdersListCancelRequested(601));
      expect(
        container.read(ordersListViewModelProvider).effects.last.effect,
        isA<OrdersListConfirmCancel>(),
      );
      await notifier.dispatch(const OrdersListCancelConfirmed(601));
      expect(orders.cancelledOrderIds, [601]);

      await notifier.dispatch(const OrdersListReorderRequested(602));
      expect(cart.clearCalls, 1);
      expect(cart.added.single.menuItemId, 301);
      expect(
        container.read(ordersListViewModelProvider).effects.last.effect,
        const OrdersListNavigateToCart(),
      );
    },
  );

  testWidgets('orders view emits typed list actions', (tester) async {
    final intents = <OrdersListIntent>[];
    await pumpTestApp(
      tester,
      child: OrdersListView(
        state: const OrdersListViewState(
          isLoading: false,
          items: [
            OrdersListItemViewData(
              id: 601,
              restaurantName: 'Bếp test',
              createdAt: null,
              totalAmount: 65000,
              itemCount: 1,
              statusTone: OrdersListStatusTone.pending,
              statusLabel: 'Chờ giao hàng',
              isActive: true,
              canCancel: true,
              canReorder: false,
            ),
            OrdersListItemViewData(
              id: 602,
              restaurantName: 'Bếp cũ',
              createdAt: null,
              totalAmount: 65000,
              itemCount: 1,
              statusTone: OrdersListStatusTone.delivered,
              statusLabel: 'Thành công',
              isActive: false,
              canCancel: false,
              canReorder: true,
            ),
          ],
        ),
        onIntent: intents.add,
      ),
    );

    await tester.tap(find.byKey(const Key('order_card_601')));
    await tester.tap(find.byKey(const Key('order_cancel_601')));
    await tester.tap(find.byKey(const Key('order_reorder_602')));
    await tester.tap(find.text('Đang xử lý'));
    await tester.tap(find.byKey(const Key('orders_refund_history')));

    expect(intents[0], isA<OrdersListDetailsRequested>());
    expect(intents[1], isA<OrdersListCancelRequested>());
    expect(intents[2], isA<OrdersListReorderRequested>());
    expect(intents[3], isA<OrdersListFilterChanged>());
    expect(intents[4], isA<OrdersListRefundHistoryRequested>());
  });
}

class _FakeCartCommands implements CartCommands {
  int clearCalls = 0;
  final List<CartLineInput> added = [];

  @override
  Future<void> addLine(CartLineInput input) async => added.add(input);

  @override
  Future<void> clear() async => clearCalls += 1;

  @override
  Future<void> removeLine(int menuItemId) async {}

  @override
  Future<void> setQuantity(int menuItemId, int quantity) async {}
}

class _FakeOrderRepository implements OrderRepository {
  final List<int> cancelledOrderIds = [];

  @override
  Future<Either<Failure, bool>> cancelOrder(
    int orderId, {
    String? reason,
  }) async {
    cancelledOrderIds.add(orderId);
    return const Right(true);
  }

  @override
  Future<Either<Failure, OrderEntity>> createOrder(
    OrderCreationCommand request,
  ) async => Right(buildOrder());

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(num orderId) async =>
      Right(buildOrder(id: orderId.toInt()));

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders({
    int page = 0,
    int size = 20,
  }) async => Right([
    buildOrder(id: 601, status: OrderStatus.pending, rawStatus: 'PENDING'),
    buildOrder(id: 602, status: OrderStatus.delivered, rawStatus: 'DELIVERED'),
  ]);
}
