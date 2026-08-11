/// Domain command for creating or updating a saved delivery address.
///
/// Gateway serialization is performed by the data adapter, never by a domain
/// repository contract or use case.
final class AddressUpsertCommand {
  const AddressUpsertCommand({
    required this.label,
    required this.recipientName,
    required this.phoneNumber,
    required this.addressLine,
    required this.ward,
    required this.district,
    required this.city,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.isDefault,
  });

  final String label;
  final String recipientName;
  final String phoneNumber;
  final String addressLine;
  final String ward;
  final String district;
  final String city;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final bool? isDefault;
}
