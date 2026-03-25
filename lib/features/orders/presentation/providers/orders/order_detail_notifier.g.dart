// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier cho chi tiết order

@ProviderFor(OrderDetail)
final orderDetailProvider = OrderDetailFamily._();

/// Notifier cho chi tiết order
final class OrderDetailProvider
    extends $AsyncNotifierProvider<OrderDetail, OrderEntity?> {
  /// Notifier cho chi tiết order
  OrderDetailProvider._({
    required OrderDetailFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'orderDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orderDetailHash();

  @override
  String toString() {
    return r'orderDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OrderDetail create() => OrderDetail();

  @override
  bool operator ==(Object other) {
    return other is OrderDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orderDetailHash() => r'4fbebcbedac43095a58a2831c3337b09e563aa09';

/// Notifier cho chi tiết order

final class OrderDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          OrderDetail,
          AsyncValue<OrderEntity?>,
          OrderEntity?,
          FutureOr<OrderEntity?>,
          num
        > {
  OrderDetailFamily._()
    : super(
        retry: null,
        name: r'orderDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier cho chi tiết order

  OrderDetailProvider call(num orderId) =>
      OrderDetailProvider._(argument: orderId, from: this);

  @override
  String toString() => r'orderDetailProvider';
}

/// Notifier cho chi tiết order

abstract class _$OrderDetail extends $AsyncNotifier<OrderEntity?> {
  late final _$args = ref.$arg as num;
  num get orderId => _$args;

  FutureOr<OrderEntity?> build(num orderId);
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
    element.handleCreate(ref, () => build(_$args));
  }
}
