import 'package:delivery_app/features/iap/domain/usecases/add_credits_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/deduct_credits_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_consumable_products_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/get_user_credits_usecase.dart';
import 'package:delivery_app/features/iap/domain/usecases/purchase_consumable_usecase.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/presentation/providers/consumable_state.dart';
import 'package:delivery_app/features/iap/presentation/providers/iap_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'consumable_notifier.g.dart';

@riverpod
class ConsumableNotifier extends _$ConsumableNotifier {
  late GetConsumableProductsUseCase _getConsumableProductsUseCase;
  late PurchaseConsumableUseCase _purchaseConsumableUseCase;
  late GetUserCreditsUseCase _getUserCreditsUseCase;
  late AddCreditsUseCase _addCreditsUseCase;
  late DeductCreditsUseCase _deductCreditsUseCase;

  @override
  Future<ConsumableState> build() async {
    _getConsumableProductsUseCase =
        await ref.watch(getConsumableProductsUseCaseProvider.future);
    _purchaseConsumableUseCase =
        await ref.watch(purchaseConsumableUseCaseProvider.future);
    _getUserCreditsUseCase =
        await ref.watch(getUserCreditsUseCaseProvider.future);
    _addCreditsUseCase = await ref.watch(addCreditsUseCaseProvider.future);
    _deductCreditsUseCase =
        await ref.watch(deductCreditsUseCaseProvider.future);

    // Load initial data
    await _loadInitialData();

    return state.value ?? const ConsumableState();
  }

  Future<void> _loadInitialData() async {
    state = const AsyncValue.loading();

    // Load products and credits balance
    final productsResult = await _getConsumableProductsUseCase();
    final creditsResult = await _getUserCreditsUseCase();

    productsResult.fold(
      (failure) {
        state = AsyncValue.data(ConsumableState(failure: failure));
      },
      (products) {
        creditsResult.fold(
          (failure) {
            state = AsyncValue.data(
              ConsumableState(
                products: products,
                failure: failure,
              ),
            );
          },
          (credits) {
            state = AsyncValue.data(
              ConsumableState(
                products: products,
                creditsBalance: credits,
              ),
            );
          },
        );
      },
    );
  }

  /// Load consumable products
  Future<void> loadProducts() async {
    final currentState = state.value ?? const ConsumableState();
    state = AsyncValue.data(
      currentState.copyWith(isLoading: true, clearFailure: true),
    );

    final result = await _getConsumableProductsUseCase();

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

  /// Load user credits balance
  Future<void> loadCreditsBalance() async {
    final currentState = state.value ?? const ConsumableState();

    final result = await _getUserCreditsUseCase();

    result.fold(
      (failure) {
        state = AsyncValue.data(
          currentState.copyWith(failure: failure),
        );
      },
      (credits) {
        state = AsyncValue.data(
          currentState.copyWith(creditsBalance: credits),
        );
      },
    );
  }

  /// Purchase a consumable product
  Future<void> purchaseConsumable(ConsumableEntity product) async {
    final currentState = state.value ?? const ConsumableState();
    state = AsyncValue.data(
      currentState.copyWith(
          isLoading: true, clearFailure: true, clearSuccessMessage: true),
    );

    final result = await _purchaseConsumableUseCase(product.product.id);

    await result.fold(
      (failure) async {
        state = AsyncValue.data(
          currentState.copyWith(isLoading: false, failure: failure),
        );
      },
      (purchase) async {
        // Add credits or voucher based on product type
        if (product.type == ConsumableType.deliveryCredits) {
          final addResult = await _addCreditsUseCase(product.value.toInt());
          addResult.fold(
            (failure) {
              state = AsyncValue.data(
                currentState.copyWith(isLoading: false, failure: failure),
              );
            },
            (newBalance) {
              state = AsyncValue.data(
                currentState.copyWith(
                  isLoading: false,
                  creditsBalance: newBalance,
                  successMessage:
                      'Successfully purchased ${product.value.toInt()} credits!',
                ),
              );
            },
          );
        } else {
          // For vouchers, add to user's voucher list
          final updatedVouchers =
              List<ConsumableEntity>.from(currentState.userVouchers)
                ..add(product);
          state = AsyncValue.data(
            currentState.copyWith(
              isLoading: false,
              userVouchers: updatedVouchers,
              successMessage:
                  'Successfully purchased ${product.product.title}!',
            ),
          );
        }
      },
    );
  }

  /// Use credits for a purchase
  Future<bool> useCredits(int amount) async {
    final currentState = state.value ?? const ConsumableState();
    state = AsyncValue.data(
      currentState.copyWith(
          isLoading: true, clearFailure: true, clearSuccessMessage: true),
    );

    final result = await _deductCreditsUseCase(amount);

    return result.fold(
      (failure) {
        state = AsyncValue.data(
          currentState.copyWith(isLoading: false, failure: failure),
        );
        return false;
      },
      (newBalance) {
        state = AsyncValue.data(
          currentState.copyWith(
            isLoading: false,
            creditsBalance: newBalance,
            successMessage: 'Used $amount credits',
          ),
        );
        return true;
      },
    );
  }

  /// Clear error message
  void clearError() {
    final currentState = state.value ?? const ConsumableState();
    state = AsyncValue.data(currentState.copyWith(clearFailure: true));
  }

  /// Clear success message
  void clearSuccessMessage() {
    final currentState = state.value ?? const ConsumableState();
    state = AsyncValue.data(currentState.copyWith(clearSuccessMessage: true));
  }
}
