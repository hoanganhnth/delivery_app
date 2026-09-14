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
  flashSaleItemId: (json['flashSaleItemId'] as num?)?.toInt(),
);

Map<String, dynamic> _$CheckoutPreviewItemRequestToJson(
  _CheckoutPreviewItemRequest instance,
) => <String, dynamic>{
  'menuItemId': instance.menuItemId,
  'quantity': instance.quantity,
  'flashSaleItemId': instance.flashSaleItemId,
};

_CheckoutPreviewRequest _$CheckoutPreviewRequestFromJson(
  Map<String, dynamic> json,
) => _CheckoutPreviewRequest(
  livestreamId: json['livestreamId'] as String?,
  restaurantId: (json['restaurantId'] as num).toInt(),
  deliveryLat: (json['deliveryLat'] as num).toDouble(),
  deliveryLng: (json['deliveryLng'] as num).toDouble(),
  couponCode: json['couponCode'] as String?,
  voucherId: (json['voucherId'] as num?)?.toInt(),
  selectedVoucherIds: (json['selectedVoucherIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  selectionMode: json['selectionMode'] as String?,
  items: (json['items'] as List<dynamic>)
      .map(
        (e) => CheckoutPreviewItemRequest.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$CheckoutPreviewRequestToJson(
  _CheckoutPreviewRequest instance,
) => <String, dynamic>{
  'livestreamId': instance.livestreamId,
  'restaurantId': instance.restaurantId,
  'deliveryLat': instance.deliveryLat,
  'deliveryLng': instance.deliveryLng,
  'couponCode': instance.couponCode,
  'voucherId': instance.voucherId,
  'selectedVoucherIds': instance.selectedVoucherIds,
  'selectionMode': instance.selectionMode,
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

_AppliedVoucherInfo _$AppliedVoucherInfoFromJson(Map<String, dynamic> json) =>
    _AppliedVoucherInfo(
      voucherId: (json['voucherId'] as num?)?.toInt(),
      code: json['code'] as String?,
      layer: json['layer'] as String?,
      fundingSource: json['fundingSource'] as String?,
      discountBase: (json['discountBase'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AppliedVoucherInfoToJson(_AppliedVoucherInfo instance) =>
    <String, dynamic>{
      'voucherId': instance.voucherId,
      'code': instance.code,
      'layer': instance.layer,
      'fundingSource': instance.fundingSource,
      'discountBase': instance.discountBase,
      'discountAmount': instance.discountAmount,
    };

_CheckoutPreviewResponse _$CheckoutPreviewResponseFromJson(
  Map<String, dynamic> json,
) => _CheckoutPreviewResponse(
  quoteId: json['quoteId'] as String?,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
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
  voucherId: (json['voucherId'] as num?)?.toInt(),
  selectedVoucherIds: (json['selectedVoucherIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  selectionMode: json['selectionMode'] as String?,
  itemDiscount: (json['itemDiscount'] as num?)?.toDouble(),
  shippingDiscount: (json['shippingDiscount'] as num?)?.toDouble(),
  customerShippingFee: (json['customerShippingFee'] as num?)?.toDouble(),
  grossShippingFee: (json['grossShippingFee'] as num?)?.toDouble(),
  platformSubsidy: (json['platformSubsidy'] as num?)?.toDouble(),
  shopDiscount: (json['shopDiscount'] as num?)?.toDouble(),
  appliedVouchers: (json['appliedVouchers'] as List<dynamic>?)
      ?.map((e) => AppliedVoucherInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
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
  'quoteId': instance.quoteId,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'restaurantId': instance.restaurantId,
  'restaurantName': instance.restaurantName,
  'items': instance.items,
  'subtotal': instance.subtotal,
  'shippingFee': instance.shippingFee,
  'discountAmount': instance.discountAmount,
  'totalPrice': instance.totalPrice,
  'couponCode': instance.couponCode,
  'couponMessage': instance.couponMessage,
  'voucherId': instance.voucherId,
  'selectedVoucherIds': instance.selectedVoucherIds,
  'selectionMode': instance.selectionMode,
  'itemDiscount': instance.itemDiscount,
  'shippingDiscount': instance.shippingDiscount,
  'customerShippingFee': instance.customerShippingFee,
  'grossShippingFee': instance.grossShippingFee,
  'platformSubsidy': instance.platformSubsidy,
  'shopDiscount': instance.shopDiscount,
  'appliedVouchers': instance.appliedVouchers,
  'priceChanges': instance.priceChanges,
  'unavailableItemIds': instance.unavailableItemIds,
};
