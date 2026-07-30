import 'dart:async';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/domain/repositories/order_repository.dart';
import 'package:delivery_app/features/orders/presentation/providers/orders/create_order_async_notifiers.dart';
import 'package:delivery_app/features/orders/presentation/providers/orders/order_detail_notifier.dart';
import 'package:delivery_app/features/orders/presentation/providers/orders/order_providers.dart';
import 'package:delivery_app/features/orders/presentation/providers/orders/orders_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/fulfilment_builders.dart';

void main() {
  group('create and cancel order actions', () {
    test('create is single-submit while loading and converges to the server order', () async {
      final repository = _FakeOrderRepository();
      final pending = Completer<Either<Failure, OrderEntity>>();
      repository.createCompleter = pending;
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(createOrderProvider, (_, _) {});
      final notifier = container.read(createOrderProvider.notifier);

      final first = notifier.createOrder(buildCreateOrderRequest());
      final duplicate = await notifier.createOrder(buildCreateOrderRequest());

      expect(duplicate, isNull);
      expect(repository.createCalls, 1);
      expect(container.read(createOrderProvider).isLoading, isTrue);

      pending.complete(Right(buildOrder()));
      expect((await first)?.id, 601);
      expect(container.read(createOrderProvider).value?.id, 601);
    });

    test('create and cancel expose failure then allow retry', () async {
      final repository = _FakeOrderRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(createOrderProvider, (_, _) {});
      container.listen(cancelOrderProvider, (_, _) {});

      repository.createResult = const Left(ServerFailure('Không thể đặt đơn'));
      final createNotifier = container.read(createOrderProvider.notifier);
      expect(await createNotifier.createOrder(buildCreateOrderRequest()), isNull);
      expect(container.read(createOrderProvider).hasError, isTrue);

      repository.createResult = Right(buildOrder());
      expect((await createNotifier.createOrder(buildCreateOrderRequest()))?.id, 601);

      repository.cancelResult = const Left(ServerFailure('Đơn đang được xác nhận'));
      final cancelNotifier = container.read(cancelOrderProvider.notifier);
      expect(await cancelNotifier.cancelOrder(601, reason: 'Đổi ý'), isFalse);
      expect(container.read(cancelOrderProvider).hasError, isTrue);

      repository.cancelResult = const Right(true);
      expect(await cancelNotifier.cancelOrder(601, reason: 'Đổi ý'), isTrue);
      expect(repository.lastCancelReason, 'Đổi ý');
      expect(repository.cancelCalls, 2);
    });
  });

  group('orders list and detail', () {
    test('paginates, preserves rows on load-more error and retries the same page', () async {
      final repository = _FakeOrderRepository();
      repository.pageResults[0] = Right(
        List.generate(20, (index) => buildOrder(id: 600 + index)),
      );
      repository.pageResults[1] = const Left(NetworkFailure('Mất trang kế'));
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(ordersListProvider, (_, _) {});

      final initial = await container.read(ordersListProvider.future);
      expect(initial, hasLength(20));
      final notifier = container.read(ordersListProvider.notifier);
      await notifier.loadMoreOrders();
      expect(container.read(ordersListProvider).value, hasLength(20));

      repository.pageResults[1] = Right([buildOrder(id: 700)]);
      await notifier.loadMoreOrders();
      expect(container.read(ordersListProvider).value, hasLength(21));
      expect(repository.requestedPages, [0, 1, 1]);

      notifier.removeOrder(700);
      expect(container.read(ordersListProvider).value, hasLength(20));
      notifier.addOrder(buildOrder(id: 800));
      expect(container.read(ordersListProvider).value!.first.id, 800);
    });

    test('detail failure remains observable and refresh retries', () async {
      final repository = _FakeOrderRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      final subscription = container.listen(
        orderDetailProvider(601),
        (_, _) {},
      );
      addTearDown(subscription.close);

      expect(
        (await container.read(orderDetailProvider(601).future))?.id,
        601,
      );

      repository.detailResult = const Left(
        ServerFailure('Không tải được chi tiết'),
      );
      await container.read(orderDetailProvider(601).notifier).refresh();
      expect(container.read(orderDetailProvider(601)).hasError, isTrue);
      expect(
        container.read(orderDetailProvider(601)).error,
        isA<ServerFailure>(),
      );

      repository.detailResult = Right(buildOrder());
      await container.read(orderDetailProvider(601).notifier).refresh();
      expect(container.read(orderDetailProvider(601)).value?.id, 601);
      expect(repository.detailCalls, 3);
    });
  });
}

ProviderContainer _container(_FakeOrderRepository repository) {
  return ProviderContainer(
    overrides: [orderRepositoryProvider.overrideWithValue(repository)],
  );
}

class _FakeOrderRepository implements OrderRepository {
  final Map<int, Either<Failure, List<OrderEntity>>> pageResults = {};
  final List<int> requestedPages = [];
  Either<Failure, OrderEntity> detailResult = Right(buildOrder());
  Either<Failure, OrderEntity> createResult = Right(buildOrder());
  Either<Failure, bool> cancelResult = const Right(true);
  Completer<Either<Failure, OrderEntity>>? createCompleter;
  int createCalls = 0;
  int cancelCalls = 0;
  int detailCalls = 0;
  String? lastCancelReason;

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders({
    int page = 0,
    int size = 20,
  }) async {
    requestedPages.add(page);
    return pageResults[page] ?? const Right([]);
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(num orderId) async {
    detailCalls += 1;
    return detailResult;
  }

  @override
  Future<Either<Failure, OrderEntity>> createOrder(
    CreateOrderRequestDto request,
  ) async {
    createCalls += 1;
    final completer = createCompleter;
    if (completer != null) return completer.future;
    return createResult;
  }

  @override
  Future<Either<Failure, bool>> cancelOrder(
    int orderId, {
    String? reason,
  }) async {
    cancelCalls += 1;
    lastCancelReason = reason;
    return cancelResult;
  }
}
