/// Checkout-safe address projection. It deliberately excludes the address
/// feature's notifier and persistence details.
abstract interface class AddressSelectionPort {
  DeliveryAddressSnapshot? get selected;
  Stream<DeliveryAddressSnapshot?> get changes;
}

final class DeliveryAddressSnapshot {
  const DeliveryAddressSnapshot({
    required this.id,
    required this.profileId,
    required this.label,
    required this.recipientName,
    required this.phoneNumber,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
  });

  final int id;
  final int profileId;
  final String label;
  final String recipientName;
  final String phoneNumber;
  final String fullAddress;
  final double latitude;
  final double longitude;
  final bool isDefault;

  bool get hasCoordinates => latitude.isFinite && longitude.isFinite;
}
