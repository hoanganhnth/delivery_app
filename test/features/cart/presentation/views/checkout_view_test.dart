import 'dart:convert';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/cart/application/checkout_effect.dart';
import 'package:delivery_app/features/cart/application/checkout_intent.dart';
import 'package:delivery_app/features/cart/application/checkout_preview_gateway.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/features/cart/application/checkout_view_model.dart';
import 'package:delivery_app/features/cart/di/checkout_providers.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/application/cart_notifier.dart';
import 'package:delivery_app/features/cart/presentation/views/checkout_view.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';
import 'package:delivery_app/features/orders/domain/entities/order_creation_command.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/domain/repositories/order_repository.dart';
import 'package:delivery_app/features/orders/di/order_providers.dart';
import 'package:delivery_app/features/user_address/application/address_list_notifier.dart';
import 'package:delivery_app/features/user_address/application/address_store_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  test(
    'CheckoutViewModel validates a server preview before creating an order',
    () async {
      final orders = _FakeOrderRepository();
      final cart = _TestCartNotifier();
      final preview = _FakePreviewGateway(_preview);
      final container = ProviderContainer(
        overrides: [
          cartProvider.overrideWith(() => cart),
          userAddressListProvider.overrideWith(_SelectedAddressNotifier.new),
          checkoutPreviewGatewayProvider.overrideWithValue(preview),
          orderRepositoryProvider.overrideWithValue(orders),
        ],
      );
      addTearDown(container.dispose);
      container.read(checkoutViewModelProvider);
      await container.read(cartProvider.future);

      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutLoadRequested());
      expect(container.read(checkoutViewModelProvider).price?.total, 65000);
      expect(container.read(checkoutViewModelProvider).canPlaceOrder, isTrue);
      expect(preview.requests, isNotEmpty);

      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutNotesChanged('Gọi trước khi giao'));
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());

      expect(orders.lastRequest?.notes, 'Gọi trước khi giao');
      expect(orders.lastRequest?.restaurantId, 201);
      expect(cart.wasCleared, isTrue);
      expect(
        container.read(checkoutViewModelProvider).effects.last.effect,
        const CheckoutOrderPlaced(isSuccess: true),
      );
    },
  );

  test(
    'CheckoutViewModel fails closed and informs the page about unavailable items',
    () async {
      final container = ProviderContainer(
        overrides: [
          cartProvider.overrideWith(_TestCartNotifier.new),
          userAddressListProvider.overrideWith(_SelectedAddressNotifier.new),
          checkoutPreviewGatewayProvider.overrideWithValue(
            _FakePreviewGateway(
              _preview.copyWith(unavailableItemIds: const [301]),
            ),
          ),
          orderRepositoryProvider.overrideWithValue(_FakeOrderRepository()),
        ],
      );
      addTearDown(container.dispose);
      container.read(checkoutViewModelProvider);
      await container.read(cartProvider.future);

      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutLoadRequested());

      final state = container.read(checkoutViewModelProvider);
      expect(state.price, isNull);
      expect(state.canPlaceOrder, isFalse);
      expect(
        state.effects
            .map((envelope) => envelope.effect)
            .whereType<CheckoutShowUnavailableItems>(),
        isNotEmpty,
      );
    },
  );

  test(
    'reuses the pending idempotency key after a retryable create failure',
    () async {
      final orders = _ScriptedOrderRepository([
        const Left(NetworkFailure('timeout')),
        Right(buildOrder()),
      ]);
      final container = ProviderContainer(
        overrides: [
          cartProvider.overrideWith(_TestCartNotifier.new),
          userAddressListProvider.overrideWith(_SelectedAddressNotifier.new),
          checkoutPreviewGatewayProvider.overrideWithValue(
            _FakePreviewGateway(_preview),
          ),
          orderRepositoryProvider.overrideWithValue(orders),
        ],
      );
      addTearDown(container.dispose);
      container.read(checkoutViewModelProvider);
      await container.read(cartProvider.future);
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutLoadRequested());

      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());

      expect(orders.requests, hasLength(2));
      expect(orders.requests.first.idempotencyKey, isNotNull);
      expect(
        orders.requests.last.idempotencyKey,
        orders.requests.first.idempotencyKey,
      );
    },
  );

  test(
    'reuses the pending idempotency key when the server reports an in-flight create',
    () async {
      final orders = _ScriptedOrderRepository([
        const Left(
          ConflictFailure(
            'IDEMPOTENCY_IN_PROGRESS',
            'Yêu cầu đặt đơn đang được xử lý',
          ),
        ),
        Right(buildOrder()),
      ]);
      final container = ProviderContainer(
        overrides: [
          cartProvider.overrideWith(_TestCartNotifier.new),
          userAddressListProvider.overrideWith(_SelectedAddressNotifier.new),
          checkoutPreviewGatewayProvider.overrideWithValue(
            _FakePreviewGateway(_preview),
          ),
          orderRepositoryProvider.overrideWithValue(orders),
        ],
      );
      addTearDown(container.dispose);
      container.read(checkoutViewModelProvider);
      await container.read(cartProvider.future);
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutLoadRequested());

      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());

      expect(orders.requests, hasLength(2));
      expect(orders.requests.first.idempotencyKey, isNotNull);
      expect(
        orders.requests.last.idempotencyKey,
        orders.requests.first.idempotencyKey,
      );
    },
  );

  test(
    'changing an item note invalidates the pending idempotency key',
    () async {
      final cart = _TestCartNotifier();
      final orders = _ScriptedOrderRepository([
        const Left(NetworkFailure('timeout')),
        Right(buildOrder()),
      ]);
      final container = ProviderContainer(
        overrides: [
          cartProvider.overrideWith(() => cart),
          userAddressListProvider.overrideWith(_SelectedAddressNotifier.new),
          checkoutPreviewGatewayProvider.overrideWithValue(
            _FakePreviewGateway(_preview),
          ),
          orderRepositoryProvider.overrideWithValue(orders),
        ],
      );
      addTearDown(container.dispose);
      container.read(checkoutViewModelProvider);
      await container.read(cartProvider.future);
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutLoadRequested());
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());

      cart.replaceCart(buildCart(items: [buildCartItem(notes: 'Ít cay')]));
      await Future<void>.delayed(Duration.zero);
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());

      expect(orders.requests, hasLength(2));
      expect(
        orders.requests.last.idempotencyKey,
        isNot(orders.requests.first.idempotencyKey),
      );
    },
  );

  test(
    'PRICE_CHANGED requires acceptance and submits the fresh quote with a new key',
    () async {
      final orders = _ScriptedOrderRepository([
        Left(
          Failure.conflict('PRICE_CHANGED', 'Giá đã thay đổi', {
            'quote': _wireQuote(_changedPreview),
          }),
        ),
        Right(buildOrder()),
      ]);
      final container = ProviderContainer(
        overrides: [
          cartProvider.overrideWith(_TestCartNotifier.new),
          userAddressListProvider.overrideWith(_SelectedAddressNotifier.new),
          checkoutPreviewGatewayProvider.overrideWithValue(
            _FakePreviewGateway(_preview),
          ),
          orderRepositoryProvider.overrideWithValue(orders),
        ],
      );
      addTearDown(container.dispose);
      container.read(checkoutViewModelProvider);
      await container.read(cartProvider.future);
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutLoadRequested());

      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());
      expect(
        container
            .read(checkoutViewModelProvider)
            .effects
            .map((envelope) => envelope.effect)
            .whereType<CheckoutPriceChanged>(),
        isNotEmpty,
      );

      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPriceChangeAccepted());

      expect(orders.requests, hasLength(2));
      expect(orders.requests.last.quoteId, _changedPreview.quoteId);
      expect(orders.requests.last.idempotencyKey, isNotNull);
      expect(
        orders.requests.last.idempotencyKey,
        isNot(orders.requests.first.idempotencyKey),
      );
    },
  );

  test(
    'QUOTE_EXPIRED refreshes preview and discards the previous idempotency key',
    () async {
      final orders = _ScriptedOrderRepository([
        const Left(ConflictFailure('QUOTE_EXPIRED', 'Báo giá đã hết hạn')),
        Right(buildOrder()),
      ]);
      final container = ProviderContainer(
        overrides: [
          cartProvider.overrideWith(_TestCartNotifier.new),
          userAddressListProvider.overrideWith(_SelectedAddressNotifier.new),
          checkoutPreviewGatewayProvider.overrideWithValue(
            _FakePreviewGateway(_preview),
          ),
          orderRepositoryProvider.overrideWithValue(orders),
        ],
      );
      addTearDown(container.dispose);
      container.read(checkoutViewModelProvider);
      await container.read(cartProvider.future);
      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutLoadRequested());

      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());
      await Future<void>.delayed(Duration.zero);
      expect(
        container
            .read(checkoutViewModelProvider)
            .effects
            .map((envelope) => envelope.effect)
            .whereType<CheckoutQuoteExpired>(),
        isNotEmpty,
      );

      await container
          .read(checkoutViewModelProvider.notifier)
          .dispatch(const CheckoutPlaceOrderRequested());

      expect(orders.requests, hasLength(2));
      expect(
        orders.requests.last.idempotencyKey,
        isNot(orders.requests.first.idempotencyKey),
      );
    },
  );

  testWidgets(
    'checkout view emits typed address, notes and place-order intents',
    (tester) async {
      final intents = <CheckoutIntent>[];
      await pumpTestApp(
        tester,
        child: CheckoutView(
          state: const CheckoutViewState(
            isCartLoading: false,
            restaurantName: 'Bếp test',
            itemCount: 1,
            lines: [
              CheckoutLineViewData(
                menuItemId: 301,
                name: 'Cơm test',
                quantity: 1,
                lineTotal: 50000,
              ),
            ],
            selectedAddress: CheckoutAddressViewData(
              id: 401,
              label: 'Nhà',
              recipientName: 'Khách thử nghiệm',
              phoneNumber: '0900000002',
              fullAddress: '2 Đường Khách, Quận 1',
              isDefault: true,
            ),
            price: CheckoutPriceViewData(
              subtotal: 50000,
              shippingFee: 15000,
              discountAmount: 0,
              total: 65000,
            ),
          ),
          onIntent: intents.add,
        ),
      );

      await tester.tap(find.byKey(const Key('checkout_address_selector')));
      await tester.scrollUntilVisible(
        find.byKey(const Key('checkout_notes')),
        160,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.enterText(
        find.byKey(const Key('checkout_notes')),
        'Không cay',
      );
      await tester.tap(find.byKey(const Key('checkout_place_order')));

      expect(intents[0], isA<CheckoutAddressSelectionRequested>());
      expect(intents[1], isA<CheckoutNotesChanged>());
      expect((intents[1] as CheckoutNotesChanged).notes, 'Không cay');
      expect(intents[2], isA<CheckoutPlaceOrderRequested>());
    },
  );
}

