import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'non_consumable_dto.freezed.dart';
part 'non_consumable_dto.g.dart';

@freezed
abstract class NonConsumableDto with _$NonConsumableDto {
  const factory NonConsumableDto({
    required String productId,
    required String title,
    required String description,
    required String price,
    required String currencyCode,
    required double rawPrice,
    required String featureType,
    @Default(false) bool isUnlocked,
    DateTime? purchaseDate,
  }) = _NonConsumableDto;

  const NonConsumableDto._();

  factory NonConsumableDto.fromJson(Map<String, dynamic> json) =>
      _$NonConsumableDtoFromJson(json);

  /// Convert to domain entity
  NonConsumableEntity toEntity() {
    return NonConsumableEntity(
      product: IapProductEntity(
        id: productId,
        title: title,
        description: description,
        price: price,
        currencyCode: currencyCode,
        rawPrice: rawPrice,
        productType: IapProductType.nonConsumable,
      ),
      featureType: FeatureTypeExtension.fromProductId(productId) ??
          _featureTypeFromString(featureType),
      isUnlocked: isUnlocked,
      purchaseDate: purchaseDate,
    );
  }

  /// Create from domain entity
  factory NonConsumableDto.fromEntity(NonConsumableEntity entity) {
    return NonConsumableDto(
      productId: entity.product.id,
      title: entity.product.title,
      description: entity.product.description,
      price: entity.product.price,
      currencyCode: entity.product.currencyCode,
      rawPrice: entity.product.rawPrice,
      featureType: entity.featureType.name,
      isUnlocked: entity.isUnlocked,
      purchaseDate: entity.purchaseDate,
    );
  }

  /// Create from IAP product entity
  factory NonConsumableDto.fromIapProduct(
    IapProductEntity product, {
    bool isUnlocked = false,
    DateTime? purchaseDate,
  }) {
    final featureType = FeatureTypeExtension.fromProductId(product.id);

    return NonConsumableDto(
      productId: product.id,
      title: featureType?.displayName ?? product.title,
      description: featureType?.description ?? product.description,
      price: product.price,
      currencyCode: product.currencyCode,
      rawPrice: product.rawPrice,
      featureType: featureType?.name ?? 'unknown',
      isUnlocked: isUnlocked,
      purchaseDate: purchaseDate,
    );
  }

  static FeatureType _featureTypeFromString(String value) {
    return FeatureType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => FeatureType.removeAds,
    );
  }
}

/// Unlocked features storage DTO
@freezed
abstract class UnlockedFeaturesDto with _$UnlockedFeaturesDto {
  const factory UnlockedFeaturesDto({
    required List<String> featureIds,
    required DateTime lastUpdated,
  }) = _UnlockedFeaturesDto;

  factory UnlockedFeaturesDto.fromJson(Map<String, dynamic> json) =>
      _$UnlockedFeaturesDtoFromJson(json);

  const UnlockedFeaturesDto._();

  /// Convert to list of FeatureType
  List<FeatureType> toFeatureTypes() {
    return featureIds
        .map((id) => FeatureTypeExtension.fromProductId(id))
        .where((f) => f != null)
        .cast<FeatureType>()
        .toList();
  }
}
