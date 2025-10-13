import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/orders_usecases.dart';
import 'order_states.dart';

/// Notifier cho chi tiết order
class OrderDetailNotifier extends StateNotifier<OrderDetailState> {
  final GetOrderByIdUseCase _getOrderByIdUseCase;

  OrderDetailNotifier(this._getOrderByIdUseCase)
    : super(const OrderDetailState());

  /// Lấy chi tiết đơn hàng theo ID
  Future<void> getOrderById(num orderId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final result = await _getOrderByIdUseCase(orderId);

      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ),
        (order) => state = state.copyWith(
          isLoading: false,
          order: order,
          errorMessage: null,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: $e',
      );
    }
  }

  /// Clear order detail
  void clearOrder() {
    state = const OrderDetailState();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
