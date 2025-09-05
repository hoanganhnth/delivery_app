import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant_entity.dart';
import '../repositories/restaurant_repository.dart';

class GetRestaurantByIdUseCase extends UseCase<RestaurantEntity, String> {
  final RestaurantRepository repository;

  GetRestaurantByIdUseCase(this.repository);

  @override
  Future<Either<Failure, RestaurantEntity>> call(String restaurantId) async {
    if (restaurantId.isEmpty) {
      return left(const ValidationFailure('Restaurant ID cannot be empty'));
    }
    
    return await repository.getRestaurantById(restaurantId);
  }
}
