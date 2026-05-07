import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';

part 'consumable_state.freezed.dart';

@freezed
sealed class ConsumableState with _$ConsumableState {
  const ConsumableState._();

  const factory ConsumableState({
    @Default(false) bool isLoading,
    @Default([]) List<ConsumableEntity> products,
    @Default(0) int creditsBalance,
    @Default([]) List<ConsumableEntity> userVouchers,
    Failure? failure,
    String? successMessage,
  }) = _ConsumableState;

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
