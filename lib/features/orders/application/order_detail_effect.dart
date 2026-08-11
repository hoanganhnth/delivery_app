import 'package:equatable/equatable.dart';

sealed class OrderDetailEffect extends Equatable {
  const OrderDetailEffect();
}

final class OrderDetailNavigateBack extends OrderDetailEffect {
  const OrderDetailNavigateBack();

  @override
  List<Object?> get props => const [];
}

final class OrderDetailConfirmCancellation extends OrderDetailEffect {
  const OrderDetailConfirmCancellation();

  @override
  List<Object?> get props => const [];
}

final class OrderDetailNavigateToCart extends OrderDetailEffect {
  const OrderDetailNavigateToCart();

  @override
  List<Object?> get props => const [];
}

final class OrderDetailOpenRestaurantRating extends OrderDetailEffect {
  const OrderDetailOpenRestaurantRating({
    required this.orderId,
    required this.restaurantId,
    required this.restaurantName,
  });

  final int orderId;
  final int restaurantId;
  final String restaurantName;

  @override
  List<Object?> get props => [orderId, restaurantId, restaurantName];
}

final class OrderDetailShowMessage extends OrderDetailEffect {
  const OrderDetailShowMessage(this.message, {this.isSuccess = false});

  final String message;
  final bool isSuccess;

  @override
  List<Object?> get props => [message, isSuccess];
}
