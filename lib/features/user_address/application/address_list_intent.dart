sealed class AddressListIntent {
  const AddressListIntent();
}

final class AddressListLoadRequested extends AddressListIntent {
  const AddressListLoadRequested();
}

final class AddressListRefreshRequested extends AddressListIntent {
  const AddressListRefreshRequested();
}

final class AddressListSelectRequested extends AddressListIntent {
  const AddressListSelectRequested(this.addressId);
  final int addressId;
}

final class AddressListSetDefaultRequested extends AddressListIntent {
  const AddressListSetDefaultRequested(this.addressId);
  final int addressId;
}

final class AddressListDeleteRequested extends AddressListIntent {
  const AddressListDeleteRequested(this.addressId);
  final int addressId;
}

/// Sent only after the page adapter has obtained user confirmation.
final class AddressListDeleteConfirmed extends AddressListIntent {
  const AddressListDeleteConfirmed(this.addressId);
  final int addressId;
}

final class AddressListAddRequested extends AddressListIntent {
  const AddressListAddRequested();
}

final class AddressListEditRequested extends AddressListIntent {
  const AddressListEditRequested(this.addressId);
  final int addressId;
}

final class AddressListEffectConsumed extends AddressListIntent {
  const AddressListEffectConsumed(this.effectId);
  final int effectId;
}