class _TestCartNotifier extends CartNotifier {
  bool wasCleared = false;

  @override
  Future<CartEntity> build() async => buildCart();

  @override
  Future<void> clearCart() async {
    wasCleared = true;
    state = const AsyncData(
      CartEntity(
        items: [],
        currentRestaurantId: null,
        currentRestaurantName: null,
      ),
    );
  }

  void replaceCart(CartEntity cart) {
    state = AsyncData(cart);
  }
}

class _SelectedAddressNotifier extends UserAddressListNotifier {
  @override
  UserAddressListState build() {
    final address = buildAddress();
    return UserAddressListState(addresses: [address], selectedAddress: address);
  }
}

class _FakePreviewGateway implements CheckoutPreviewGateway {
  _FakePreviewGateway(this.response);

  final CheckoutPreviewResponse response;
  final List<CheckoutPreviewRequest> requests = [];

  @override
  Future<CheckoutPreviewResponse> preview(
    CheckoutPreviewRequest request,
  ) async {
    requests.add(request);
    return response;
  }
}

class _FakeOrderRepository implements OrderRepository {
  OrderCreationCommand? lastRequest;

  @override
  Future<Either<Failure, bool>> cancelOrder(
    int orderId, {
    String? reason,
  }) async => const Right(true);

  @override
  Future<Either<Failure, OrderEntity>> createOrder(
    OrderCreationCommand request,
  ) async {
    lastRequest = request;
    return Right(buildOrder());
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(num orderId) async =>
      Right(buildOrder(id: orderId.toInt()));

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders({
    int page = 0,
    int size = 20,
  }) async => const Right([]);
}

class _ScriptedOrderRepository implements OrderRepository {
  _ScriptedOrderRepository(this._results);

