import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_preview_dto.freezed.dart';
part 'checkout_preview_dto.g.dart';

// ─── Request ───

@freezed
abstract class CheckoutPreviewItemRequest with _$CheckoutPreviewItemRequest {
  const factory CheckoutPreviewItemRequest({
    required int menuItemId,
    required int quantity,
  }) = _CheckoutPreviewItemRequest;

  factory CheckoutPreviewItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPreviewItemRequestFromJson(json);
}

@freezed
abstract class CheckoutPreviewRequest with _$CheckoutPreviewRequest {
  const factory CheckoutPreviewRequest({
    required int restaurantId,
    double? deliveryLat,
    double? deliveryLng,
    String? couponCode,
    required List<CheckoutPreviewItemRequest> items,
  }) = _CheckoutPreviewRequest;

  factory CheckoutPreviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPreviewRequestFromJson(json);
}

// ─── Response ───

@freezed
abstract class PreviewItemDetail with _$PreviewItemDetail {
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
abstract class PriceChangeInfo with _$PriceChangeInfo {
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
abstract class CheckoutPreviewResponse with _$CheckoutPreviewResponse {
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
