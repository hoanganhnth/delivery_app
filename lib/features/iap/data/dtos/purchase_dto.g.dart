// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PurchaseDto _$PurchaseDtoFromJson(Map<String, dynamic> json) => _PurchaseDto(
  purchaseId: json['purchaseId'] as String,
  productId: json['productId'] as String,
  transactionDate: json['transactionDate'] as String,
  status: json['status'] as String,
  verificationData: json['verificationData'] as String?,
  pendingCompletePurchase: json['pendingCompletePurchase'] as bool? ?? false,
);

Map<String, dynamic> _$PurchaseDtoToJson(_PurchaseDto instance) =>
    <String, dynamic>{
      'purchaseId': instance.purchaseId,
      'productId': instance.productId,
      'transactionDate': instance.transactionDate,
      'status': instance.status,
      'verificationData': instance.verificationData,
      'pendingCompletePurchase': instance.pendingCompletePurchase,
    };
