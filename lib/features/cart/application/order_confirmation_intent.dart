sealed class OrderConfirmationIntent {
  const OrderConfirmationIntent();
}

final class OrderConfirmationTrackingRequested extends OrderConfirmationIntent {
  const OrderConfirmationTrackingRequested();
}

final class OrderConfirmationEffectConsumed extends OrderConfirmationIntent {
  const OrderConfirmationEffectConsumed(this.effectId);

  final int effectId;
}
