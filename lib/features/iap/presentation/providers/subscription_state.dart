import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/purchase_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';

part 'subscription_state.freezed.dart';

/// State for subscription management
@freezed
sealed class SubscriptionState with _$SubscriptionState {
  const SubscriptionState._();

  const factory SubscriptionState({
    @Default(false) bool isLoading,
    @Default([]) List<SubscriptionEntity> availableTiers,
    SubscriptionEntity? activeSubscription,
    PurchaseEntity? currentPurchase,
    Failure? failure,
    String? successMessage,
  }) = _SubscriptionState;

  bool get hasActiveSubscription => activeSubscription != null;

  SubscriptionTier get currentTier =>
      activeSubscription?.tier ?? SubscriptionTier.free;
}
