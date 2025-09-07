import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant_entity.dart';
import '../entities/menu_item_entity.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants({
    double? latitude,
    double? longitude,
    String? category,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, RestaurantEntity>> getRestaurantById(num id);

  Future<Either<Failure, List<MenuItemEntity>>> getMenuItems(num restaurantId);

  Future<Either<Failure, List<RestaurantEntity>>> getNearbyRestaurants({
    required double latitude,
    required double longitude,
    double radius = 5.0, // km
  });

  Future<Either<Failure, List<RestaurantEntity>>> searchRestaurants({
    required String query,
    double? latitude,
    double? longitude,
  });

  Future<Either<Failure, List<String>>> getRestaurantCategories();
}
