import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/core/network/_riverpod/network_providers.dart';
import 'package:delivery_app/features/orders/data/datasources/order_api_service.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';

part 'checkout_preview_provider.g.dart';

/// Provider cho OrderApiService (checkout-specific)
@Riverpod(keepAlive: true)
OrderApiService checkoutOrderApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return OrderApiService(dio);
}

/// ✅ Checkout Preview Provider
/// Gọi server để tính giá chính xác trước khi đặt hàng.
@riverpod
class CheckoutPreviewNotifier extends _$CheckoutPreviewNotifier {
  @override
  FutureOr<CheckoutPreviewResponse?> build() {
    return null;
  }

  /// Gọi API checkout-preview
  Future<CheckoutPreviewResponse?> loadPreview(CheckoutPreviewRequest request) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(checkoutOrderApiServiceProvider);
      final response = await service.checkoutPreview(request);
      if (response.status == 1 && response.data != null) {
        state = AsyncValue.data(response.data);
        return response.data;
      } else {
        throw Exception(response.message);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  /// Reset state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
