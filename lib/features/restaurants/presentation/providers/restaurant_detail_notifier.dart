import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/usecases/get_restaurant_by_id_usecase.dart';
import '../../domain/usecases/get_menu_items_usecase.dart';
import '../mock/mock_restaurant_service.dart';
import 'restaurant_state.dart';

class RestaurantDetailNotifier extends StateNotifier<RestaurantDetailState> {
  final GetRestaurantByIdUseCase _getRestaurantByIdUseCase;
  final GetMenuItemsUseCase _getMenuItemsUseCase;

  RestaurantDetailNotifier({
    required GetRestaurantByIdUseCase getRestaurantByIdUseCase,
    required GetMenuItemsUseCase getMenuItemsUseCase,
  }) : _getRestaurantByIdUseCase = getRestaurantByIdUseCase,
       _getMenuItemsUseCase = getMenuItemsUseCase,
       super(const RestaurantDetailState());

  /// Load restaurant details and menu items
  Future<void> loadRestaurantDetail(num restaurantId) async {
    // if (restaurantId ) {
    //   AppLogger.e('RestaurantDetailNotifier: Restaurant ID is empty');
    //   return;
    // }

    state = state.copyWith(isLoading: true, clearFailure: true);

    AppLogger.d('RestaurantDetailNotifier: Loading restaurant detail for ID: $restaurantId');

    // Load restaurant details first
    final restaurantResult = await _getRestaurantByIdUseCase.call(restaurantId);
    
    restaurantResult.fold(
      (failure) {
        AppLogger.e('RestaurantDetailNotifier: Failed to load restaurant - ${failure.message}');
        // Fallback to mock restaurant
        _loadMockRestaurantDetail(restaurantId);
      },
      (restaurant) async {
        AppLogger.i('RestaurantDetailNotifier: Successfully loaded restaurant: ${restaurant.name}');
        
        // Load menu items
        final menuResult = await _getMenuItemsUseCase.call(restaurantId);
        menuResult.fold(
          (failure) {
            AppLogger.e('RestaurantDetailNotifier: Failed to load menu items - ${failure.message}');
            // Use restaurant data but fallback to mock menu
            _loadMockMenuItems(restaurantId, restaurant);
          },
          (menuItems) {
            AppLogger.i('RestaurantDetailNotifier: Successfully loaded ${menuItems.length} menu items');
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

    state = state.copyWith(isMenuLoading: true, clearFailure: true);

    AppLogger.d('RestaurantDetailNotifier: Loading menu items for restaurant: $restaurantId');

    final result = await _getMenuItemsUseCase.call(restaurantId);
    
    result.fold(
      (failure) {
        AppLogger.e('RestaurantDetailNotifier: Failed to load menu items - ${failure.message}');
        // Fallback to mock menu items
        _loadMockMenuItemsOnly(restaurantId);
      },
      (menuItems) {
        AppLogger.i('RestaurantDetailNotifier: Successfully loaded ${menuItems.length} menu items');
        state = state.copyWith(
          isMenuLoading: false,
          menuItems: menuItems,
        );
      },
    );
  }

  /// Clear restaurant detail data
  void clearRestaurantDetail() {
    AppLogger.d('RestaurantDetailNotifier: Clearing restaurant detail');
    state = state.copyWith(
      clearRestaurant: true,
      clearMenuItems: true,
      clearFailure: true,
    );
  }

  /// Refresh restaurant detail data
  Future<void> refreshRestaurantDetail(num restaurantId) async {
    AppLogger.d('RestaurantDetailNotifier: Refreshing restaurant detail for: $restaurantId');
    await loadRestaurantDetail(restaurantId);
  }

  // Fallback methods using mock data

  void _loadMockRestaurantDetail(num restaurantId) {
    AppLogger.w('RestaurantDetailNotifier: Using mock data as fallback');
    try {
      final allRestaurants = MockRestaurantService.getMockRestaurants();
      final restaurant = allRestaurants.firstWhere(
        (r) => r.id == restaurantId,
        orElse: () => allRestaurants.first,
      );
      
      final menuItems = MockRestaurantService.getMockMenuItems(restaurantId);
      
      state = state.copyWith(
        isLoading: false,
        restaurant: restaurant,
        menuItems: menuItems,
      );
    } catch (e) {
      AppLogger.e('RestaurantDetailNotifier: Failed to load mock restaurant detail - $e');
      state = state.copyWith(
        isLoading: false,
        restaurant: null,
        menuItems: const [],
      );
    }
  }

  void _loadMockMenuItems(num restaurantId, RestaurantEntity restaurant) {
    AppLogger.w('RestaurantDetailNotifier: Using mock menu items as fallback');
    try {
      final menuItems = MockRestaurantService.getMockMenuItems(restaurantId);
      state = state.copyWith(
        isLoading: false,
        restaurant: restaurant,
        menuItems: menuItems,
      );
    } catch (e) {
      AppLogger.e('RestaurantDetailNotifier: Failed to load mock menu items - $e');
      state = state.copyWith(
        isLoading: false,
        restaurant: restaurant,
        menuItems: const [],
      );
    }
  }

  void _loadMockMenuItemsOnly(num restaurantId) {
    AppLogger.w('RestaurantDetailNotifier: Using mock menu items only as fallback');
    try {
      final menuItems = MockRestaurantService.getMockMenuItems(restaurantId);
      state = state.copyWith(
        isMenuLoading: false,
        menuItems: menuItems,
      );
    } catch (e) {
      AppLogger.e('RestaurantDetailNotifier: Failed to load mock menu items only - $e');
      state = state.copyWith(
        isMenuLoading: false,
        menuItems: const [],
      );
    }
  }
}
