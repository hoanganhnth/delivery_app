import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/order_entity.dart';
import 'order_providers.dart'; // To get usecases if needed, or get through ref.read

part 'orders_list_notifier.g.dart';

/// Notifier cho danh sách orders
@riverpod
class OrdersList extends _$OrdersList {
  @override
  FutureOr<List<OrderEntity>> build() async {
    // Return the initial list of orders
    final getUserOrdersUseCase = ref.watch(getUserOrdersUseCaseProvider);
    final result = await getUserOrdersUseCase();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (orders) => orders,
    );
  }

  /// Lấy danh sách đơn hàng của người dùng
  Future<void> getUserOrders() async {
    state = const AsyncLoading();
    
    final getUserOrdersUseCase = ref.read(getUserOrdersUseCaseProvider);
    final result = await getUserOrdersUseCase();

    result.fold(
      (failure) => state = AsyncError(Exception(failure.message), StackTrace.current),
      (orders) => state = AsyncData(orders),
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
