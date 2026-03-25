// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier cho danh sách orders

@ProviderFor(OrdersList)
final ordersListProvider = OrdersListProvider._();

/// Notifier cho danh sách orders
final class OrdersListProvider
    extends $AsyncNotifierProvider<OrdersList, List<OrderEntity>> {
  /// Notifier cho danh sách orders
  OrdersListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersListHash();

  @$internal
  @override
  OrdersList create() => OrdersList();
}

String _$ordersListHash() => r'2d500549456c80865a8dae3d6ec30c6810e9b0cd';

/// Notifier cho danh sách orders

abstract class _$OrdersList extends $AsyncNotifier<List<OrderEntity>> {
  FutureOr<List<OrderEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<OrderEntity>>, List<OrderEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<OrderEntity>>, List<OrderEntity>>,
              AsyncValue<List<OrderEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
