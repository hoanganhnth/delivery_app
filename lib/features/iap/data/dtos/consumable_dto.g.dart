// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConsumableDto _$ConsumableDtoFromJson(Map<String, dynamic> json) =>
    _ConsumableDto(
      productId: json['productId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      currencyCode: json['currencyCode'] as String,
      rawPrice: (json['rawPrice'] as num).toDouble(),
      consumableType: json['consumableType'] as String,
      value: (json['value'] as num).toDouble(),
      code: json['code'] as String?,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      isAvailable: json['isAvailable'] as bool? ?? true,
    );

Map<String, dynamic> _$ConsumableDtoToJson(_ConsumableDto instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'currencyCode': instance.currencyCode,
      'rawPrice': instance.rawPrice,
      'consumableType': instance.consumableType,
      'value': instance.value,
      'code': instance.code,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'isAvailable': instance.isAvailable,
    };

_UserCreditsDto _$UserCreditsDtoFromJson(Map<String, dynamic> json) =>
    _UserCreditsDto(
      balance: (json['balance'] as num).toInt(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      recentTransactions:
          (json['recentTransactions'] as List<dynamic>?)
              ?.map(
                (e) => CreditTransactionDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserCreditsDtoToJson(_UserCreditsDto instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'recentTransactions': instance.recentTransactions,
    };

_CreditTransactionDto _$CreditTransactionDtoFromJson(
  Map<String, dynamic> json,
) => _CreditTransactionDto(
  id: json['id'] as String,
  amount: (json['amount'] as num).toInt(),
  type: json['type'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  description: json['description'] as String?,
  orderId: json['orderId'] as String?,
);

Map<String, dynamic> _$CreditTransactionDtoToJson(
  _CreditTransactionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'type': instance.type,
  'timestamp': instance.timestamp.toIso8601String(),
  'description': instance.description,
  'orderId': instance.orderId,
};
