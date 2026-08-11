import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/features/orders/application/state/orders/orders_list_notifier.dart';
import 'package:delivery_app/features/orders/di/order_providers.dart';
import 'package:delivery_app/features/orders/domain/entities/order_creation_command.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';

part 'create_order_async_notifiers.g.dart';

/// AsyncNotifier cho việc tạo đơn hàng
@riverpod
class CreateOrder extends _$CreateOrder {
  @override
  FutureOr<OrderEntity?> build() {
    // Initial state - không có order nào được tạo
    return null;
  }

  /// Tạo đơn hàng mới với domain command.
  Future<OrderEntity?> createOrder(OrderCreationCommand request) async {
    if (state.isLoading) return null;
    state = const AsyncLoading();

    try {
      final createOrderUseCase = ref.read(createOrderUseCaseProvider);
      final result = await createOrderUseCase(request);

      return result.fold(
        (failure) {
          state = AsyncError(Exception(failure.message), StackTrace.current);
          return null;
        },
        (createdOrder) {
          state = AsyncData(createdOrder);
          // Refresh orders list after successful creation
          ref.invalidate(ordersListProvider);
          return createdOrder;
        },
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }

  /// Reset state
  void reset() {
    state = const AsyncData(null);
  }
}

/// AsyncNotifier cho việc hủy đơn hàng
@riverpod
class CancelOrder extends _$CancelOrder {
  @override
  FutureOr<bool?> build() {
    // Initial state
    return null;
  }

  /// Hủy đơn hàng
  Future<bool> cancelOrder(int orderId, {String? reason}) async {
    if (state.isLoading) return false;
    state = const AsyncLoading();

    try {
      final cancelOrderUseCase = ref.read(cancelOrderUseCaseProvider);
      final result = await cancelOrderUseCase(orderId, reason);

      // Guard: provider may have been disposed while awaiting
      // if (!ref.mounted) return false;

      return result.fold(
        (failure) {
          state = AsyncError(Exception(failure.message), StackTrace.current);
          return false;
        },
        (success) {
          state = AsyncData(success);
          if (success && ref.mounted) {
            // Refresh orders list after successful cancellation
            ref.invalidate(ordersListProvider);
          }
          return success;
        },
      );
    } catch (error, stackTrace) {
      if (ref.mounted) {
        state = AsyncError(error, stackTrace);
      }
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const AsyncData(null);
  }
}
