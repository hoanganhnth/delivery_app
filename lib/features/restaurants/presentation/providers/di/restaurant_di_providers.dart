import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/restaurant_entity.dart';
import '../../../domain/entities/menu_item_entity.dart';
import '../../../data/repositories_impl/restaurant_repository_impl.dart';
import '../../../domain/repositories/restaurant_repository.dart';
import '../../../domain/usecases/get_restaurants_usecase.dart';
import '../../../domain/usecases/get_restaurant_by_id_usecase.dart';
import '../../../domain/usecases/get_menu_items_usecase.dart';
import '../../../domain/usecases/search_restaurants_usecase.dart';
import '../../../domain/usecases/get_restaurants_nearby_usecase.dart';
import 'restaurant_network_providers.dart';
import '../list/restaurants_notifier.dart';
import '../detail/restaurant_detail_notifier.dart';

part 'restaurant_di_providers.g.dart';

// Repository provider
@Riverpod(keepAlive: true)
RestaurantRepository restaurantRepository(Ref ref) {
  final remoteDataSource = ref.watch(restaurantRemoteDataSourceProvider);
  return RestaurantRepositoryImpl(remoteDataSource: remoteDataSource);
}

// Use cases providers
@Riverpod(keepAlive: true)
GetRestaurantsUseCase getRestaurantsUseCase(Ref ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return GetRestaurantsUseCase(repository);
}

@Riverpod(keepAlive: true)
GetRestaurantByIdUseCase getRestaurantByIdUseCase(Ref ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return GetRestaurantByIdUseCase(repository);
}

@Riverpod(keepAlive: true)
GetMenuItemsUseCase getMenuItemsUseCase(Ref ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return GetMenuItemsUseCase(repository);
}

@Riverpod(keepAlive: true)
SearchRestaurantsUseCase searchRestaurantsUseCase(Ref ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return SearchRestaurantsUseCase(repository);
}

@Riverpod(keepAlive: true)
GetRestaurantsNearByUseCase getRestaurantsNearByUseCase(Ref ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return GetRestaurantsNearByUseCase(repository);
}

// Helper providers for specific use cases
@riverpod
List<RestaurantEntity> featuredRestaurants(Ref ref) {
  final state = ref.watch(restaurantsProvider);
  return state.featuredRestaurants;
}

@riverpod
RestaurantEntity? restaurantById(Ref ref, num restaurantId) {
  final state = ref.watch(restaurantsProvider);
  try {
    return state.restaurants.firstWhere((r) => r.id == restaurantId);
  } catch (e) {
    return null;
  }
}

@riverpod
List<MenuItemEntity> menuItemsByRestaurant(Ref ref, num restaurantId) {
  final state = ref.watch(restaurantDetailProvider);
  if (state.restaurant?.id == restaurantId) {
    return state.menuItems;
  }
  return [];
}

// Search query provider
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

// Filtered restaurants based on search query
@riverpod
List<RestaurantEntity> filteredRestaurants(Ref ref) {
  final query = ref.watch(searchQueryProvider);
  final state = ref.watch(restaurantsProvider);
  
  if (query.isEmpty) {
    return state.restaurants;
  }
  
  return state.restaurants
      .where((restaurant) =>
          restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
          (restaurant.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
      .toList();
}

// Loading states
@riverpod
bool isLoadingRestaurants(Ref ref) {
  return ref.watch(restaurantsProvider).isLoading;
}

@riverpod
bool isLoadingRestaurantDetail(Ref ref, num restaurantId) {
  return ref.watch(restaurantDetailProvider).isLoading;
}

@riverpod
bool isLoadingSearch(Ref ref) {
  return ref.watch(restaurantsProvider).isSearchLoading;
}

@riverpod
bool isLoadingNearby(Ref ref) {
  return ref.watch(restaurantsProvider).isNearbyLoading;
}

@riverpod
bool isLoadingFeatured(Ref ref) {
  return ref.watch(restaurantsProvider).isFeaturedLoading;
}

@riverpod
bool isLoadingMenu(Ref ref, num restaurantId) {
  return ref.watch(restaurantDetailProvider).isMenuLoading;
}

// Error states
@riverpod
String? restaurantsError(Ref ref) {
  return ref.watch(restaurantsProvider).errorMessage;
}

@riverpod
String? restaurantDetailError(Ref ref, num restaurantId) {
  return ref.watch(restaurantDetailProvider).errorMessage;
}

// Has data states
@riverpod
bool hasRestaurants(Ref ref) {
  final state = ref.watch(restaurantsProvider);
  return state.restaurants.isNotEmpty;
}

@riverpod
bool hasRestaurantDetail(Ref ref, num restaurantId) {
  final state = ref.watch(restaurantDetailProvider);
  return state.hasRestaurant;
}

@riverpod
bool hasMenuItems(Ref ref, num restaurantId) {
  final state = ref.watch(restaurantDetailProvider);
  return state.hasMenuItems;
}
