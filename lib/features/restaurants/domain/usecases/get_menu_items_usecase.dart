import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/menu_item_entity.dart';
import '../repositories/restaurant_repository.dart';

class GetMenuItemsUseCase extends UseCase<List<MenuItemEntity>, String> {
  final RestaurantRepository repository;

  GetMenuItemsUseCase(this.repository);

  @override
  Future<Either<Failure, List<MenuItemEntity>>> call(String restaurantId) async {
    if (restaurantId.isEmpty) {
      return left(const ValidationFailure('Restaurant ID cannot be empty'));
    }
    
    return await repository.getMenuItems(restaurantId);
  }
}
