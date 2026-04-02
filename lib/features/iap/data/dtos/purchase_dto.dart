import 'package:delivery_app/features/iap/domain/entities/purchase_entity.dart'
    as domain;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart' as iap;

part 'purchase_dto.freezed.dart';
part 'purchase_dto.g.dart';

@freezed
abstract class PurchaseDto with _$PurchaseDto {
  const PurchaseDto._();

  const factory PurchaseDto({
    required String purchaseId,
    required String productId,
    required String transactionDate,
    required String status,
    String? verificationData,
    @Default(false) bool pendingCompletePurchase,
  }) = _PurchaseDto;

  factory PurchaseDto.fromJson(Map<String, dynamic> json) =>
      _$PurchaseDtoFromJson(json);

  /// Convert from in_app_purchase PurchaseDetails
  factory PurchaseDto.fromPurchaseDetails(iap.PurchaseDetails details) {
    domain.PurchaseStatus status;
    
    switch (details.status) {
      case iap.PurchaseStatus.pending:
        status = domain.PurchaseStatus.pending;
        break;
      case iap.PurchaseStatus.purchased:
        status = domain.PurchaseStatus.purchased;
        break;
      case iap.PurchaseStatus.restored:
        status = domain.PurchaseStatus.restored;
        break;
      case iap.PurchaseStatus.error:
        status = domain.PurchaseStatus.error;
        break;
      case iap.PurchaseStatus.canceled:
        status = domain.PurchaseStatus.canceled;
        break;
    }

    return PurchaseDto(
      purchaseId: details.purchaseID ?? '',
      productId: details.productID,
      transactionDate: details.transactionDate ?? DateTime.now().toIso8601String(),
      status: status.name,
      verificationData: details.verificationData.serverVerificationData,
      pendingCompletePurchase: details.pendingCompletePurchase,
    );
  }

  /// Convert to domain entity
  domain.PurchaseEntity toEntity() {
    return domain.PurchaseEntity(
      purchaseId: purchaseId,
      productId: productId,
      transactionDate: transactionDate,
      status: domain.PurchaseStatus.values.firstWhere(
        (s) => s.name == status,
        orElse: () => domain.PurchaseStatus.error,
      ),
      verificationData: verificationData,
      pendingCompletePurchase: pendingCompletePurchase,
    );
  }
}
