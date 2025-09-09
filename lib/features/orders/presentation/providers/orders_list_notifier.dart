import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/orders_usecases.dart';
import 'order_states.dart';

/// Notifier cho danh sách orders
class OrdersListNotifier extends StateNotifier<OrdersListState> {
  final GetUserOrdersUseCase _getUserOrdersUseCase;

  OrdersListNotifier(this._getUserOrdersUseCase) : super(const OrdersListState());

  /// Lấy danh sách đơn hàng của người dùng
  Future<void> getUserOrders() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _getUserOrdersUseCase();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (orders) => state = state.copyWith(
        isLoading: false,
        orders: orders,
        errorMessage: null,
      ),
    );
  }

  /// Refresh danh sách orders
  Future<void> refreshOrders() async {
    await getUserOrders();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Thêm order mới vào đầu danh sách
  void addOrder(OrderEntity order) {
    final updatedOrders = [order, ...state.orders];
    state = state.copyWith(orders: updatedOrders);
  }

  /// Xóa order khỏi danh sách
  void removeOrder(int orderId) {
    final updatedOrders = state.orders.where((order) => order.id != orderId).toList();
    state = state.copyWith(orders: updatedOrders);
  }
}
