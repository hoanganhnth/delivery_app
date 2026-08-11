sealed class RefundHistoryIntent {
  const RefundHistoryIntent();
}

final class RefundHistoryBackRequested extends RefundHistoryIntent {
  const RefundHistoryBackRequested();
}

final class RefundHistoryRefreshRequested extends RefundHistoryIntent {
  const RefundHistoryRefreshRequested();
}

final class RefundHistoryRetryRequested extends RefundHistoryIntent {
  const RefundHistoryRetryRequested();
}

final class RefundHistoryOrderRequested extends RefundHistoryIntent {
  const RefundHistoryOrderRequested(this.orderId);

  final int orderId;
}

final class RefundHistoryEffectConsumed extends RefundHistoryIntent {
  const RefundHistoryEffectConsumed(this.effectId);

  final int effectId;
}
