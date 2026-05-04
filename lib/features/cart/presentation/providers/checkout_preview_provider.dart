import 'package:delivery_app/features/auth/presentation/providers/di/auth_network_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/features/orders/data/datasources/order_api_service.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';

part 'checkout_preview_provider.g.dart';

/// Provider cho OrderApiService (checkout-specific)
@Riverpod(keepAlive: true)
OrderApiService checkoutOrderApiService(Ref ref) {
  final dio = ref.watch(authAwareDioProvider);
  return OrderApiService(dio);
}

/// ✅ Checkout Preview Provider
/// Gọi server để tính giá chính xác trước khi đặt hàng.
@Riverpod(keepAlive: true)
class CheckoutPreviewNotifier extends _$CheckoutPreviewNotifier {
  @override
  FutureOr<CheckoutPreviewResponse?> build() {
    return null;
  }

  /// Gọi API checkout-preview
  Future<CheckoutPreviewResponse?> loadPreview(
    CheckoutPreviewRequest request,
  ) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(checkoutOrderApiServiceProvider);
      final response = await service.checkoutPreview(request);
      
      if (!ref.mounted) return null;

      if (response.status == 1 && response.data != null) {
        state = AsyncValue.data(response.data);
        return response.data;
      } else {
        throw Exception(response.message);
      }
    } catch (e, st) {
      if (ref.mounted) {
        state = AsyncValue.error(e, st);
      }
      return null;
    }
  }

  /// Reset state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
