import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/contracts/cart_contract.dart';
import 'package:delivery_app/core/contracts/cart_port_provider.dart';
import 'package:delivery_app/features/orders/application/order_detail_effect.dart';
import 'package:delivery_app/features/orders/application/order_detail_intent.dart';
import 'package:delivery_app/features/orders/application/order_detail_state.dart';
import 'package:delivery_app/features/orders/application/order_detail_view_model.dart';
import 'package:delivery_app/features/orders/application/restaurant_rating_submission.dart';
import 'package:delivery_app/features/orders/domain/entities/order_creation_command.dart';
import 'package:delivery_app/features/orders/di/restaurant_rating_submission_provider.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:delivery_app/features/orders/domain/repositories/order_repository.dart';
import 'package:delivery_app/features/orders/di/order_providers.dart';
import 'package:delivery_app/features/orders/application/state/orders/order_detail_notifier.dart';
import 'package:delivery_app/features/orders/di/refund_status_providers.dart';
import 'package:delivery_app/features/orders/presentation/views/order_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  test(
    'detail ViewModel owns cancellation, cart writes and rating submission',
    () async {
      final repository = _FakeOrderRepository(
        order: buildOrder(
          status: OrderStatus.delivered,
          rawStatus: 'DELIVERED',
        ),
      );
      final cart = _FakeCartCommands();
      final ratings = _FakeRatingSubmission();
      final container = ProviderContainer(
        overrides: [
          orderRepositoryProvider.overrideWithValue(repository),
          cartCommandsPortProvider.overrideWithValue(cart),
          restaurantRatingSubmissionProvider.overrideWithValue(ratings),
          customerRefundStatusPortProvider.overrideWithValue(
            const _FakeRefundStatusPort(),
          ),
        ],
      );
      addTearDown(container.dispose);
      final provider = orderDetailViewModelProvider(601);
      final subscription = container.listen(provider, (_, _) {});
      addTearDown(subscription.close);

      await container.read(orderDetailProvider(601).future);
      await Future<void>.delayed(Duration.zero);
      final notifier = container.read(provider.notifier);

      await notifier.dispatch(
        const OrderDetailRatingSubmitted(
          rating: 5,
          comment: '  Chuẩn bị món rất tốt  ',
        ),
      );
      expect(ratings.submissions, hasLength(1));
      expect(ratings.submissions.single.orderId, 601);
      expect(ratings.submissions.single.rating, 5);
      expect(ratings.submissions.single.comment, 'Chuẩn bị món rất tốt');

      await notifier.dispatch(const OrderDetailReorderRequested());
      expect(cart.clearCalls, 1);
      expect(cart.added, hasLength(1));
      expect(
        container.read(provider).effects.map((entry) => entry.effect),
        contains(isA<OrderDetailNavigateToCart>()),
      );

      repository.order = buildOrder();
      await notifier.dispatch(const OrderDetailRefreshRequested());
      await Future<void>.delayed(Duration.zero);
      await notifier.dispatch(const OrderDetailCancelRequested());
      expect(
        container.read(provider).effects.map((entry) => entry.effect),
        contains(isA<OrderDetailConfirmCancellation>()),
      );
      await notifier.dispatch(const OrderDetailCancelConfirmed('  Đổi ý  '));
      expect(repository.cancelReasons, ['Đổi ý']);
    },
  );

  testWidgets(
    'detail view emits typed actions without Riverpod or navigation',
    (tester) async {
      final intents = <OrderDetailIntent>[];
      await pumpTestApp(
        tester,
        child: OrderDetailView(
          orderId: 601,
          state: OrderDetailViewState(
            isLoading: false,
            order: buildOrder(
              status: OrderStatus.delivered,
              rawStatus: 'DELIVERED',
            ),
          ),
          tracking: const SizedBox(key: Key('tracking_adapter')),
          onIntent: intents.add,
        ),
      );

      await tester.tap(find.byTooltip('Quay lại'));
      await tester.ensureVisible(find.text('Đánh giá Quán ăn'));
      await tester.tap(find.text('Đánh giá Quán ăn'));
      await tester.ensureVisible(find.text('Đặt lại đơn này'));
      await tester.tap(find.text('Đặt lại đơn này'));

      expect(intents[0], isA<OrderDetailBackRequested>());
      expect(intents[1], isA<OrderDetailRatingRequested>());
      expect(intents[2], isA<OrderDetailReorderRequested>());
    },
  );
}

class _FakeOrderRepository implements OrderRepository {
  _FakeOrderRepository({required this.order});

  OrderEntity order;
  final List<String?> cancelReasons = [];

  @override
  Future<Either<Failure, bool>> cancelOrder(
    int orderId, {
    String? reason,
  }) async {
    cancelReasons.add(reason);
    return const Right(true);
  }

  @override
  Future<Either<Failure, OrderEntity>> createOrder(
    OrderCreationCommand request,
  ) => throw UnimplementedError();

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(num orderId) async =>
      Right(order);

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders({
    int page = 0,
    int size = 20,
  }) async => Right([order]);
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

class _FakeRatingSubmission implements RestaurantRatingSubmissionPort {
  final List<RestaurantRatingSubmission> submissions = [];

  @override
  Future<void> submit({
    required int restaurantId,
    required RestaurantRatingSubmission submission,
  }) async => submissions.add(submission);
}

class _FakeRefundStatusPort implements CustomerRefundStatusPort {
  const _FakeRefundStatusPort();

  @override
  Future<List<RefundCaseEntity>> getMyRefundCases({int limit = 50}) async => [];
}
