import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../data/repositories_impl/restaurant_repository_impl.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../../domain/usecases/get_restaurants_usecase.dart';
import '../../domain/usecases/get_restaurant_by_id_usecase.dart';
import '../../domain/usecases/get_menu_items_usecase.dart';
import '../../domain/usecases/search_restaurants_usecase.dart';
import '../../domain/usecases/get_restaurants_nearby_usecase.dart';
import 'restaurant_network_providers.dart';
import 'restaurants_notifier.dart';
import 'restaurant_detail_notifier.dart';
import 'restaurant_state.dart';

// Repository provider
final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final remoteDataSource = ref.watch(restaurantRemoteDataSourceProvider);
  return RestaurantRepositoryImpl(remoteDataSource: remoteDataSource);
});

// Use cases providers
final getRestaurantsUseCaseProvider = Provider<GetRestaurantsUseCase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return GetRestaurantsUseCase(repository);
});

final getRestaurantByIdUseCaseProvider = Provider<GetRestaurantByIdUseCase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return GetRestaurantByIdUseCase(repository);
});

final getMenuItemsUseCaseProvider = Provider<GetMenuItemsUseCase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return GetMenuItemsUseCase(repository);
});

final searchRestaurantsUseCaseProvider = Provider<SearchRestaurantsUseCase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return SearchRestaurantsUseCase(repository);
});

final getRestaurantsNearByUseCaseProvider = Provider<GetRestaurantsNearByUseCase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return GetRestaurantsNearByUseCase(repository);
});

// State notifier providers
final restaurantsNotifierProvider = StateNotifierProvider<RestaurantsNotifier, RestaurantsState>((ref) {
  return RestaurantsNotifier(
    getRestaurantsUseCase: ref.watch(getRestaurantsUseCaseProvider),
    searchRestaurantsUseCase: ref.watch(searchRestaurantsUseCaseProvider),
    getRestaurantsNearByUseCase: ref.watch(getRestaurantsNearByUseCaseProvider),
  );
});

final restaurantDetailNotifierProvider = StateNotifierProvider<RestaurantDetailNotifier, RestaurantDetailState>((ref) {
  return RestaurantDetailNotifier(
    getRestaurantByIdUseCase: ref.watch(getRestaurantByIdUseCaseProvider),
    getMenuItemsUseCase: ref.watch(getMenuItemsUseCaseProvider),
  );
});

// Convenience providers for backward compatibility
final restaurantsProvider = Provider<List<RestaurantEntity>>((ref) {
  final state = ref.watch(restaurantsNotifierProvider);
  return state.restaurants;
});

final restaurantDetailProvider = Provider<RestaurantDetailState>((ref) {
  return ref.watch(restaurantDetailNotifierProvider);
});

// Helper providers for specific use cases
final featuredRestaurantsProvider = Provider<List<RestaurantEntity>>((ref) {
  final state = ref.watch(restaurantsNotifierProvider);
  return state.featuredRestaurants;
});

final restaurantByIdProvider = Provider.family<RestaurantEntity?, num>((ref, restaurantId) {
  final state = ref.watch(restaurantsNotifierProvider);
  try {
    return state.restaurants.firstWhere((r) => r.id == restaurantId);
  } catch (e) {
    return null;
  }
});

final menuItemsByRestaurantProvider = Provider.family<List<MenuItemEntity>, num>((ref, restaurantId) {
  final state = ref.watch(restaurantDetailNotifierProvider);
  if (state.restaurant?.id == restaurantId) {
    return state.menuItems;
  }
  return [];
});

// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered restaurants based on search query
final filteredRestaurantsProvider = Provider<List<RestaurantEntity>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final state = ref.watch(restaurantsNotifierProvider);
  
  if (query.isEmpty) {
    return state.restaurants;
  }
  
  return state.restaurants
      .where((restaurant) =>
          restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
          (restaurant.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
      .toList();
});

// Loading states
final isLoadingRestaurantsProvider = Provider<bool>((ref) {
  return ref.watch(restaurantsNotifierProvider).isLoading;
});

final isLoadingRestaurantDetailProvider = Provider<bool>((ref) {
  return ref.watch(restaurantDetailNotifierProvider).isLoading;
});

final isLoadingSearchProvider = Provider<bool>((ref) {
  return ref.watch(restaurantsNotifierProvider).isSearchLoading;
});

final isLoadingNearbyProvider = Provider<bool>((ref) {
  return ref.watch(restaurantsNotifierProvider).isNearbyLoading;
});

final isLoadingFeaturedProvider = Provider<bool>((ref) {
  return ref.watch(restaurantsNotifierProvider).isFeaturedLoading;
});

final isLoadingMenuProvider = Provider<bool>((ref) {
  return ref.watch(restaurantDetailNotifierProvider).isMenuLoading;
});

// Error states
final restaurantsErrorProvider = Provider<String?>((ref) {
  return ref.watch(restaurantsNotifierProvider).errorMessage;
});

final restaurantDetailErrorProvider = Provider<String?>((ref) {
  return ref.watch(restaurantDetailNotifierProvider).errorMessage;
});

// Has data states
final hasRestaurantsProvider = Provider<bool>((ref) {
  final state = ref.watch(restaurantsNotifierProvider);
  return state.restaurants.isNotEmpty;
});

final hasRestaurantDetailProvider = Provider<bool>((ref) {
  final state = ref.watch(restaurantDetailNotifierProvider);
  return state.hasRestaurant;
});

final hasMenuItemsProvider = Provider<bool>((ref) {
  final state = ref.watch(restaurantDetailNotifierProvider);
  return state.hasMenuItems;
});
