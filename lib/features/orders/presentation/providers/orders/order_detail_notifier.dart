import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/core/error/error_mapper.dart';
import '../../../domain/entities/order_entity.dart';
import 'order_providers.dart';

part 'order_detail_notifier.g.dart';

/// Notifier cho chi tiết order
@riverpod
class OrderDetail extends _$OrderDetail {
  @override
  FutureOr<OrderEntity?> build(num orderId) async {
    final getOrderByIdUseCase = ref.watch(getOrderByIdUseCaseProvider);
    final result = await getOrderByIdUseCase(orderId);
    
    return result.fold(
      (failure) => throw failure, // Riverpod will catch this and set state to AsyncError(failure)
      (order) => order,
    );
  }

  /// Làm mới đơn hàng
  Future<void> refresh() async {
    state = const AsyncLoading();
    final getOrderByIdUseCase = ref.read(getOrderByIdUseCaseProvider);
    
    try {
      final result = await getOrderByIdUseCase(orderId);
      result.fold(
        (failure) => state = AsyncError(failure, StackTrace.current),
        (order) => state = AsyncData(order),
      );
    } catch (e, st) {
      state = AsyncError(mapExceptionToFailure(e), st);
    }
  }

  /// Clear order detail
  void clearOrder() {
    state = const AsyncData(null);
  }
}
