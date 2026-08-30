import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/core/contracts/cart_port_provider.dart';
import 'package:delivery_app/features/orders/application/order_reorder_builder.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/di/order_providers.dart';
import 'package:delivery_app/features/orders/application/state/orders/orders_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'orders_list_effect.dart';
import 'orders_list_intent.dart';
import 'orders_list_state.dart';

final ordersListViewModelProvider =
    NotifierProvider<OrdersListViewModel, OrdersListViewState>(
      OrdersListViewModel.new,
    );

/// Typed interaction boundary for historical orders.
///
/// It adapts the existing paginated orders provider while centralising filters,
/// cancellation, reorder cart writes and navigation effects outside the view.
class OrdersListViewModel extends Notifier<OrdersListViewState> {
  int _nextEffectId = 0;
  bool _isLoadingMore = false;
  int? _actionOrderId;

  @override
  OrdersListViewState build() {
    final initial = ref.read(ordersListProvider);
    ref.listen<AsyncValue<List<OrderEntity>>>(ordersListProvider, (_, next) {
      if (ref.mounted) _publish(next);
    });
    return _fromOrders(initial);
  }

  Future<void> dispatch(OrdersListIntent intent) async {
    switch (intent) {
      case OrdersListRefreshRequested() || OrdersListRetryRequested():
        await _refresh();
      case OrdersListLoadMoreRequested():
        await _loadMore();
      case OrdersListFilterChanged(:final filter):
        state = state.copyWith(filter: filter);
      case OrdersListBackRequested():
        _emit(const OrdersListNavigateBack());
      case OrdersListRefundHistoryRequested():
        _emit(const OrdersListNavigateToRefundHistory());
      case OrdersListDetailsRequested(:final orderId):
        if (_findOrder(orderId) != null) {
          _emit(OrdersListNavigateToDetails(orderId));
        }
      case OrdersListCancelRequested(:final orderId):
        final order = _findOrder(orderId);
        if (order != null && order.canCancel && _actionOrderId == null) {
          _emit(OrdersListConfirmCancel(_toViewData(order)));
        }
      case OrdersListCancelConfirmed(:final orderId):
        await _cancel(orderId);
      case OrdersListReorderRequested(:final orderId):
        await _reorder(orderId);
      case OrdersListEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _refresh() async {
    ref.invalidate(ordersListProvider);
    try {
      await ref.read(ordersListProvider.future);
    } catch (_) {
      // The provider's error state is the durable retry surface.
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || state.isLoading || state.hasError) return;
    _isLoadingMore = true;
    state = state.copyWith(isLoadingMore: true);
    try {
      await ref.read(ordersListProvider.notifier).loadMoreOrders();
    } finally {
      _isLoadingMore = false;
      if (ref.mounted) state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<void> _cancel(int orderId) async {
    final order = _findOrder(orderId);
    if (order == null || !order.canCancel || _actionOrderId != null) return;
    _actionOrderId = orderId;
    state = state.copyWith(actionOrderId: orderId);
    try {
      final result = await ref
          .read(cancelOrderUseCaseProvider)
          .call(orderId, null);
      if (!ref.mounted) return;
      result.fold((failure) => _emit(OrdersListShowMessage(failure.message)), (
        success,
      ) {
        if (!success) {
          _emit(const OrdersListShowMessage('Không thể hủy đơn hàng.'));
          return;
        }
        ref.invalidate(ordersListProvider);
        _emit(
          const OrdersListShowMessage('Đơn hàng đã được hủy.', isSuccess: true),
        );
      });
    } catch (_) {
      if (ref.mounted) {
        _emit(const OrdersListShowMessage('Không thể hủy đơn hàng.'));
      }
    } finally {
      _actionOrderId = null;
      if (ref.mounted) state = state.copyWith(clearActionOrder: true);
    }
  }

  Future<void> _reorder(int orderId) async {
    final order = _findOrder(orderId);
    if (order == null || order.canTrackingRealtime || _actionOrderId != null) {
      return;
    }
    _actionOrderId = orderId;
    state = state.copyWith(actionOrderId: orderId);
    try {
      final items = buildReorderCartItems(order);
      final commands = ref.read(cartCommandsPortProvider);
      await commands.clear();
      for (final item in items) {
        await commands.addLine(item);
      }
      if (ref.mounted) _emit(const OrdersListNavigateToCart());
    } on FormatException {
      if (ref.mounted) {
        _emit(const OrdersListShowMessage('Không thể đặt lại đơn này.'));
      }
    } catch (_) {
      if (ref.mounted) {
        _emit(const OrdersListShowMessage('Không thể đặt lại đơn này.'));
      }
    } finally {
      _actionOrderId = null;
      if (ref.mounted) state = state.copyWith(clearActionOrder: true);
    }
  }

  OrderEntity? _findOrder(int orderId) => ref
      .read(ordersListProvider)
      .value
      ?.where((order) => order.id == orderId)
      .firstOrNull;

  void _publish(AsyncValue<List<OrderEntity>> source) {
    state = _fromOrders(
      source,
      filter: state.filter,
      effects: state.effects,
      isLoadingMore: _isLoadingMore,
      actionOrderId: _actionOrderId,
    );
  }

  OrdersListViewState _fromOrders(
    AsyncValue<List<OrderEntity>> source, {
    OrdersListFilter filter = OrdersListFilter.all,
    List<UiEffectEnvelope<OrdersListEffect>> effects = const [],
    bool isLoadingMore = false,
    int? actionOrderId,
  }) => source.when(
    loading: () => OrdersListViewState(
      filter: filter,
      isLoading: true,
      isLoadingMore: isLoadingMore,
      actionOrderId: actionOrderId,
      effects: effects,
    ),
    error: (_, _) => OrdersListViewState(
      filter: filter,
      isLoading: false,
      hasError: true,
      isLoadingMore: isLoadingMore,
      actionOrderId: actionOrderId,
      effects: effects,
    ),
    data: (orders) => OrdersListViewState(
      items: orders
          .where((order) => order.id != null)
          .map(_toViewData)
          .toList(growable: false),
      filter: filter,
      isLoading: false,
      isLoadingMore: isLoadingMore,
      actionOrderId: actionOrderId,
      effects: effects,
    ),
  );

  OrdersListItemViewData _toViewData(OrderEntity order) {
    final statusTone = switch (order.status) {
      OrderStatus.pending => OrdersListStatusTone.pending,
      OrderStatus.delivering => OrdersListStatusTone.delivering,
      OrderStatus.delivered => OrdersListStatusTone.delivered,
      OrderStatus.cancelled => OrdersListStatusTone.cancelled,
      OrderStatus.shipperNotFound => OrdersListStatusTone.noDriver,
    };
    final isActive =
        order.status == OrderStatus.pending ||
        order.status == OrderStatus.delivering;
    return OrdersListItemViewData(
      id: order.id!,
      restaurantName: order.restaurantName?.trim().isNotEmpty == true
          ? order.restaurantName!.trim()
          : 'Nhà hàng',
      createdAt: order.createdAt,
      totalAmount: order.totalAmount,
      itemCount: order.totalItems,
      statusTone: statusTone,
      statusLabel: order.statusText,
      isActive: isActive,
      canCancel: order.canCancel,
      canReorder: !isActive,
    );
  }

  void _emit(OrdersListEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
