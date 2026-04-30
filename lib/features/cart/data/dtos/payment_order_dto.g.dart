// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePaymentDto _$CreatePaymentDtoFromJson(Map<String, dynamic> json) =>
    _CreatePaymentDto(
      entityId: (json['entityId'] as num).toInt(),
      entityType: json['entityType'] as String? ?? 'CUSTOMER',
      amount: (json['amount'] as num).toDouble(),
      provider: json['provider'] as String? ?? 'FAKE',
      purpose: json['purpose'] as String? ?? 'ORDER_PAYMENT',
      returnUrl: json['returnUrl'] as String?,
      ipAddress: json['ipAddress'] as String?,
    );

Map<String, dynamic> _$CreatePaymentDtoToJson(_CreatePaymentDto instance) =>
    <String, dynamic>{
      'entityId': instance.entityId,
      'entityType': instance.entityType,
      'amount': instance.amount,
      'provider': instance.provider,
      'purpose': instance.purpose,
      'returnUrl': instance.returnUrl,
      'ipAddress': instance.ipAddress,
    };

_PaymentOrderDto _$PaymentOrderDtoFromJson(Map<String, dynamic> json) =>
    _PaymentOrderDto(
      id: (json['id'] as num).toInt(),
      paymentRef: json['paymentRef'] as String,
      entityId: (json['entityId'] as num).toInt(),
      entityType: json['entityType'] as String,
      provider: json['provider'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      purpose: json['purpose'] as String,
      status: json['status'] as String,
      paymentUrl: json['paymentUrl'] as String?,
      providerTransactionId: json['providerTransactionId'] as String?,
      settlementTransactionId: (json['settlementTransactionId'] as num?)
          ?.toInt(),
      createdAt: json['createdAt'] as String?,
      expiredAt: json['expiredAt'] as String?,
    );

Map<String, dynamic> _$PaymentOrderDtoToJson(_PaymentOrderDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentRef': instance.paymentRef,
      'entityId': instance.entityId,
      'entityType': instance.entityType,
      'provider': instance.provider,
      'amount': instance.amount,
      'currency': instance.currency,
      'purpose': instance.purpose,
      'status': instance.status,
      'paymentUrl': instance.paymentUrl,
      'providerTransactionId': instance.providerTransactionId,
      'settlementTransactionId': instance.settlementTransactionId,
      'createdAt': instance.createdAt,
      'expiredAt': instance.expiredAt,
    };
