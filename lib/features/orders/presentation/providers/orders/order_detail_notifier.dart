import 'package:riverpod_annotation/riverpod_annotation.dart';
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
      (failure) => throw Exception(failure.message),
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
        (failure) => state = AsyncError(Exception(failure.message), StackTrace.current),
        (order) => state = AsyncData(order),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Clear order detail
  void clearOrder() {
    state = const AsyncData(null);
  }
}
