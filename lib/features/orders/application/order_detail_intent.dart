sealed class OrderDetailIntent {
  const OrderDetailIntent();
}

final class OrderDetailBackRequested extends OrderDetailIntent {
  const OrderDetailBackRequested();
}

final class OrderDetailRefreshRequested extends OrderDetailIntent {
  const OrderDetailRefreshRequested();
}

final class OrderDetailRetryRequested extends OrderDetailIntent {
  const OrderDetailRetryRequested();
}

final class OrderDetailRefundRetryRequested extends OrderDetailIntent {
  const OrderDetailRefundRetryRequested();
}

final class OrderDetailCancelRequested extends OrderDetailIntent {
  const OrderDetailCancelRequested();
}

final class OrderDetailCancelConfirmed extends OrderDetailIntent {
  const OrderDetailCancelConfirmed(this.reason);

  final String reason;
}

final class OrderDetailReorderRequested extends OrderDetailIntent {
  const OrderDetailReorderRequested();
}

final class OrderDetailRatingRequested extends OrderDetailIntent {
  const OrderDetailRatingRequested();
}

final class OrderDetailRatingSubmitted extends OrderDetailIntent {
  const OrderDetailRatingSubmitted({
    required this.rating,
    required this.comment,
  });

  final int rating;
  final String comment;
}

final class OrderDetailEffectConsumed extends OrderDetailIntent {
  const OrderDetailEffectConsumed(this.effectId);

  final int effectId;
}
