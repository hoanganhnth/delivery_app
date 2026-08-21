sealed class CheckoutIntent {
  const CheckoutIntent();
}

final class CheckoutLoadRequested extends CheckoutIntent {
  const CheckoutLoadRequested();
}

final class CheckoutPreviewRetryRequested extends CheckoutIntent {
  const CheckoutPreviewRetryRequested();
}

final class CheckoutAddressSelectionRequested extends CheckoutIntent {
  const CheckoutAddressSelectionRequested();
}

final class CheckoutVoucherChanged extends CheckoutIntent {
  const CheckoutVoucherChanged(this.voucherId);

  final int? voucherId;
}

final class CheckoutVoucherRetryRequested extends CheckoutIntent {
  const CheckoutVoucherRetryRequested();
}

final class CheckoutNotesChanged extends CheckoutIntent {
  const CheckoutNotesChanged(this.notes);

  final String notes;
}

final class CheckoutPlaceOrderRequested extends CheckoutIntent {
  const CheckoutPlaceOrderRequested();
}

final class CheckoutPriceChangeAccepted extends CheckoutIntent {
  const CheckoutPriceChangeAccepted();
}

final class CheckoutBackRequested extends CheckoutIntent {
  const CheckoutBackRequested();
}

final class CheckoutEffectConsumed extends CheckoutIntent {
  const CheckoutEffectConsumed(this.effectId);

  final int effectId;
}
