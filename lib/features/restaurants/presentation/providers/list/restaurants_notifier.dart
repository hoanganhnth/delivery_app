import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/utils/logger/app_logger.dart';
import '../../../domain/usecases/get_restaurants_usecase.dart';
import '../../../domain/usecases/search_restaurants_usecase.dart';
import 'restaurants_state.dart';
import '../di/restaurant_di_providers.dart';

part 'restaurants_notifier.g.dart';

@riverpod
class RestaurantsNotifier extends _$RestaurantsNotifier {
  late final GetRestaurantsUseCase _getRestaurantsUseCase;
  late final SearchRestaurantsUseCase _searchRestaurantsUseCase;

  @override
  RestaurantsState build() {
    _getRestaurantsUseCase = ref.read(getRestaurantsUseCaseProvider);
    _searchRestaurantsUseCase = ref.read(searchRestaurantsUseCaseProvider);
    return const RestaurantsState();
  }

  /// Load all restaurants
  Future<void> loadRestaurants({
    double? latitude,
    double? longitude,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    state = state.copyWith(isLoading: true, failure: null);

    AppLogger.d(
      'RestaurantsNotifier: Loading restaurants (page: $page, limit: $limit)',
    );

    final params = GetRestaurantsParams(
      latitude: latitude,
      longitude: longitude,
      category: category,
      page: page,
      limit: limit,
    );

    final result = await _getRestaurantsUseCase.call(params);

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        AppLogger.e(
          'RestaurantsNotifier: Failed to load restaurants - ${failure.message}',
        );
        state = state.copyWith(isLoading: false, failure: failure);
      },
      (restaurants) {
        AppLogger.i(
          'RestaurantsNotifier: Successfully loaded ${restaurants.length} restaurants',
        );
        state = state.copyWith(isLoading: false, restaurants: restaurants);
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

    state = state.copyWith(isSearchLoading: true, failure: null);

    AppLogger.d(
      'RestaurantsNotifier: Searching restaurants with query: "$query"',
    );

    final params = SearchRestaurantsParams(
      query: query,
      latitude: latitude,
      longitude: longitude,
    );

    final result = await _searchRestaurantsUseCase.call(params);

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        AppLogger.e(
          'RestaurantsNotifier: Failed to search restaurants - ${failure.message}',
        );
        state = state.copyWith(isSearchLoading: false, failure: failure);
      },
      (restaurants) {
        AppLogger.i(
          'RestaurantsNotifier: Search found ${restaurants.length} restaurants',
        );
        state = state.copyWith(
          isSearchLoading: false,
          restaurants: restaurants,
        );
      },
    );
  }

  /// Load featured restaurants (first few restaurants)
  Future<void> loadFeaturedRestaurants() async {
    state = state.copyWith(isFeaturedLoading: true, failure: null);

    AppLogger.d('RestaurantsNotifier: Loading featured restaurants');

    final params = GetRestaurantsParams(
      page: 1,
      limit: 6, // Load more than 3 to have variety
    );

    final result = await _getRestaurantsUseCase.call(params);

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        AppLogger.e(
          'RestaurantsNotifier: Failed to load featured restaurants - ${failure.message}',
        );
        state = state.copyWith(isFeaturedLoading: false, failure: failure);
      },
      (restaurants) {
        AppLogger.i(
          'RestaurantsNotifier: Successfully loaded ${restaurants.length} featured restaurants',
        );
        state = state.copyWith(
          isFeaturedLoading: false,
          restaurants: restaurants
              .take(3)
              .toList(), // Take only first 3 for featured
        );
      },
    );
  }

  /// Clear restaurants list
  void clearRestaurants() {
    AppLogger.d('RestaurantsNotifier: Clearing restaurants');
    state = state.copyWith(restaurants: const [], failure: null);
  }

  /// Refresh restaurants (reload current data)
  Future<void> refreshRestaurants() async {
    AppLogger.d('RestaurantsNotifier: Refreshing restaurants');
    await loadRestaurants();
  }
}
