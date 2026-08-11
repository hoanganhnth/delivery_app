import 'package:delivery_app/features/orders/data/datasources/order_api_service.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';

abstract interface class CheckoutPreviewGateway {
  /// Returns the raw server response. The ViewModel handles unavailable items
  /// before validating a price confirmation, so the customer can be informed.
  Future<CheckoutPreviewResponse> preview(CheckoutPreviewRequest request);
}

class OrderApiCheckoutPreviewGateway implements CheckoutPreviewGateway {
  const OrderApiCheckoutPreviewGateway(this._service);

  final OrderApiService _service;

  @override
  Future<CheckoutPreviewResponse> preview(
    CheckoutPreviewRequest request,
  ) async {
    final response = await _service.checkoutPreview(request);
    if (response.status != 1 || response.data == null) {
      throw Exception(response.message);
    }
    return response.data!;
  }
}
