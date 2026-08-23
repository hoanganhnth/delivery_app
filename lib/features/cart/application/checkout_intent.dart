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

final class CheckoutVoucherSelectionChanged extends CheckoutIntent {
  const CheckoutVoucherSelectionChanged(this.voucherIds);

  final List<int> voucherIds;
}

final class CheckoutVoucherModeChanged extends CheckoutIntent {
  const CheckoutVoucherModeChanged(this.mode);

  final String mode;
}

final class CheckoutVoucherCodeSubmitted extends CheckoutIntent {
  const CheckoutVoucherCodeSubmitted(this.code);

  final String code;
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
