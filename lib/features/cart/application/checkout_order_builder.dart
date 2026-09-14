import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';
import 'package:delivery_app/features/orders/domain/entities/order_creation_command.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';

enum CheckoutOrderBuildFailure { invalidInput, invalidPreview }

class CheckoutOrderBuildException implements Exception {
  const CheckoutOrderBuildException(this.failure);

  final CheckoutOrderBuildFailure failure;
}

/// Translates locally persisted cart data into the canonical order contracts.
///
/// This is application orchestration, never a presentation concern. It rejects
/// a stale or malformed server preview before an order can be created.
class CheckoutOrderBuilder {
  const CheckoutOrderBuilder._();

  static CheckoutPreviewRequest buildPreviewRequest({
    required CartEntity cart,
    required UserAddressEntity? address,
    int? selectedVoucherId,
    List<int>? selectedVoucherIds,
    String? selectionMode,
  }) {
    final restaurantId = _positiveInt(cart.currentRestaurantId);
    final latitude = address?.latitude;
    final longitude = address?.longitude;
    if (address == null ||
        restaurantId == null ||
        !_isValidLivestreamId(cart.livestreamId) ||
        !_isVietnamCoordinate(latitude, longitude) ||
        !_hasValidCartItems(cart) ||
        address.recipientName.trim().isEmpty ||
        address.phoneNumber.trim().isEmpty ||
        address.fullAddress.trim().isEmpty) {
      throw const CheckoutOrderBuildException(
        CheckoutOrderBuildFailure.invalidInput,
      );
    }
    final usesStackingContract =
        selectedVoucherIds != null || selectionMode != null;
    final voucherIds = usesStackingContract
        ? (selectedVoucherIds ?? const <int>[])
        : (selectedVoucherId == null ? const <int>[] : [selectedVoucherId]);
    final voucherContractDisabled = usesStackingContract
        ? !RuntimeConfig.voucherStackingEnabled
        : voucherIds.isNotEmpty && !RuntimeConfig.voucherCheckoutEnabled;
    if (voucherIds.length > 3 ||
        voucherIds.any((id) => id <= 0) ||
        voucherIds.toSet().length != voucherIds.length ||
        voucherContractDisabled) {
      throw const CheckoutOrderBuildException(
        CheckoutOrderBuildFailure.invalidInput,
      );
    }
    final hasFlashSale = cart.items.any((item) => item.flashSaleItemId != null);
    if ((hasFlashSale && !RuntimeConfig.flashSaleCheckoutEnabled) ||
        (hasFlashSale && cart.livestreamId != null) ||
        (hasFlashSale && voucherIds.isNotEmpty)) {
      throw const CheckoutOrderBuildException(
        CheckoutOrderBuildFailure.invalidInput,
      );
    }

    return CheckoutPreviewRequest(
      livestreamId: cart.livestreamId,
      restaurantId: restaurantId,
      deliveryLat: latitude!,
      deliveryLng: longitude!,
      voucherId: usesStackingContract ? null : selectedVoucherId,
      selectedVoucherIds: usesStackingContract ? voucherIds : null,
      selectionMode: usesStackingContract ? selectionMode : null,
      items: cart.items
          .map(
            (item) => CheckoutPreviewItemRequest(
              menuItemId: _positiveInt(item.menuItemId)!,
              quantity: item.quantity,
              flashSaleItemId: item.flashSaleItemId,
            ),
          )
          .toList(growable: false),
    );
  }

  static OrderCreationCommand buildOrderRequest({
    required CartEntity cart,
    required UserAddressEntity? address,
    required CheckoutPreviewResponse? preview,
    String? notes,
    int? selectedVoucherId,
    List<int>? selectedVoucherIds,
    String? selectionMode,
    String? idempotencyKey,
  }) {
    final usesStackingContract =
        selectedVoucherIds != null || selectionMode != null;
    final voucherIds = usesStackingContract
        ? (selectedVoucherIds ?? const <int>[])
        : (selectedVoucherId == null ? const <int>[] : [selectedVoucherId]);
    final previewRequest = buildPreviewRequest(
      cart: cart,
      address: address,
      selectedVoucherId: selectedVoucherId,
      selectedVoucherIds: selectedVoucherIds,
      selectionMode: selectionMode,
    );
    if (preview == null ||
        preview.quoteId == null ||
        preview.quoteId!.isEmpty) {
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

    return OrderCreationCommand(
      quoteId: preview.quoteId,
      livestreamId: cart.livestreamId,
      idempotencyKey: idempotencyKey,
      restaurantId: previewRequest.restaurantId,
      deliveryAddress: address!.fullAddress,
      deliveryLat: previewRequest.deliveryLat,
      deliveryLng: previewRequest.deliveryLng,
      customerName: address.recipientName,
      customerPhone: address.phoneNumber,
      paymentMethod: 'COD',
      notes: notes,
      voucherIds: usesStackingContract
          ? voucherIds
          : (voucherIds.isEmpty ? null : voucherIds),
      selectionMode: usesStackingContract ? selectionMode : null,
      items: cart.items
          .map<OrderCreationItem>(
            (item) => OrderCreationItem(
              menuItemId: _positiveInt(item.menuItemId)!,
              quantity: item.quantity,
              notes: item.notes,
              flashSaleItemId: item.flashSaleItemId,
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

  static bool _isValidLivestreamId(String? value) {
    return value == null || _uuid.hasMatch(value);
  }
}

final _uuid = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
);
