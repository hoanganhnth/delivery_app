import '../../domain/entities/cart_entity.dart';
import '../../../orders/data/dtos/checkout_preview_dto.dart';
import '../../../orders/data/dtos/create_order_request_dto.dart';
import '../../../user_address/domain/entities/user_address_entity.dart';

enum CheckoutOrderBuildFailure { invalidInput, invalidPreview }

class CheckoutOrderBuildException implements Exception {
  const CheckoutOrderBuildException(this.failure);

  final CheckoutOrderBuildFailure failure;
}

class CheckoutOrderBuilder {
  const CheckoutOrderBuilder._();

  static CheckoutPreviewRequest buildPreviewRequest({
    required CartEntity cart,
    required UserAddressEntity? address,
  }) {
    final restaurantId = _positiveInt(cart.currentRestaurantId);
    final latitude = address?.latitude;
    final longitude = address?.longitude;
    if (address == null ||
        restaurantId == null ||
        !_isVietnamCoordinate(latitude, longitude) ||
        !_hasValidCartItems(cart) ||
        address.recipientName.trim().isEmpty ||
        address.phoneNumber.trim().isEmpty ||
        address.fullAddress.trim().isEmpty) {
      throw const CheckoutOrderBuildException(
        CheckoutOrderBuildFailure.invalidInput,
      );
    }

    return CheckoutPreviewRequest(
      restaurantId: restaurantId,
      deliveryLat: latitude!,
      deliveryLng: longitude!,
      items: cart.items
          .map(
            (item) => CheckoutPreviewItemRequest(
              menuItemId: _positiveInt(item.menuItemId)!,
              quantity: item.quantity,
            ),
          )
          .toList(growable: false),
    );
  }

  static CreateOrderRequestDto buildOrderRequest({
    required CartEntity cart,
    required UserAddressEntity? address,
    required CheckoutPreviewResponse? preview,
    String? notes,
  }) {
    final previewRequest = buildPreviewRequest(cart: cart, address: address);
    if (preview == null) {
      throw const CheckoutOrderBuildException(
        CheckoutOrderBuildFailure.invalidPreview,
      );
    }
    try {
      preview.validateFor(previewRequest);
    } on FormatException {
      throw const CheckoutOrderBuildException(
        CheckoutOrderBuildFailure.invalidPreview,
      );
    }

    return CreateOrderRequestDto(
      restaurantId: previewRequest.restaurantId,
      deliveryAddress: address!.fullAddress,
      deliveryLat: previewRequest.deliveryLat,
      deliveryLng: previewRequest.deliveryLng,
      customerName: address.recipientName,
      customerPhone: address.phoneNumber,
      paymentMethod: 'COD',
      notes: notes,
      items: cart.items
          .map<OrderItemRequest>(
            (item) => OrderItemRequest(
              menuItemId: _positiveInt(item.menuItemId)!,
              quantity: item.quantity,
              notes: item.notes,
            ),
          )
          .toList(growable: false),
    );
  }

  static int? _positiveInt(num? value) {
    return value is int && value > 0 ? value : null;
  }

  static bool _hasValidCartItems(CartEntity cart) {
    return cart.items.isNotEmpty &&
        cart.items.every(
          (item) =>
              _positiveInt(item.menuItemId) != null &&
              item.quantity > 0 &&
              item.restaurantId == cart.currentRestaurantId,
        );
  }

  static bool _isVietnamCoordinate(double? latitude, double? longitude) {
    return latitude != null &&
        longitude != null &&
        latitude.isFinite &&
        longitude.isFinite &&
        latitude >= 8.0 &&
        latitude <= 24.0 &&
        longitude >= 102.0 &&
        longitude <= 110.0;
  }
}
