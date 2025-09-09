import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/orders_usecases.dart';

/// State cho Orders Provider
class OrdersState {
  final bool isLoading;
  final List<OrderEntity> orders;
  final String? errorMessage;
  final OrderEntity? selectedOrder;

  const OrdersState({
    this.isLoading = false,
    this.orders = const [],
    this.errorMessage,
    this.selectedOrder,
  });

  OrdersState copyWith({
    bool? isLoading,
    List<OrderEntity>? orders,
    String? errorMessage,
    OrderEntity? selectedOrder,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      errorMessage: errorMessage,
      selectedOrder: selectedOrder ?? this.selectedOrder,
    );
  }
}

/// Provider cho quản lý orders
class OrdersNotifier extends StateNotifier<OrdersState> {
  final GetUserOrdersUseCase _getUserOrdersUseCase;
  final GetOrderByIdUseCase _getOrderByIdUseCase;
  final CreateOrderUseCase _createOrderUseCase;
  final UpdateOrderStatusUseCase _updateOrderStatusUseCase;
  final CancelOrderUseCase _cancelOrderUseCase;
  final GetOrdersByStatusUseCase _getOrdersByStatusUseCase;
  final GetOrderHistoryUseCase _getOrderHistoryUseCase;

  OrdersNotifier({
    required GetUserOrdersUseCase getUserOrdersUseCase,
    required GetOrderByIdUseCase getOrderByIdUseCase,
    required CreateOrderUseCase createOrderUseCase,
    required UpdateOrderStatusUseCase updateOrderStatusUseCase,
    required CancelOrderUseCase cancelOrderUseCase,
    required GetOrdersByStatusUseCase getOrdersByStatusUseCase,
    required GetOrderHistoryUseCase getOrderHistoryUseCase,
  })  : _getUserOrdersUseCase = getUserOrdersUseCase,
        _getOrderByIdUseCase = getOrderByIdUseCase,
        _createOrderUseCase = createOrderUseCase,
        _updateOrderStatusUseCase = updateOrderStatusUseCase,
        _cancelOrderUseCase = cancelOrderUseCase,
        _getOrdersByStatusUseCase = getOrdersByStatusUseCase,
        _getOrderHistoryUseCase = getOrderHistoryUseCase,
        super(const OrdersState());

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

  /// Lấy chi tiết đơn hàng theo ID
  Future<void> getOrderById(int orderId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    final result = await _getOrderByIdUseCase(orderId);
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (order) => state = state.copyWith(
        isLoading: false,
        selectedOrder: order,
        errorMessage: null,
      ),
    );
  }

  /// Tạo đơn hàng mới
  Future<bool> createOrder(OrderEntity order) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    final result = await _createOrderUseCase(order);
    
    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (createdOrder) {
        // Thêm order mới vào danh sách
        final updatedOrders = [createdOrder, ...state.orders];
        state = state.copyWith(
          isLoading: false,
          orders: updatedOrders,
          errorMessage: null,
        );
        return true;
      },
    );
  }

  /// Cập nhật trạng thái đơn hàng
  Future<bool> updateOrderStatus(int orderId, OrderStatus status) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    final result = await _updateOrderStatusUseCase(
      UpdateOrderStatusParams(orderId: orderId, status: status),
    );
    
    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (updatedOrder) {
        // Update order trong danh sách
        final updatedOrders = state.orders.map((order) {
          return order.id == orderId ? updatedOrder : order;
        }).toList();
        
        state = state.copyWith(
          isLoading: false,
          orders: updatedOrders,
          selectedOrder: state.selectedOrder?.id == orderId ? updatedOrder : state.selectedOrder,
          errorMessage: null,
        );
        return true;
      },
    );
  }

  /// Hủy đơn hàng
  Future<bool> cancelOrder(int orderId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    final result = await _cancelOrderUseCase(orderId);
    
    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (success) {
        if (success) {
          // Update trạng thái thành cancelled
          return updateOrderStatus(orderId, OrderStatus.cancelled);
        }
        return false;
      },
    );
  }

  /// Lấy danh sách đơn hàng theo trạng thái
  Future<void> getOrdersByStatus(OrderStatus status) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    final result = await _getOrdersByStatusUseCase(status);
    
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

  /// Lấy lịch sử đơn hàng với phân trang
  Future<void> getOrderHistory({int page = 1, int limit = 10}) async {
    final isFirstPage = page == 1;
    
    if (isFirstPage) {
      state = state.copyWith(isLoading: true, errorMessage: null);
    }
    
    final result = await _getOrderHistoryUseCase(
      GetOrderHistoryParams(page: page, limit: limit),
    );
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (orders) {
        final updatedOrders = isFirstPage 
          ? orders 
          : [...state.orders, ...orders];
        
        state = state.copyWith(
          isLoading: false,
          orders: updatedOrders,
          errorMessage: null,
        );
      },
    );
  }

  /// Clear selected order
  void clearSelectedOrder() {
    state = state.copyWith(selectedOrder: null);
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
