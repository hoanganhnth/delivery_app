import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cart_entity.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

/// Use case for getting current cart
class GetCartUseCase extends UseCase<CartEntity, NoParams> {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(NoParams params) async {
    return await repository.getCart();
  }
}

/// Use case for adding item to cart
class AddToCartUseCase extends UseCase<CartEntity, AddToCartParams> {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(AddToCartParams params) async {
    return await repository.addItem(params.item);
  }
}

class AddToCartParams {
  final CartItemEntity item;

  AddToCartParams({required this.item});
}

/// Use case for updating item quantity
class UpdateCartItemQuantityUseCase extends UseCase<CartEntity, UpdateCartItemQuantityParams> {
  final CartRepository repository;

  UpdateCartItemQuantityUseCase(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(UpdateCartItemQuantityParams params) async {
    return await repository.updateItemQuantity(params.menuItemId, params.quantity);
  }
}

class UpdateCartItemQuantityParams {
  final num menuItemId;
  final int quantity;

  UpdateCartItemQuantityParams({required this.menuItemId, required this.quantity});
}

/// Use case for removing item from cart
class RemoveFromCartUseCase extends UseCase<CartEntity, RemoveFromCartParams> {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(RemoveFromCartParams params) async {
    return await repository.removeItem(params.menuItemId);
  }
}

class RemoveFromCartParams {
  final num menuItemId;

  RemoveFromCartParams({required this.menuItemId});
}

/// Use case for clearing cart
class ClearCartUseCase extends UseCase<Unit, NoParams> {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.clearCart();
  }
}

/// Use case for updating item notes
class UpdateCartItemNotesUseCase extends UseCase<CartEntity, UpdateCartItemNotesParams> {
  final CartRepository repository;

  UpdateCartItemNotesUseCase(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(UpdateCartItemNotesParams params) async {
    return await repository.updateItemNotes(params.menuItemId, params.notes);
  }
}

class UpdateCartItemNotesParams {
  final num menuItemId;
  final String? notes;

  UpdateCartItemNotesParams({required this.menuItemId, required this.notes});
}

/// Use case for checking if can add from restaurant
class CanAddFromRestaurantUseCase extends UseCase<bool, CanAddFromRestaurantParams> {
  final CartRepository repository;

  CanAddFromRestaurantUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CanAddFromRestaurantParams params) async {
    return await repository.canAddFromRestaurant(params.restaurantId);
  }
}

class CanAddFromRestaurantParams {
  final num restaurantId;

  CanAddFromRestaurantParams({required this.restaurantId});
}
