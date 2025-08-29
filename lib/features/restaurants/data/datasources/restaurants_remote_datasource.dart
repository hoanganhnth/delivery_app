import 'package:fpdart/fpdart.dart';

abstract class RestaurantsRemoteDataSource {
  Future<Either<Exception, Map<String, dynamic>>> getRestaurants();
  Future<Either<Exception, Map<String, dynamic>>> getRestaurant(String id);
}
