import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'consumable_dto.freezed.dart';
part 'consumable_dto.g.dart';

@freezed
abstract class ConsumableDto with _$ConsumableDto {
  const factory ConsumableDto({
    required String productId,
    required String title,
    required String description,
    required String price,
    required String currencyCode,
    required double rawPrice,
    required String consumableType,
    required double value,
    String? code,
    DateTime? expiryDate,
    @Default(true) bool isAvailable,
  }) = _ConsumableDto;

  const ConsumableDto._();

  factory ConsumableDto.fromJson(Map<String, dynamic> json) =>
      _$ConsumableDtoFromJson(json);

  /// Convert to domain entity
  ConsumableEntity toEntity() {
    return ConsumableEntity(
      product: IapProductEntity(
        id: productId,
        title: title,
        description: description,
        price: price,
        currencyCode: currencyCode,
        rawPrice: rawPrice,
        productType: IapProductType.consumable,
      ),
      type: ConsumableProducts.getTypeFromProductId(productId),
      value: value,
      code: code,
      expiryDate: expiryDate,
    );
  }

  /// Create from domain entity
  factory ConsumableDto.fromEntity(ConsumableEntity entity) {
    return ConsumableDto(
      productId: entity.product.id,
      title: entity.product.title,
      description: entity.product.description,
      price: entity.product.price,
      currencyCode: entity.product.currencyCode,
      rawPrice: entity.product.rawPrice,
      consumableType: entity.type.name,
      value: entity.value,
      code: entity.code,
      expiryDate: entity.expiryDate,
    );
  }

  /// Create from IAP product entity
  factory ConsumableDto.fromIapProduct(IapProductEntity product) {
    final type = ConsumableProducts.getTypeFromProductId(product.id);
    final value = ConsumableProducts.getValueFromProductId(product.id);

    return ConsumableDto(
      productId: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      currencyCode: product.currencyCode,
      rawPrice: product.rawPrice,
      consumableType: type.name,
      value: value,
    );
  }
}

/// User credits balance DTO
@freezed
abstract class UserCreditsDto with _$UserCreditsDto {
  const factory UserCreditsDto({
    required int balance,
    required DateTime lastUpdated,
    @Default([]) List<CreditTransactionDto> recentTransactions,
  }) = _UserCreditsDto;

  factory UserCreditsDto.fromJson(Map<String, dynamic> json) =>
      _$UserCreditsDtoFromJson(json);
}

/// Credit transaction DTO
@freezed
abstract class CreditTransactionDto with _$CreditTransactionDto {
  const factory CreditTransactionDto({
    required String id,
    required int amount,
    required String type, // 'purchase', 'spend', 'refund', 'bonus'
    required DateTime timestamp,
    String? description,
    String? orderId,
  }) = _CreditTransactionDto;

  factory CreditTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$CreditTransactionDtoFromJson(json);
}
