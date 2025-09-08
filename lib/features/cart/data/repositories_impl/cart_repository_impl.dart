import 'package:fpdart/fpdart.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';
import '../dtos/cart_dto.dart';
import '../dtos/cart_item_dto.dart';

/// Implementation of CartRepository
class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      final result = await localDataSource.getCart();

      return result.fold(
        (exception) => left(mapExceptionToFailure(exception)),
        (cartDto) => right(cartDto.toEntity()),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> addItem(CartItemEntity item) async {
    try {
      final cartItemDto = CartItemDto(
        menuItemId: item.menuItemId,
        menuItemName: item.menuItemName,
        price: item.price,
        quantity: item.quantity,
        restaurantId: item.restaurantId,
        restaurantName: item.restaurantName,
        imageUrl: item.imageUrl,
        notes: item.notes,
      );

      final result = await localDataSource.addItem(cartItemDto);

      return result.fold(
        (exception) => left(mapExceptionToFailure(exception)),
        (cartDto) => right(cartDto.toEntity()),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updateItemQuantity(num menuItemId, int quantity) async {
    try {
      final result = await localDataSource.updateItemQuantity(menuItemId, quantity);

      return result.fold(
        (exception) => left(mapExceptionToFailure(exception)),
        (cartDto) => right(cartDto.toEntity()),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> removeItem(num menuItemId) async {
    try {
      final result = await localDataSource.removeItem(menuItemId);

      return result.fold(
        (exception) => left(mapExceptionToFailure(exception)),
        (cartDto) => right(cartDto.toEntity()),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearCart() async {
    try {
      final result = await localDataSource.clearCart();

      return result.fold(
        (exception) => left(mapExceptionToFailure(exception)),
        (_) => right(unit),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updateItemNotes(num menuItemId, String? notes) async {
    try {
      final result = await localDataSource.updateItemNotes(menuItemId, notes);

      return result.fold(
        (exception) => left(mapExceptionToFailure(exception)),
        (cartDto) => right(cartDto.toEntity()),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> canAddFromRestaurant(num restaurantId) async {
    try {
      final cartResult = await getCart();

      return cartResult.fold(
        (failure) => left(failure),
        (cart) => right(cart.canAddFromRestaurant(restaurantId)),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}

/// Extension to convert DTO to Entity
extension CartDtoExtension on CartDto {
  CartEntity toEntity() {
    return CartEntity(
      items: items.map((item) => item.toEntity()).toList(),
      currentRestaurantId: currentRestaurantId,
      currentRestaurantName: currentRestaurantName,
    );
  }
}

extension CartItemDtoExtension on CartItemDto {
  CartItemEntity toEntity() {
    return CartItemEntity(
      menuItemId: menuItemId,
      menuItemName: menuItemName,
      price: price,
      quantity: quantity,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      imageUrl: imageUrl,
      notes: notes,
    );
  }
}
