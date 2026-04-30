// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_preview_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckoutPreviewItemRequest _$CheckoutPreviewItemRequestFromJson(
  Map<String, dynamic> json,
) => _CheckoutPreviewItemRequest(
  menuItemId: (json['menuItemId'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$CheckoutPreviewItemRequestToJson(
  _CheckoutPreviewItemRequest instance,
) => <String, dynamic>{
  'menuItemId': instance.menuItemId,
  'quantity': instance.quantity,
};

_CheckoutPreviewRequest _$CheckoutPreviewRequestFromJson(
  Map<String, dynamic> json,
) => _CheckoutPreviewRequest(
  restaurantId: (json['restaurantId'] as num).toInt(),
  deliveryLat: (json['deliveryLat'] as num?)?.toDouble(),
  deliveryLng: (json['deliveryLng'] as num?)?.toDouble(),
  couponCode: json['couponCode'] as String?,
  items: (json['items'] as List<dynamic>)
      .map(
        (e) => CheckoutPreviewItemRequest.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$CheckoutPreviewRequestToJson(
  _CheckoutPreviewRequest instance,
) => <String, dynamic>{
  'restaurantId': instance.restaurantId,
  'deliveryLat': instance.deliveryLat,
  'deliveryLng': instance.deliveryLng,
  'couponCode': instance.couponCode,
  'items': instance.items,
};

_PreviewItemDetail _$PreviewItemDetailFromJson(Map<String, dynamic> json) =>
    _PreviewItemDetail(
      menuItemId: (json['menuItemId'] as num?)?.toInt(),
      menuItemName: json['menuItemName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt(),
      lineTotal: (json['lineTotal'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PreviewItemDetailToJson(_PreviewItemDetail instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'menuItemName': instance.menuItemName,
      'imageUrl': instance.imageUrl,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'lineTotal': instance.lineTotal,
    };

_PriceChangeInfo _$PriceChangeInfoFromJson(Map<String, dynamic> json) =>
    _PriceChangeInfo(
      menuItemId: (json['menuItemId'] as num?)?.toInt(),
      menuItemName: json['menuItemName'] as String?,
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      newPrice: (json['newPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PriceChangeInfoToJson(_PriceChangeInfo instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'menuItemName': instance.menuItemName,
      'oldPrice': instance.oldPrice,
      'newPrice': instance.newPrice,
    };

_CheckoutPreviewResponse _$CheckoutPreviewResponseFromJson(
  Map<String, dynamic> json,
) => _CheckoutPreviewResponse(
  restaurantId: (json['restaurantId'] as num?)?.toInt(),
  restaurantName: json['restaurantName'] as String?,
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => PreviewItemDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
  subtotal: (json['subtotal'] as num?)?.toDouble(),
  shippingFee: (json['shippingFee'] as num?)?.toDouble(),
  discountAmount: (json['discountAmount'] as num?)?.toDouble(),
  totalPrice: (json['totalPrice'] as num?)?.toDouble(),
  couponCode: json['couponCode'] as String?,
  couponMessage: json['couponMessage'] as String?,
  priceChanges: (json['priceChanges'] as List<dynamic>?)
      ?.map((e) => PriceChangeInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
  unavailableItemIds: (json['unavailableItemIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$CheckoutPreviewResponseToJson(
  _CheckoutPreviewResponse instance,
) => <String, dynamic>{
  'restaurantId': instance.restaurantId,
  'restaurantName': instance.restaurantName,
  'items': instance.items,
  'subtotal': instance.subtotal,
  'shippingFee': instance.shippingFee,
  'discountAmount': instance.discountAmount,
  'totalPrice': instance.totalPrice,
  'couponCode': instance.couponCode,
  'couponMessage': instance.couponMessage,
  'priceChanges': instance.priceChanges,
  'unavailableItemIds': instance.unavailableItemIds,
};
