import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/usecases/check_feature_unlocked_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_non_consumable_products_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_unlocked_features_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/purchase_non_consumable_usecase.dart';
import 'package:delivery_app/features/iap/presentation/providers/iap_providers.dart';
import 'package:delivery_app/features/iap/presentation/providers/non_consumable_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'non_consumable_notifier.g.dart';

@riverpod
class NonConsumableNotifier extends _$NonConsumableNotifier {
  late GetNonConsumableProductsUseCase _getNonConsumableProductsUseCase;
  late PurchaseNonConsumableUseCase _purchaseNonConsumableUseCase;
  late GetUnlockedFeaturesUseCase _getUnlockedFeaturesUseCase;
  late CheckFeatureUnlockedUseCase _checkFeatureUnlockedUseCase;

  @override
  Future<NonConsumableState> build() async {
    _getNonConsumableProductsUseCase =
        await ref.watch(getNonConsumableProductsUseCaseProvider.future);
    _purchaseNonConsumableUseCase =
        await ref.watch(purchaseNonConsumableUseCaseProvider.future);
    _getUnlockedFeaturesUseCase =
        await ref.watch(getUnlockedFeaturesUseCaseProvider.future);
    _checkFeatureUnlockedUseCase =
        await ref.watch(checkFeatureUnlockedUseCaseProvider.future);

    // Load initial data
    await _loadInitialData();

    return state.value ?? const NonConsumableState();
  }

  Future<void> _loadInitialData() async {
    state = const AsyncValue.loading();

    // Load products and unlocked features
    final productsResult = await _getNonConsumableProductsUseCase();
    final unlockedResult = await _getUnlockedFeaturesUseCase();

    productsResult.fold(
      (failure) {
        state = AsyncValue.data(NonConsumableState(failure: failure));
      },
      (products) {
        unlockedResult.fold(
          (failure) {
            state = AsyncValue.data(
              NonConsumableState(
                products: products,
                failure: failure,
              ),
            );
          },
          (unlocked) {
            state = AsyncValue.data(
              NonConsumableState(
                products: products,
                unlockedFeatures: unlocked,
              ),
            );
          },
        );
      },
    );
  }

  /// Load non-consumable products
  Future<void> loadProducts() async {
    final currentState = state.value ?? const NonConsumableState();
    state = AsyncValue.data(
      currentState.copyWith(isLoading: true, clearFailure: true),
    );

    final result = await _getNonConsumableProductsUseCase();

    result.fold(
      (failure) {
        state = AsyncValue.data(
          currentState.copyWith(isLoading: false, failure: failure),
        );
      },
      (products) {
        state = AsyncValue.data(
          currentState.copyWith(isLoading: false, products: products),
        );
      },
    );
  }

  /// Load unlocked features
  Future<void> loadUnlockedFeatures() async {
    final currentState = state.value ?? const NonConsumableState();

    final result = await _getUnlockedFeaturesUseCase();

    result.fold(
      (failure) {
        state = AsyncValue.data(
          currentState.copyWith(failure: failure),
        );
      },
      (unlocked) {
        state = AsyncValue.data(
          currentState.copyWith(unlockedFeatures: unlocked),
        );
      },
    );
  }

  /// Purchase a non-consumable product (unlock a feature)
  Future<void> purchaseFeature(FeatureType featureType) async {
    final currentState = state.value ?? const NonConsumableState();
    state = AsyncValue.data(
      currentState.copyWith(
          isLoading: true, clearFailure: true, clearSuccessMessage: true),
    );

    final result = await _purchaseNonConsumableUseCase(featureType);

    result.fold(
      (failure) {
        state = AsyncValue.data(
          currentState.copyWith(isLoading: false, failure: failure),
        );
      },
      (purchase) {
        // Add feature to unlocked list
        final updatedUnlocked =
            List<FeatureType>.from(currentState.unlockedFeatures)
              ..add(featureType);

        // Update product's unlocked status
        final updatedProducts = currentState.products.map((p) {
          if (p.featureType == featureType) {
            return NonConsumableEntity(
              product: p.product,
              featureType: p.featureType,
              isUnlocked: true,
              purchaseDate: DateTime.now(),
            );
          }
          return p;
        }).toList();

        state = AsyncValue.data(
          currentState.copyWith(
            isLoading: false,
            products: updatedProducts,
            unlockedFeatures: updatedUnlocked,
            successMessage:
                'Successfully unlocked ${featureType.displayName}!',
          ),
        );
      },
    );
  }

  /// Check if a feature is unlocked
  Future<bool> checkFeatureUnlocked(FeatureType featureType) async {
    final result = await _checkFeatureUnlockedUseCase(featureType);
    return result.getOrElse((_) => false);
  }

  /// Clear error message
  void clearError() {
    final currentState = state.value ?? const NonConsumableState();
    state = AsyncValue.data(currentState.copyWith(clearFailure: true));
  }

  /// Clear success message
  void clearSuccessMessage() {
    final currentState = state.value ?? const NonConsumableState();
    state = AsyncValue.data(currentState.copyWith(clearSuccessMessage: true));
  }
}
