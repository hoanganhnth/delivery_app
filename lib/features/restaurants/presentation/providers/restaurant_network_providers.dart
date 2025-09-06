import 'package:delivery_app/core/network/authenticated_network_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/network/network_providers.dart';
import '../../data/datasources/restaurant_remote_datasource.dart';
import '../../data/datasources/restaurant_remote_datasource_impl.dart';

// Restaurant API service provider
final restaurantApiServiceProvider = Provider<RestaurantApiService>((ref) {
  final dio = ref.watch(authenticatedDioProvider); // Use basic dio for restaurant endpoints
  return RestaurantApiService(dio);
});

// Restaurant remote data source provider
final restaurantRemoteDataSourceProvider = Provider<RestaurantRemoteDataSource>((ref) {
  final apiService = ref.watch(restaurantApiServiceProvider);
  return RestaurantRemoteDataSourceImpl(apiService);
});
