sealed class AddressFormIntent {
  const AddressFormIntent();
}

enum AddressFormField {
  label,
  recipientName,
  phoneNumber,
  addressLine,
  ward,
  district,
  city,
  postalCode,
}

final class AddressFormInitializeRequested extends AddressFormIntent {
  const AddressFormInitializeRequested();
}

final class AddressFormFieldChanged extends AddressFormIntent {
  const AddressFormFieldChanged(this.field, this.value);

  final AddressFormField field;
  final String value;
}

final class AddressFormDefaultChanged extends AddressFormIntent {
  const AddressFormDefaultChanged(this.isDefault);

  final bool isDefault;
}

final class AddressFormLocationRequested extends AddressFormIntent {
  const AddressFormLocationRequested();
}

final class AddressFormSubmitRequested extends AddressFormIntent {
  const AddressFormSubmitRequested();
}

final class AddressFormDeleteRequested extends AddressFormIntent {
  const AddressFormDeleteRequested();
}

final class AddressFormDeleteConfirmed extends AddressFormIntent {
  const AddressFormDeleteConfirmed();
}

final class AddressFormBackRequested extends AddressFormIntent {
  const AddressFormBackRequested();
}

final class AddressFormEffectConsumed extends AddressFormIntent {
  const AddressFormEffectConsumed(this.effectId);

  final int effectId;
}
