import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';

/// State for consumable IAP
class ConsumableState {
  final bool isLoading;
  final List<ConsumableEntity> products;
  final int creditsBalance;
  final List<ConsumableEntity> userVouchers;
  final Failure? failure;
  final String? successMessage;

  const ConsumableState({
    this.isLoading = false,
    this.products = const [],
    this.creditsBalance = 0,
    this.userVouchers = const [],
    this.failure,
    this.successMessage,
  });

  ConsumableState copyWith({
    bool? isLoading,
    List<ConsumableEntity>? products,
    int? creditsBalance,
    List<ConsumableEntity>? userVouchers,
    Failure? failure,
    String? successMessage,
    bool clearFailure = false,
    bool clearSuccessMessage = false,
  }) {
    return ConsumableState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      creditsBalance: creditsBalance ?? this.creditsBalance,
      userVouchers: userVouchers ?? this.userVouchers,
      failure: clearFailure ? null : (failure ?? this.failure),
      successMessage: clearSuccessMessage
          ? null
          : (successMessage ?? this.successMessage),
    );
  }

  /// Get credit products only
  List<ConsumableEntity> get creditProducts => products
      .where((p) => p.type == ConsumableType.deliveryCredits)
      .toList();

  /// Get voucher products only
  List<ConsumableEntity> get voucherProducts => products
      .where((p) =>
          p.type == ConsumableType.discountVoucher ||
          p.type == ConsumableType.cashVoucher)
      .toList();

  /// Get gift card products only
  List<ConsumableEntity> get giftCardProducts =>
      products.where((p) => p.type == ConsumableType.giftCard).toList();
}
