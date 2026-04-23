// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(orderApiService)
final orderApiServiceProvider = OrderApiServiceProvider._();

final class OrderApiServiceProvider
    extends
        $FunctionalProvider<OrderApiService, OrderApiService, OrderApiService>
    with $Provider<OrderApiService> {
  OrderApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderApiServiceHash();

  @$internal
  @override
  $ProviderElement<OrderApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderApiService create(Ref ref) {
    return orderApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderApiService>(value),
    );
  }
}

String _$orderApiServiceHash() => r'f31b1b69c2b524c6c3852438735c0fbb406d9a3e';

@ProviderFor(orderRemoteDataSource)
final orderRemoteDataSourceProvider = OrderRemoteDataSourceProvider._();

final class OrderRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          OrderRemoteDataSource,
          OrderRemoteDataSource,
          OrderRemoteDataSource
        >
    with $Provider<OrderRemoteDataSource> {
  OrderRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<OrderRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OrderRemoteDataSource create(Ref ref) {
    return orderRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderRemoteDataSource>(value),
    );
  }
}

String _$orderRemoteDataSourceHash() =>
    r'8e69436d9c716e68b18ea006d525611ba0ba1520';

@ProviderFor(mockOrderService)
final mockOrderServiceProvider = MockOrderServiceProvider._();

final class MockOrderServiceProvider
    extends
        $FunctionalProvider<
          MockOrderService,
          MockOrderService,
          MockOrderService
        >
    with $Provider<MockOrderService> {
  MockOrderServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockOrderServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockOrderServiceHash();

  @$internal
  @override
  $ProviderElement<MockOrderService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MockOrderService create(Ref ref) {
    return mockOrderService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockOrderService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockOrderService>(value),
    );
  }
}

String _$mockOrderServiceHash() => r'f28faf34cc961cd49f7170024c301ae9f79900c3';

@ProviderFor(orderRepository)
final orderRepositoryProvider = OrderRepositoryProvider._();

final class OrderRepositoryProvider
    extends
        $FunctionalProvider<OrderRepository, OrderRepository, OrderRepository>
    with $Provider<OrderRepository> {
  OrderRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderRepositoryHash();

  @$internal
  @override
  $ProviderElement<OrderRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderRepository create(Ref ref) {
    return orderRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderRepository>(value),
    );
  }
}

String _$orderRepositoryHash() => r'82b6c64e2d7692084b3cf59f9eaf07ab95955dcb';

@ProviderFor(getUserOrdersUseCase)
final getUserOrdersUseCaseProvider = GetUserOrdersUseCaseProvider._();

final class GetUserOrdersUseCaseProvider
    extends
        $FunctionalProvider<
          GetUserOrdersUseCase,
          GetUserOrdersUseCase,
          GetUserOrdersUseCase
        >
    with $Provider<GetUserOrdersUseCase> {
  GetUserOrdersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserOrdersUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserOrdersUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetUserOrdersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetUserOrdersUseCase create(Ref ref) {
    return getUserOrdersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserOrdersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserOrdersUseCase>(value),
    );
  }
}

String _$getUserOrdersUseCaseHash() =>
    r'77863144a2ca8e6f564ded9e3e570e3febfe3cba';

@ProviderFor(getOrderByIdUseCase)
final getOrderByIdUseCaseProvider = GetOrderByIdUseCaseProvider._();

final class GetOrderByIdUseCaseProvider
    extends
        $FunctionalProvider<
          GetOrderByIdUseCase,
          GetOrderByIdUseCase,
          GetOrderByIdUseCase
        >
    with $Provider<GetOrderByIdUseCase> {
  GetOrderByIdUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getOrderByIdUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getOrderByIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetOrderByIdUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetOrderByIdUseCase create(Ref ref) {
    return getOrderByIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetOrderByIdUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetOrderByIdUseCase>(value),
    );
  }
}

String _$getOrderByIdUseCaseHash() =>
    r'0472cb4b0a22684ee3dbbed0640b3b6df4c5c7a4';

@ProviderFor(createOrderUseCase)
final createOrderUseCaseProvider = CreateOrderUseCaseProvider._();

final class CreateOrderUseCaseProvider
    extends
        $FunctionalProvider<
          CreateOrderUseCase,
          CreateOrderUseCase,
          CreateOrderUseCase
        >
    with $Provider<CreateOrderUseCase> {
  CreateOrderUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createOrderUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createOrderUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateOrderUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateOrderUseCase create(Ref ref) {
    return createOrderUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateOrderUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateOrderUseCase>(value),
    );
  }
}

String _$createOrderUseCaseHash() =>
    r'9ba79bae5b1270a1f637eda9d63c198e67f0ecc7';

@ProviderFor(cancelOrderUseCase)
final cancelOrderUseCaseProvider = CancelOrderUseCaseProvider._();

final class CancelOrderUseCaseProvider
    extends
        $FunctionalProvider<
          CancelOrderUseCase,
          CancelOrderUseCase,
          CancelOrderUseCase
        >
    with $Provider<CancelOrderUseCase> {
  CancelOrderUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cancelOrderUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cancelOrderUseCaseHash();

  @$internal
  @override
  $ProviderElement<CancelOrderUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CancelOrderUseCase create(Ref ref) {
    return cancelOrderUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CancelOrderUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CancelOrderUseCase>(value),
    );
  }
}

String _$cancelOrderUseCaseHash() =>
    r'72d7fe90f45b8e2fadd09ada7d05adbe3a0b3500';
