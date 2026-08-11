import 'package:equatable/equatable.dart';

import 'orders_list_state.dart';

sealed class OrdersListEffect extends Equatable {
  const OrdersListEffect();
}

final class OrdersListNavigateBack extends OrdersListEffect {
  const OrdersListNavigateBack();

  @override
  List<Object?> get props => const [];
}

final class OrdersListNavigateToRefundHistory extends OrdersListEffect {
  const OrdersListNavigateToRefundHistory();

  @override
  List<Object?> get props => const [];
}

final class OrdersListNavigateToDetails extends OrdersListEffect {
  const OrdersListNavigateToDetails(this.orderId);

  final int orderId;

  @override
  List<Object?> get props => [orderId];
}

final class OrdersListNavigateToCart extends OrdersListEffect {
  const OrdersListNavigateToCart();

  @override
  List<Object?> get props => const [];
}

final class OrdersListConfirmCancel extends OrdersListEffect {
  const OrdersListConfirmCancel(this.order);

  final OrdersListItemViewData order;

  @override
  List<Object?> get props => [order];
}

final class OrdersListShowMessage extends OrdersListEffect {
  const OrdersListShowMessage(this.message, {this.isSuccess = false});

  final String message;
  final bool isSuccess;

  @override
  List<Object?> get props => [message, isSuccess];
}
