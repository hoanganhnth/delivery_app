import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_preview_dto.freezed.dart';
part 'checkout_preview_dto.g.dart';

// ─── Request ───

@freezed
sealed class CheckoutPreviewItemRequest with _$CheckoutPreviewItemRequest {
  const factory CheckoutPreviewItemRequest({
    required int menuItemId,
    required int quantity,
  }) = _CheckoutPreviewItemRequest;

  factory CheckoutPreviewItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPreviewItemRequestFromJson(json);
}

@freezed
sealed class CheckoutPreviewRequest with _$CheckoutPreviewRequest {
  const factory CheckoutPreviewRequest({
    required int restaurantId,
    required double deliveryLat,
    required double deliveryLng,
    String? couponCode,
    required List<CheckoutPreviewItemRequest> items,
  }) = _CheckoutPreviewRequest;

  factory CheckoutPreviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPreviewRequestFromJson(json);
}

// ─── Response ───

@freezed
sealed class PreviewItemDetail with _$PreviewItemDetail {
  const factory PreviewItemDetail({
    int? menuItemId,
    String? menuItemName,
    String? imageUrl,
    double? unitPrice,
    int? quantity,
    double? lineTotal,
  }) = _PreviewItemDetail;

  factory PreviewItemDetail.fromJson(Map<String, dynamic> json) =>
      _$PreviewItemDetailFromJson(json);
}

@freezed
sealed class PriceChangeInfo with _$PriceChangeInfo {
  const factory PriceChangeInfo({
    int? menuItemId,
    String? menuItemName,
    double? oldPrice,
    double? newPrice,
  }) = _PriceChangeInfo;

  factory PriceChangeInfo.fromJson(Map<String, dynamic> json) =>
      _$PriceChangeInfoFromJson(json);
}

@freezed
sealed class CheckoutPreviewResponse with _$CheckoutPreviewResponse {
  const factory CheckoutPreviewResponse({
    int? restaurantId,
    String? restaurantName,
    List<PreviewItemDetail>? items,
    double? subtotal,
    double? shippingFee,
    double? discountAmount,
    double? totalPrice,
    String? couponCode,
    String? couponMessage,
    List<PriceChangeInfo>? priceChanges,
    List<int>? unavailableItemIds,
  }) = _CheckoutPreviewResponse;

  factory CheckoutPreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPreviewResponseFromJson(json);
}

extension CheckoutPreviewResponseContract on CheckoutPreviewResponse {
  CheckoutPreviewResponse validateFor(CheckoutPreviewRequest request) {
    if (request.restaurantId <= 0 ||
        !_isVietnamCoordinate(request.deliveryLat, request.deliveryLng) ||
        request.items.isEmpty) {
      throw const FormatException('Invalid checkout preview request');
    }

    final currentRestaurantId = restaurantId;
    final currentRestaurantName = restaurantName?.trim();
    final currentItems = items;
    final currentSubtotal = subtotal;
    final currentShippingFee = shippingFee;
    final currentDiscount = discountAmount;
    final currentTotal = totalPrice;

    if (currentRestaurantId != request.restaurantId ||
        currentRestaurantName == null ||
        currentRestaurantName.isEmpty) {
      throw const FormatException('Invalid checkout restaurant response');
    }
    if ((unavailableItemIds ?? const <int>[]).isNotEmpty) {
      throw const FormatException('Checkout contains unavailable items');
    }
    if ((couponCode?.trim().isNotEmpty ?? false) ||
        (couponMessage?.trim().isNotEmpty ?? false)) {
      throw const FormatException('Coupon is unsupported in COD MVP');
    }
    if (currentItems == null || currentItems.length != request.items.length) {
      throw const FormatException('Checkout item count mismatch');
    }

    final requestedQuantities = <int, int>{};
    for (final item in request.items) {
      if (item.menuItemId <= 0 ||
          item.quantity <= 0 ||
          requestedQuantities.containsKey(item.menuItemId)) {
        throw const FormatException('Invalid checkout request item');
      }
      requestedQuantities[item.menuItemId] = item.quantity;
    }

    var calculatedSubtotal = 0.0;
    final responseIds = <int>{};
    for (final item in currentItems) {
      final itemId = item.menuItemId;
      final itemName = item.menuItemName?.trim();
      final unitPrice = item.unitPrice;
      final quantity = item.quantity;
      final lineTotal = item.lineTotal;
      if (itemId == null ||
          itemId <= 0 ||
          !responseIds.add(itemId) ||
          requestedQuantities[itemId] != quantity ||
          itemName == null ||
          itemName.isEmpty ||
          unitPrice == null ||
          !unitPrice.isFinite ||
          unitPrice <= 0 ||
          quantity == null ||
          quantity <= 0 ||
          lineTotal == null ||
          !lineTotal.isFinite ||
          !_sameMoney(lineTotal, unitPrice * quantity)) {
        throw const FormatException('Invalid checkout preview item');
      }
      calculatedSubtotal += lineTotal;
    }

    if (!_isNonNegativeMoney(currentSubtotal) ||
        !_isNonNegativeMoney(currentShippingFee) ||
        !_isNonNegativeMoney(currentDiscount) ||
        currentTotal == null ||
        !currentTotal.isFinite ||
        currentTotal <= 0 ||
        !_sameMoney(currentSubtotal!, calculatedSubtotal) ||
        !_sameMoney(
          currentTotal,
          currentSubtotal + currentShippingFee! - currentDiscount!,
        )) {
      throw const FormatException('Invalid checkout preview totals');
    }

    return this;
  }

  static bool _isVietnamCoordinate(double latitude, double longitude) {
    return latitude.isFinite &&
        longitude.isFinite &&
        latitude >= 8.0 &&
        latitude <= 24.0 &&
        longitude >= 102.0 &&
        longitude <= 110.0;
  }

  static bool _isNonNegativeMoney(double? value) {
    return value != null && value.isFinite && value >= 0;
  }

  static bool _sameMoney(double left, double right) {
    return (left - right).abs() < 0.01;
  }
}
