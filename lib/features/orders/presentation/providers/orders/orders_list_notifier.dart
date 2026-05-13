import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/order_entity.dart';
import 'order_providers.dart'; // To get usecases if needed, or get through ref.read

part 'orders_list_notifier.g.dart';

/// Notifier cho danh sách orders
@riverpod
class OrdersList extends _$OrdersList {
  int _currentPage = 0;
  bool _hasMore = true;
  static const int _pageSize = 20;

  @override
  FutureOr<List<OrderEntity>> build() async {
    _currentPage = 0;
    _hasMore = true;
    return _fetchOrders();
  }

  Future<List<OrderEntity>> _fetchOrders() async {
    final getUserOrdersUseCase = ref.read(getUserOrdersUseCaseProvider);
    final result = await getUserOrdersUseCase(page: _currentPage, size: _pageSize);
    
    return result.fold(
      (failure) => throw Exception(failure.message),
      (orders) {
        if (orders.length < _pageSize) {
          _hasMore = false;
        }
        return orders;
      },
    );
  }

  /// Lấy danh sách đơn hàng (reset về trang 0)
  Future<void> getUserOrders() async {
    state = const AsyncLoading();
    _currentPage = 0;
    _hasMore = true;
    
    final result = await AsyncValue.guard(() => _fetchOrders());
    state = result;
  }

  /// Load more orders (trang tiếp theo)
  Future<void> loadMoreOrders() async {
    if (state.isLoading || !_hasMore) return;

    final previousOrders = state.value ?? [];
    _currentPage++;
    
    // Set loading state for the bottom of the list if needed, 
    // but here we just fetch and append
    final getUserOrdersUseCase = ref.read(getUserOrdersUseCaseProvider);
    final result = await getUserOrdersUseCase(page: _currentPage, size: _pageSize);

    result.fold(
      (failure) {
        _currentPage--; // Revert page on failure
        // We don't change the main state to error to keep the existing list visible
      },
      (newOrders) {
        if (newOrders.isEmpty || newOrders.length < _pageSize) {
          _hasMore = false;
        }
        state = AsyncData([...previousOrders, ...newOrders]);
      },
    );
  }

  /// Refresh danh sách orders
  Future<void> refreshOrders() async {
    await getUserOrders();
  }

  /// Thêm order mới vào đầu danh sách (Optimistic)
  void addOrder(OrderEntity order) {
    if (state.value != null) {
      state = AsyncData([order, ...state.value!]);
    }
  }

  /// Xóa order khỏi danh sách (Optimistic)
  void removeOrder(int orderId) {
    if (state.value != null) {
      final updatedOrders = state.value!.where((order) => order.id != orderId).toList();
      state = AsyncData(updatedOrders);
    }
  }
}
