import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/purchase_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';

/// State for subscription management
class SubscriptionState {
  final bool isLoading;
  final List<SubscriptionEntity> availableTiers;
  final SubscriptionEntity? activeSubscription;
  final PurchaseEntity? currentPurchase;
  final Failure? failure;
  final String? successMessage;

  const SubscriptionState({
    this.isLoading = false,
    this.availableTiers = const [],
    this.activeSubscription,
    this.currentPurchase,
    this.failure,
    this.successMessage,
  });

  SubscriptionState copyWith({
    bool? isLoading,
    List<SubscriptionEntity>? availableTiers,
    SubscriptionEntity? activeSubscription,
    PurchaseEntity? currentPurchase,
    Failure? failure,
    String? successMessage,
    bool clearFailure = false,
    bool clearSuccess = false,
    bool clearActiveSubscription = false,
  }) {
    return SubscriptionState(
      isLoading: isLoading ?? this.isLoading,
      availableTiers: availableTiers ?? this.availableTiers,
      activeSubscription: clearActiveSubscription
          ? null
          : (activeSubscription ?? this.activeSubscription),
      currentPurchase: currentPurchase ?? this.currentPurchase,
      failure: clearFailure ? null : (failure ?? this.failure),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  bool get hasActiveSubscription => activeSubscription != null;

  SubscriptionTier get currentTier =>
      activeSubscription?.tier ?? SubscriptionTier.free;
}
