import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_active_subscription_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_subscription_tiers_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/purchase_subscription_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/restore_purchases_usecase.dart';
import 'package:delivery_app/features/iap/presentation/providers/subscription_state.dart';
import 'package:delivery_app/features/iap/presentation/providers/iap_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_notifier.g.dart';

@riverpod
class SubscriptionNotifier extends _$SubscriptionNotifier {
  late GetSubscriptionTiersUseCase _getSubscriptionTiersUseCase;
  late GetActiveSubscriptionUseCase _getActiveSubscriptionUseCase;
  late PurchaseSubscriptionUseCase _purchaseSubscriptionUseCase;
  late RestorePurchasesUseCase _restorePurchasesUseCase;
  
  bool _isInitialized = false;

  @override
  SubscriptionState build() {
    // Schedule initialization
    _initializeUseCases();
    return const SubscriptionState();
  }
  
  Future<void> _initializeUseCases() async {
    if (_isInitialized) return;
    
    try {
      _getSubscriptionTiersUseCase = await ref.read(getSubscriptionTiersUseCaseProvider.future);
      _getActiveSubscriptionUseCase = await ref.read(getActiveSubscriptionUseCaseProvider.future);
      _purchaseSubscriptionUseCase = await ref.read(purchaseSubscriptionUseCaseProvider.future);
      _restorePurchasesUseCase = await ref.read(restorePurchasesUseCaseProvider.future);
      
      _isInitialized = true;
      
      // Load initial data after use cases are ready
      await loadSubscriptionTiers();
      await loadActiveSubscription();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        failure: null, // Handle failure if needed
      );
    }
  }

  /// Load available subscription tiers
  Future<void> loadSubscriptionTiers() async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _getSubscriptionTiersUseCase();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (tiers) => state = state.copyWith(
        isLoading: false,
        availableTiers: tiers,
      ),
    );
  }

  /// Load active subscription
  Future<void> loadActiveSubscription() async {
    final result = await _getActiveSubscriptionUseCase();

    result.fold(
      (failure) => state = state.copyWith(failure: failure),
      (subscription) => state = state.copyWith(
        activeSubscription: subscription,
      ),
    );
  }

  /// Purchase a subscription tier
  Future<void> purchaseSubscription(SubscriptionTier tier) async {
    if (tier == SubscriptionTier.free) {
      state = state.copyWith(
        failure: null,
        successMessage: 'You are already on the free tier',
      );
      return;
    }

    state = state.copyWith(isLoading: true, clearFailure: true, clearSuccess: true);

    final result = await _purchaseSubscriptionUseCase(tier);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (purchase) {
        state = state.copyWith(
          isLoading: false,
          currentPurchase: purchase,
          successMessage: 'Purchase initiated successfully',
        );
        
        // Reload active subscription after purchase
        loadActiveSubscription();
      },
    );
  }

  /// Restore previous purchases
  Future<void> restorePurchases() async {
    state = state.copyWith(isLoading: true, clearFailure: true, clearSuccess: true);

    final result = await _restorePurchasesUseCase();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (purchases) {
        state = state.copyWith(
          isLoading: false,
          successMessage: purchases.isEmpty
              ? 'No purchases to restore'
              : 'Purchases restored successfully',
        );
        
        // Reload subscriptions after restore
        loadActiveSubscription();
        loadSubscriptionTiers();
      },
    );
  }

  /// Cancel subscription (set to free tier)
  Future<void> cancelSubscription() async {
    // In real app, this would call API to cancel subscription
    // For now, just clear local state
    state = state.copyWith(
      clearActiveSubscription: true,
      successMessage: 'Subscription canceled',
    );
  }

  /// Clear success/error messages
  void clearMessages() {
    state = state.copyWith(clearFailure: true, clearSuccess: true);
  }

  /// Clear success message only
  void clearSuccessMessage() {
    state = state.copyWith(clearSuccess: true);
  }

  /// Clear error/failure only
  void clearError() {
    state = state.copyWith(clearFailure: true);
  }
}
