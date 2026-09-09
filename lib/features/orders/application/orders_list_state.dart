import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:equatable/equatable.dart';

import 'orders_list_effect.dart';
import 'orders_list_intent.dart';

enum OrdersListStatusTone {
  pending,
  delivering,
  delivered,
  cancelled,
  noDriver,
}

final class OrdersListItemViewData extends Equatable {
  const OrdersListItemViewData({
    required this.id,
    required this.restaurantName,
    required this.createdAt,
    required this.totalAmount,
    required this.itemCount,
    required this.statusTone,
    required this.statusLabel,
    required this.isActive,
    required this.canCancel,
    required this.canReorder,
  });

  final int id;
  final String restaurantName;
  final DateTime? createdAt;
  final double totalAmount;
  final int itemCount;
  final OrdersListStatusTone statusTone;
  final String statusLabel;
  final bool isActive;
  final bool canCancel;
  final bool canReorder;

  @override
  List<Object?> get props => [
    id,
    restaurantName,
    createdAt,
    totalAmount,
    itemCount,
    statusTone,
    statusLabel,
    isActive,
    canCancel,
    canReorder,
  ];
}

final class OrdersListViewState extends Equatable {
  const OrdersListViewState({
    this.items = const <OrdersListItemViewData>[],
    this.filter = OrdersListFilter.all,
    this.isLoading = true,
    this.hasError = false,
    this.isLoadingMore = false,
    this.actionOrderId,
    this.effects = const <UiEffectEnvelope<OrdersListEffect>>[],
  });

  final List<OrdersListItemViewData> items;
  final OrdersListFilter filter;
  final bool isLoading;
  final bool hasError;
  final bool isLoadingMore;
  final int? actionOrderId;
  final List<UiEffectEnvelope<OrdersListEffect>> effects;

  List<OrdersListItemViewData> get filteredItems => switch (filter) {
    OrdersListFilter.all => items,
    OrdersListFilter.active =>
      items.where((item) => item.isActive).toList(growable: false),
    OrdersListFilter.completed =>
      items
          .where((item) => item.statusTone == OrdersListStatusTone.delivered)
          .toList(growable: false),
    OrdersListFilter.history =>
      items.where((item) => !item.isActive).toList(growable: false),
  };

  bool get isEmpty => !isLoading && !hasError && filteredItems.isEmpty;

  OrdersListViewState copyWith({
    List<OrdersListItemViewData>? items,
    OrdersListFilter? filter,
    bool? isLoading,
    bool? hasError,
    bool? isLoadingMore,
    int? actionOrderId,
    bool clearActionOrder = false,
    List<UiEffectEnvelope<OrdersListEffect>>? effects,
  }) {
    return OrdersListViewState(
      items: items ?? this.items,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      actionOrderId: clearActionOrder
          ? null
          : (actionOrderId ?? this.actionOrderId),
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    items,
    filter,
    isLoading,
    hasError,
    isLoadingMore,
    actionOrderId,
    effects,
  ];
}