  final List<Either<Failure, OrderEntity>> _results;
  final List<OrderCreationCommand> requests = [];

  @override
  Future<Either<Failure, bool>> cancelOrder(
    int orderId, {
    String? reason,
  }) async => const Right(true);

  @override
  Future<Either<Failure, OrderEntity>> createOrder(
    OrderCreationCommand request,
  ) async {
    requests.add(request);
    return _results.removeAt(0);
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(num orderId) async =>
      Right(buildOrder(id: orderId.toInt()));

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders({
    int page = 0,
    int size = 20,
  }) async => const Right([]);
}

final _preview = CheckoutPreviewResponse(
  quoteId: '00000000-0000-0000-0000-000000000001',
  expiresAt: _futureExpiry,
  restaurantId: 201,
  restaurantName: 'Bếp test',
  items: [
    PreviewItemDetail(
      menuItemId: 301,
      menuItemName: 'Cơm test',
      unitPrice: 50000,
      quantity: 1,
      lineTotal: 50000,
    ),
  ],
  subtotal: 50000,
  shippingFee: 15000,
  discountAmount: 0,
  totalPrice: 65000,
  unavailableItemIds: [],
);

final _futureExpiry = DateTime.utc(2099, 1, 1);

final _changedPreview = CheckoutPreviewResponse(
  quoteId: '00000000-0000-0000-0000-000000000002',
  expiresAt: _futureExpiry,
  restaurantId: 201,
  restaurantName: 'Bếp test',
  items: const [
    PreviewItemDetail(
      menuItemId: 301,
      menuItemName: 'Cơm test',
      unitPrice: 60000,
      quantity: 1,
      lineTotal: 60000,
    ),
  ],
  subtotal: 60000,
  shippingFee: 15000,
  discountAmount: 0,
  totalPrice: 75000,
  unavailableItemIds: const [],
);

Map<String, dynamic> _wireQuote(CheckoutPreviewResponse preview) =>
    Map<String, dynamic>.from(jsonDecode(jsonEncode(preview)) as Map);
