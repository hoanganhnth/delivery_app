import 'package:geocoding/geocoding.dart';
import '../../domain/entities/location_entity.dart';

/// Model cho AddressEntity
class AddressModel extends AddressEntity {
  const AddressModel({
    super.name,
    super.street,
    super.subLocality,
    super.locality,
    super.subAdministrativeArea,
    super.administrativeArea,
    super.postalCode,
    super.country,
    super.isoCountryCode,
  });

  /// Tạo AddressModel từ Geocoding Placemark
  factory AddressModel.fromPlacemark(Placemark placemark) {
    return AddressModel(
      name: placemark.name,
      street: placemark.street,
      subLocality: placemark.subLocality,
      locality: placemark.locality,
      subAdministrativeArea: placemark.subAdministrativeArea,
      administrativeArea: placemark.administrativeArea,
      postalCode: placemark.postalCode,
      country: placemark.country,
      isoCountryCode: placemark.isoCountryCode,
    );
  }

  /// Tạo AddressModel từ AddressEntity
  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      name: entity.name,
      street: entity.street,
      subLocality: entity.subLocality,
      locality: entity.locality,
      subAdministrativeArea: entity.subAdministrativeArea,
      administrativeArea: entity.administrativeArea,
      postalCode: entity.postalCode,
      country: entity.country,
      isoCountryCode: entity.isoCountryCode,
    );
  }

  /// Convert AddressModel thành AddressEntity
  AddressEntity toEntity() {
    return AddressEntity(
      name: name,
      street: street,
      subLocality: subLocality,
      locality: locality,
      subAdministrativeArea: subAdministrativeArea,
      administrativeArea: administrativeArea,
      postalCode: postalCode,
      country: country,
      isoCountryCode: isoCountryCode,
    );
  }

  /// Convert thành JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'street': street,
      'subLocality': subLocality,
      'locality': locality,
      'subAdministrativeArea': subAdministrativeArea,
      'administrativeArea': administrativeArea,
      'postalCode': postalCode,
      'country': country,
      'isoCountryCode': isoCountryCode,
    };
  }

  /// Tạo AddressModel từ JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'] as String?,
      street: json['street'] as String?,
      subLocality: json['subLocality'] as String?,
      locality: json['locality'] as String?,
      subAdministrativeArea: json['subAdministrativeArea'] as String?,
      administrativeArea: json['administrativeArea'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      isoCountryCode: json['isoCountryCode'] as String?,
    );
  }

  /// Tạo địa chỉ theo format Việt Nam (số nhà, đường, phường, quận, thành phố)
  String get vietnameseAddress {
    final parts = <String>[];
    
    if (name?.isNotEmpty == true) parts.add(name!);
    if (street?.isNotEmpty == true) parts.add(street!);
    if (subLocality?.isNotEmpty == true) parts.add('P. ${subLocality!}'); // Phường
    if (locality?.isNotEmpty == true) parts.add('Q. ${locality!}'); // Quận
    if (administrativeArea?.isNotEmpty == true) parts.add(administrativeArea!); // Thành phố
    
    return parts.join(', ');
  }

  @override
  String toString() {
    return 'AddressModel(fullAddress: $fullAddress)';
  }
}
