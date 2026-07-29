import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/utils/logger/app_logger.dart';
import '../../../domain/usecases/get_restaurant_by_id_usecase.dart';
import '../../../domain/usecases/get_menu_items_usecase.dart';
import 'restaurant_detail_state.dart';
import '../di/restaurant_di_providers.dart';

part 'restaurant_detail_notifier.g.dart';

@riverpod
class RestaurantDetailNotifier extends _$RestaurantDetailNotifier {
  late final GetRestaurantByIdUseCase _getRestaurantByIdUseCase;
  late final GetMenuItemsUseCase _getMenuItemsUseCase;

  @override
  RestaurantDetailState build() {
    _getRestaurantByIdUseCase = ref.read(getRestaurantByIdUseCaseProvider);
    _getMenuItemsUseCase = ref.read(getMenuItemsUseCaseProvider);
    return const RestaurantDetailState();
  }

  /// Load restaurant details and menu items
  Future<void> loadRestaurantDetail(num restaurantId) async {
    // if (restaurantId ) {
    //   AppLogger.e('RestaurantDetailNotifier: Restaurant ID is empty');
    //   return;
    // }

    state = state.copyWith(isLoading: true, failure: null);

    AppLogger.d(
      'RestaurantDetailNotifier: Loading restaurant detail for ID: $restaurantId',
    );

    // Load restaurant details first
    final restaurantResult = await _getRestaurantByIdUseCase.call(restaurantId);

    if (!ref.mounted) return;

    restaurantResult.fold(
      (failure) {
        AppLogger.e(
          'RestaurantDetailNotifier: Failed to load restaurant - ${failure.message}',
        );
        state = state.copyWith(
          isLoading: false,
          restaurant: null,
          menuItems: const [],
          failure: failure,
        );
      },
      (restaurant) async {
        AppLogger.i(
          'RestaurantDetailNotifier: Successfully loaded restaurant: ${restaurant.name}',
        );

        // Load menu items
        final menuResult = await _getMenuItemsUseCase.call(restaurantId);

        if (!ref.mounted) return;

        menuResult.fold(
          (failure) {
            AppLogger.e(
              'RestaurantDetailNotifier: Failed to load menu items - ${failure.message}',
            );
            state = state.copyWith(
              isLoading: false,
              restaurant: restaurant,
              menuItems: const [],
              failure: failure,
            );
          },
          (menuItems) {
            AppLogger.i(
              'RestaurantDetailNotifier: Successfully loaded ${menuItems.length} menu items',
            );
            state = state.copyWith(
              isLoading: false,
              restaurant: restaurant,
              menuItems: menuItems,
            );
          },
        );
      },
    );
  }

  /// Load only menu items for a restaurant
  Future<void> loadMenuItems(num restaurantId) async {
    // if (restaurantId.isEmpty) {
    //   AppLogger.e('RestaurantDetailNotifier: Restaurant ID is empty for menu items');
    //   return;
    // }

    state = state.copyWith(isMenuLoading: true, failure: null);

    AppLogger.d(
      'RestaurantDetailNotifier: Loading menu items for restaurant: $restaurantId',
    );

    final result = await _getMenuItemsUseCase.call(restaurantId);

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        AppLogger.e(
          'RestaurantDetailNotifier: Failed to load menu items - ${failure.message}',
        );
        state = state.copyWith(isMenuLoading: false, failure: failure);
      },
      (menuItems) {
        AppLogger.i(
          'RestaurantDetailNotifier: Successfully loaded ${menuItems.length} menu items',
        );
        state = state.copyWith(isMenuLoading: false, menuItems: menuItems);
      },
    );
  }

  /// Clear restaurant detail data
  void clearRestaurantDetail() {
    AppLogger.d('RestaurantDetailNotifier: Clearing restaurant detail');
    state = state.copyWith(
      restaurant: null,
      menuItems: const [],
      failure: null,
    );
  }

  /// Refresh restaurant detail data
  Future<void> refreshRestaurantDetail(num restaurantId) async {
    AppLogger.d(
      'RestaurantDetailNotifier: Refreshing restaurant detail for: $restaurantId',
    );
    await loadRestaurantDetail(restaurantId);
  }
}
