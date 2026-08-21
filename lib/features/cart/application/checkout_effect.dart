import 'package:equatable/equatable.dart';

sealed class CheckoutEffect extends Equatable {
  const CheckoutEffect();
}

final class CheckoutNavigateBack extends CheckoutEffect {
  const CheckoutNavigateBack();

  @override
  List<Object?> get props => const [];
}

final class CheckoutNavigateToAddresses extends CheckoutEffect {
  const CheckoutNavigateToAddresses();

  @override
  List<Object?> get props => const [];
}

final class CheckoutShowMessage extends CheckoutEffect {
  const CheckoutShowMessage(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class CheckoutShowUnavailableItems extends CheckoutEffect {
  const CheckoutShowUnavailableItems(this.itemIds);

  final List<int> itemIds;

  @override
  List<Object?> get props => [itemIds];
}

final class CheckoutPriceChanged extends CheckoutEffect {
  const CheckoutPriceChanged({required this.oldTotal, required this.newTotal});

  final double oldTotal;
  final double newTotal;

  @override
  List<Object?> get props => [oldTotal, newTotal];
}

final class CheckoutQuoteExpired extends CheckoutEffect {
  const CheckoutQuoteExpired();

  @override
  List<Object?> get props => const [];
}

final class CheckoutOrderPlaced extends CheckoutEffect {
  const CheckoutOrderPlaced({required this.isSuccess, this.message});

  final bool isSuccess;
  final String? message;

  @override
  List<Object?> get props => [isSuccess, message];
}
