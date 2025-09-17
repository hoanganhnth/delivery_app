import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../data/dtos/create_order_request_dto.dart';
import 'order_providers.dart';

/// AsyncNotifier cho việc tạo đơn hàng
class CreateOrderNotifier extends AutoDisposeAsyncNotifier<OrderEntity?> {
  @override
  Future<OrderEntity?> build() async {
    // Initial state - không có order nào được tạo
    return null;
  }

  /// Tạo đơn hàng mới với CreateOrderRequestDto
  Future<OrderEntity?> createOrder(CreateOrderRequestDto request) async {
    state = const AsyncValue.loading();

    try {
      // Get usecase from provider - use read for one-time access in methods
      final createOrderUseCase = ref.read(createOrderUseCaseProvider);
      final result = await createOrderUseCase(request);

      return result.fold(
        (failure) {
          state = AsyncValue.error(failure.message, StackTrace.current);
          return null;
        },
        (createdOrder) {
          state = AsyncValue.data(createdOrder);
          // Refresh orders list after successful creation
          ref.invalidate(ordersListProvider);
          return createdOrder;
        },
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return null;
    }
  }

  /// Reset state
  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// AsyncNotifier cho việc hủy đơn hàng
class CancelOrderNotifier extends AutoDisposeAsyncNotifier<bool?> {
  @override
  Future<bool?> build() async {
    // Initial state
    return null;
  }

  /// Hủy đơn hàng
  Future<bool> cancelOrder(int orderId) async {
    state = const AsyncValue.loading();

    try {
      final cancelOrderUseCase = ref.read(cancelOrderUseCaseProvider);
      final result = await cancelOrderUseCase(orderId);

      return result.fold(
        (failure) {
          state = AsyncValue.error(failure.message, StackTrace.current);
          return false;
        },
        (success) {
          state = AsyncValue.data(success);
          if (success) {
            // Refresh orders list after successful cancellation
            ref.invalidate(ordersListProvider);
          }
          return success;
        },
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
