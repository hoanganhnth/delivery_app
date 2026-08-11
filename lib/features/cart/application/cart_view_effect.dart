import 'package:equatable/equatable.dart';

sealed class CartViewEffect extends Equatable {
  const CartViewEffect();
}

final class CartNavigateBack extends CartViewEffect {
  const CartNavigateBack();
  @override
  List<Object?> get props => const [];
}

final class CartNavigateRestaurants extends CartViewEffect {
  const CartNavigateRestaurants();
  @override
  List<Object?> get props => const [];
}

final class CartNavigateCheckout extends CartViewEffect {
  const CartNavigateCheckout();
  @override
  List<Object?> get props => const [];
}

final class CartConfirmClear extends CartViewEffect {
  const CartConfirmClear();
  @override
  List<Object?> get props => const [];
}

final class CartShowMessage extends CartViewEffect {
  const CartShowMessage(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
