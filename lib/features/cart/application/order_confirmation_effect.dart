import 'package:equatable/equatable.dart';

sealed class OrderConfirmationEffect extends Equatable {
  const OrderConfirmationEffect();
}

final class OrderConfirmationNavigateToOrders extends OrderConfirmationEffect {
  const OrderConfirmationNavigateToOrders();

  @override
  List<Object?> get props => const [];
}
