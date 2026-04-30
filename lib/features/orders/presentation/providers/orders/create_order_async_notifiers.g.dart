// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_async_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AsyncNotifier cho việc tạo đơn hàng

@ProviderFor(CreateOrder)
final createOrderProvider = CreateOrderProvider._();

/// AsyncNotifier cho việc tạo đơn hàng
final class CreateOrderProvider
    extends $AsyncNotifierProvider<CreateOrder, OrderEntity?> {
  /// AsyncNotifier cho việc tạo đơn hàng
  CreateOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createOrderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createOrderHash();

  @$internal
  @override
  CreateOrder create() => CreateOrder();
}

String _$createOrderHash() => r'7257d40879a1d8237a8bf4ac0c73bf95fa0570d9';

/// AsyncNotifier cho việc tạo đơn hàng

abstract class _$CreateOrder extends $AsyncNotifier<OrderEntity?> {
  FutureOr<OrderEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<OrderEntity?>, OrderEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OrderEntity?>, OrderEntity?>,
              AsyncValue<OrderEntity?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// AsyncNotifier cho việc hủy đơn hàng

@ProviderFor(CancelOrder)
final cancelOrderProvider = CancelOrderProvider._();

/// AsyncNotifier cho việc hủy đơn hàng
final class CancelOrderProvider
    extends $AsyncNotifierProvider<CancelOrder, bool?> {
  /// AsyncNotifier cho việc hủy đơn hàng
  CancelOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cancelOrderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cancelOrderHash();

  @$internal
  @override
  CancelOrder create() => CancelOrder();
}

String _$cancelOrderHash() => r'ec499cc0499486a16babcedb13a40ad96bb0ccd2';

/// AsyncNotifier cho việc hủy đơn hàng

abstract class _$CancelOrder extends $AsyncNotifier<bool?> {
  FutureOr<bool?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool?>, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool?>, bool?>,
              AsyncValue<bool?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
