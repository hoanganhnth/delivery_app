sealed class OrdersListIntent {
  const OrdersListIntent();
}

enum OrdersListFilter { all, active, completed, history }

final class OrdersListRefreshRequested extends OrdersListIntent {
  const OrdersListRefreshRequested();
}

final class OrdersListRetryRequested extends OrdersListIntent {
  const OrdersListRetryRequested();
}

final class OrdersListLoadMoreRequested extends OrdersListIntent {
  const OrdersListLoadMoreRequested();
}

final class OrdersListFilterChanged extends OrdersListIntent {
  const OrdersListFilterChanged(this.filter);

  final OrdersListFilter filter;
}

final class OrdersListBackRequested extends OrdersListIntent {
  const OrdersListBackRequested();
}

final class OrdersListRefundHistoryRequested extends OrdersListIntent {
  const OrdersListRefundHistoryRequested();
}

final class OrdersListDetailsRequested extends OrdersListIntent {
  const OrdersListDetailsRequested(this.orderId);

  final int orderId;
}

final class OrdersListCancelRequested extends OrdersListIntent {
  const OrdersListCancelRequested(this.orderId);

  final int orderId;
}

final class OrdersListCancelConfirmed extends OrdersListIntent {
  const OrdersListCancelConfirmed(this.orderId);

  final int orderId;
}

final class OrdersListReorderRequested extends OrdersListIntent {
  const OrdersListReorderRequested(this.orderId);

  final int orderId;
}

final class OrdersListEffectConsumed extends OrdersListIntent {
  const OrdersListEffectConsumed(this.effectId);

  final int effectId;
}
