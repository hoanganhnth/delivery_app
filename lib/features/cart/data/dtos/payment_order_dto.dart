import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_order_dto.freezed.dart';
part 'payment_order_dto.g.dart';

/// DTO for creating a payment order
@freezed
abstract class CreatePaymentDto with _$CreatePaymentDto {
  const factory CreatePaymentDto({
    required int entityId,
    @Default('CUSTOMER') String entityType,
    required double amount,
    @Default('FAKE') String provider,
    @Default('ORDER_PAYMENT') String purpose,
    String? returnUrl,
    String? ipAddress,
  }) = _CreatePaymentDto;

  factory CreatePaymentDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentDtoFromJson(json);
}

/// DTO for payment order response
@freezed
abstract class PaymentOrderDto with _$PaymentOrderDto {
  const factory PaymentOrderDto({
    required int id,
    required String paymentRef,
    required int entityId,
    required String entityType,
    required String provider,
    required double amount,
    required String currency,
    required String purpose,
    required String status,
    String? paymentUrl,
    String? providerTransactionId,
    int? settlementTransactionId,
    String? createdAt,
    String? expiredAt,
  }) = _PaymentOrderDto;

  factory PaymentOrderDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentOrderDtoFromJson(json);
}
