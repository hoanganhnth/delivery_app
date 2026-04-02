import 'package:delivery_app/features/iap/domain/entities/iap_product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart' as iap;

part 'iap_product_dto.freezed.dart';
part 'iap_product_dto.g.dart';

@freezed
abstract class IapProductDto with _$IapProductDto {
  const IapProductDto._();

  const factory IapProductDto({
    required String id,
    required String title,
    required String description,
    required String price,
    required String currencyCode,
    required double rawPrice,
    required String productType,
  }) = _IapProductDto;

  factory IapProductDto.fromJson(Map<String, dynamic> json) =>
      _$IapProductDtoFromJson(json);

  /// Convert from in_app_purchase ProductDetails
  factory IapProductDto.fromProductDetails(iap.ProductDetails details) {
    IapProductType productType;
    
    // Determine product type based on ID convention
    if (details.id.contains('subscription') ||
        details.id.contains('premium') ||
        details.id.contains('vip')) {
      productType = IapProductType.subscription;
    } else if (details.id.contains('consumable') ||
        details.id.contains('voucher') ||
        details.id.contains('credits')) {
      productType = IapProductType.consumable;
    } else {
      productType = IapProductType.nonConsumable;
    }

    return IapProductDto(
      id: details.id,
      title: details.title,
      description: details.description,
      price: details.price,
      currencyCode: details.currencyCode,
      rawPrice: details.rawPrice,
      productType: productType.name,
    );
  }

  /// Convert to domain entity
  IapProductEntity toEntity() {
    return IapProductEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      currencyCode: currencyCode,
      rawPrice: rawPrice,
      productType: IapProductType.values.firstWhere(
        (type) => type.name == productType,
        orElse: () => IapProductType.nonConsumable,
      ),
    );
  }
}
