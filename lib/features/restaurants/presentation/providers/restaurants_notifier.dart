import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/usecases/get_restaurants_usecase.dart';
import '../../domain/usecases/search_restaurants_usecase.dart';
import '../../domain/usecases/get_restaurants_nearby_usecase.dart';
import '../mock/mock_restaurant_service.dart';
import 'restaurant_state.dart';

class RestaurantsNotifier extends StateNotifier<RestaurantsState> {
  final GetRestaurantsUseCase _getRestaurantsUseCase;
  final SearchRestaurantsUseCase _searchRestaurantsUseCase;
  final GetRestaurantsNearByUseCase _getRestaurantsNearByUseCase;

  RestaurantsNotifier({
    required GetRestaurantsUseCase getRestaurantsUseCase,
    required SearchRestaurantsUseCase searchRestaurantsUseCase,
    required GetRestaurantsNearByUseCase getRestaurantsNearByUseCase,
  }) : _getRestaurantsUseCase = getRestaurantsUseCase,
       _searchRestaurantsUseCase = searchRestaurantsUseCase,
       _getRestaurantsNearByUseCase = getRestaurantsNearByUseCase,
       super(const RestaurantsState());

  /// Load all restaurants
  Future<void> loadRestaurants({
    double? latitude,
    double? longitude,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    AppLogger.d('RestaurantsNotifier: Loading restaurants (page: $page, limit: $limit)');

    final params = GetRestaurantsParams(
      latitude: latitude,
      longitude: longitude,
      category: category,
      page: page,
      limit: limit,
    );

    final result = await _getRestaurantsUseCase.call(params);
    
    result.fold(
      (failure) {
        AppLogger.e('RestaurantsNotifier: Failed to load restaurants - ${failure.message}');
        // Fallback to mock data if API fails
        _loadMockRestaurants();
      },
      (restaurants) {
        AppLogger.i('RestaurantsNotifier: Successfully loaded ${restaurants.length} restaurants');
        state = state.copyWith(
          isLoading: false,
          restaurants: restaurants,
        );
      },
    );
  }

  /// Search restaurants by query
  Future<void> searchRestaurants(
    String query, {
    double? latitude,
    double? longitude,
  }) async {
    if (query.trim().isEmpty) {
      await loadRestaurants(latitude: latitude, longitude: longitude);
      return;
    }

    state = state.copyWith(isSearchLoading: true, clearFailure: true);

    AppLogger.d('RestaurantsNotifier: Searching restaurants with query: "$query"');

    final params = SearchRestaurantsParams(
      query: query,
      latitude: latitude,
      longitude: longitude,
    );

    final result = await _searchRestaurantsUseCase.call(params);
    
    result.fold(
      (failure) {
        AppLogger.e('RestaurantsNotifier: Failed to search restaurants - ${failure.message}');
        // Fallback to mock search
        _searchMockRestaurants(query);
      },
      (restaurants) {
        AppLogger.i('RestaurantsNotifier: Search found ${restaurants.length} restaurants');
        state = state.copyWith(
          isSearchLoading: false,
          restaurants: restaurants,
        );
      },
    );
  }

  /// Load nearby restaurants
  Future<void> loadNearbyRestaurants({
    required double latitude,
    required double longitude,
    double? radius,
    String? category,
  }) async {
    state = state.copyWith(isNearbyLoading: true, clearFailure: true);

    AppLogger.d('RestaurantsNotifier: Loading nearby restaurants at ($latitude, $longitude)');

    final params = GetRestaurantsNearByParams(
      latitude: latitude,
      longitude: longitude,
      radius: radius,
    );

    final result = await _getRestaurantsNearByUseCase.call(params);
    
    result.fold(
      (failure) {
        AppLogger.e('RestaurantsNotifier: Failed to load nearby restaurants - ${failure.message}');
        // Fallback to mock data
        _loadMockRestaurants();
      },
      (restaurants) {
        AppLogger.i('RestaurantsNotifier: Successfully loaded ${restaurants.length} nearby restaurants');
        state = state.copyWith(
          isNearbyLoading: false,
          restaurants: restaurants,
        );
      },
    );
  }

  /// Load featured restaurants (first few restaurants)
  Future<void> loadFeaturedRestaurants() async {
    state = state.copyWith(isFeaturedLoading: true, clearFailure: true);

    AppLogger.d('RestaurantsNotifier: Loading featured restaurants');

    final params = GetRestaurantsParams(
      page: 1,
      limit: 6, // Load more than 3 to have variety
    );

    final result = await _getRestaurantsUseCase.call(params);
    
    result.fold(
      (failure) {
        AppLogger.e('RestaurantsNotifier: Failed to load featured restaurants - ${failure.message}');
        // Fallback to mock data
        _loadMockFeaturedRestaurants();
      },
      (restaurants) {
        AppLogger.i('RestaurantsNotifier: Successfully loaded ${restaurants.length} featured restaurants');
        state = state.copyWith(
          isFeaturedLoading: false,
          restaurants: restaurants.take(3).toList(), // Take only first 3 for featured
        );
      },
    );
  }

  /// Clear restaurants list
  void clearRestaurants() {
    AppLogger.d('RestaurantsNotifier: Clearing restaurants');
    state = state.copyWith(clearRestaurants: true, clearFailure: true);
  }

  /// Refresh restaurants (reload current data)
  Future<void> refreshRestaurants() async {
    AppLogger.d('RestaurantsNotifier: Refreshing restaurants');
    await loadRestaurants();
  }

  // Fallback methods using mock data

  void _loadMockRestaurants() {
    AppLogger.w('RestaurantsNotifier: Using mock data as fallback');
    try {
      final mockRestaurants = MockRestaurantService.getMockRestaurants();
      state = state.copyWith(
        isLoading: false,
        isNearbyLoading: false,
        restaurants: mockRestaurants,
      );
    } catch (e) {
      AppLogger.e('RestaurantsNotifier: Failed to load mock data - $e');
      state = state.copyWith(
        isLoading: false,
        isNearbyLoading: false,
        restaurants: const [],
      );
    }
  }

  void _loadMockFeaturedRestaurants() {
    AppLogger.w('RestaurantsNotifier: Using mock featured data as fallback');
    try {
      final mockRestaurants = MockRestaurantService.getMockRestaurants().take(3).toList();
      state = state.copyWith(
        isFeaturedLoading: false,
        restaurants: mockRestaurants,
      );
    } catch (e) {
      AppLogger.e('RestaurantsNotifier: Failed to load mock featured data - $e');
      state = state.copyWith(
        isFeaturedLoading: false,
        restaurants: const [],
      );
    }
  }

  void _searchMockRestaurants(String query) {
    AppLogger.w('RestaurantsNotifier: Using mock search as fallback');
    try {
      final allRestaurants = MockRestaurantService.getMockRestaurants();
      final filteredRestaurants = allRestaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
              (restaurant.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
          .toList();
      
      state = state.copyWith(
        isSearchLoading: false,
        restaurants: filteredRestaurants,
      );
    } catch (e) {
      AppLogger.e('RestaurantsNotifier: Failed to search mock data - $e');
      state = state.copyWith(
        isSearchLoading: false,
        restaurants: const [],
      );
    }
  }
}
