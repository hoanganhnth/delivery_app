import '../../../domain/entities/order_entity.dart';

/// State cho danh sách orders
class OrdersListState {
  final bool isLoading;
  final List<OrderEntity> orders;
  final String? errorMessage;

  const OrdersListState({
    this.isLoading = false,
    this.orders = const [],
    this.errorMessage,
  });

  OrdersListState copyWith({
    bool? isLoading,
    List<OrderEntity>? orders,
    String? errorMessage,
  }) {
    return OrdersListState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      errorMessage: errorMessage,
    );
  }
}

/// State cho chi tiết order
class OrderDetailState {
  final bool isLoading;
  final OrderEntity? order;
  final String? errorMessage;

  const OrderDetailState({
    this.isLoading = false,
    this.order,
    this.errorMessage,
  });

  OrderDetailState copyWith({
    bool? isLoading,
    OrderEntity? order,
    String? errorMessage,
  }) {
    return OrderDetailState(
      isLoading: isLoading ?? this.isLoading,
      order: order ?? this.order,
      errorMessage: errorMessage,
    );
  }
}
