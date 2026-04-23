import 'package:delivery_app/core/network/dio/authenticated_network_providers.dart';
import 'package:delivery_app/features/restaurants/data/datasources/restaurant_remote_datasource.dart';
import 'package:delivery_app/features/restaurants/data/datasources/restaurant_remote_datasource_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_network_providers.g.dart';

// Restaurant API service provider
@Riverpod(keepAlive: true)
RestaurantApiService restaurantApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider); // Use basic dio for restaurant endpoints
  return RestaurantApiService(dio);
}

// Restaurant remote data source provider
@Riverpod(keepAlive: true)
RestaurantRemoteDataSource restaurantRemoteDataSource(Ref ref) {
  final apiService = ref.watch(restaurantApiServiceProvider);
  return RestaurantRemoteDataSourceImpl(apiService);
}
