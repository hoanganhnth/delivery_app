/// Entity đại diện cho vị trí địa lý
class LocationEntity {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final DateTime timestamp;

  const LocationEntity({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    required this.timestamp,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationEntity &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.accuracy == accuracy &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return Object.hash(latitude, longitude, accuracy, timestamp);
  }

  @override
  String toString() {
    return 'LocationEntity(lat: $latitude, lng: $longitude, accuracy: $accuracy, timestamp: $timestamp)';
  }
}

/// Entity đại diện cho địa chỉ từ geocoding
class AddressEntity {
  final String? name;
  final String? street;
  final String? subLocality;
  final String? locality;
  final String? subAdministrativeArea;
  final String? administrativeArea;
  final String? postalCode;
  final String? country;
  final String? isoCountryCode;

  const AddressEntity({
    this.name,
    this.street,
    this.subLocality,
    this.locality,
    this.subAdministrativeArea,
    this.administrativeArea,
    this.postalCode,
    this.country,
    this.isoCountryCode,
  });

  /// Lấy địa chỉ đầy đủ
  String get fullAddress {
    final parts = <String>[];
    
    if (name?.isNotEmpty == true) parts.add(name!);
    if (street?.isNotEmpty == true) parts.add(street!);
    if (subLocality?.isNotEmpty == true) parts.add(subLocality!);
    if (locality?.isNotEmpty == true) parts.add(locality!);
    if (subAdministrativeArea?.isNotEmpty == true) parts.add(subAdministrativeArea!);
    if (administrativeArea?.isNotEmpty == true) parts.add(administrativeArea!);
    if (postalCode?.isNotEmpty == true) parts.add(postalCode!);
    if (country?.isNotEmpty == true) parts.add(country!);
    
    return parts.join(', ');
  }

  /// Lấy địa chỉ ngắn (đường, phường, quận)
  String get shortAddress {
    final parts = <String>[];
    
    if (street?.isNotEmpty == true) parts.add(street!);
    if (subLocality?.isNotEmpty == true) parts.add(subLocality!);
    if (locality?.isNotEmpty == true) parts.add(locality!);
    
    return parts.join(', ');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddressEntity &&
        other.name == name &&
        other.street == street &&
        other.subLocality == subLocality &&
        other.locality == locality &&
        other.subAdministrativeArea == subAdministrativeArea &&
        other.administrativeArea == administrativeArea &&
        other.postalCode == postalCode &&
        other.country == country &&
        other.isoCountryCode == isoCountryCode;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      street,
      subLocality,
      locality,
      subAdministrativeArea,
      administrativeArea,
      postalCode,
      country,
      isoCountryCode,
    );
  }

  @override
  String toString() {
    return 'AddressEntity(fullAddress: $fullAddress)';
  }
}
