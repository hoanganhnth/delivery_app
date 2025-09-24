import '../models/location_model.dart';
import '../models/address_model.dart';
import '../../../../core/services/location_service.dart';

/// Interface cho location data source
abstract class LocationDataSource {
  Future<bool> requestLocationPermission();
  Future<LocationModel> getCurrentPosition();
  Future<AddressModel> getAddressFromCoordinates(
    double latitude,
    double longitude,
  );
  Future<LocationModel> getCoordinatesFromAddress(String address);
  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  );
  Future<bool> isLocationServiceEnabled();
  Future<void> openLocationSettings();
  Future<void> openAppSettings();
}

/// Implementation của LocationDataSource sử dụng geolocator và geocoding
class LocationDataSourceImpl implements LocationDataSource {
  final LocationService _locationService = LocationService.instance;

  @override
  Future<bool> requestLocationPermission() async {
    return await _locationService.requestLocationPermission();
  }

  @override
  Future<LocationModel> getCurrentPosition() async {
    final position = await _locationService.getCurrentPosition();
    if (position == null) {
      throw Exception('Could not get current position');
    }
    return LocationModel.fromPosition(position);
  }

  @override
  Future<AddressModel> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    final addressString = await _locationService.getAddressFromCoordinates(latitude, longitude);
    
    // Parse địa chỉ string thành AddressModel
    return AddressModel(
      street: addressString,
      locality: null,
      subLocality: null,
      administrativeArea: null,
      country: null,
      postalCode: null,
    );
  }

  @override
  Future<LocationModel> getCoordinatesFromAddress(String address) async {
    final position = await _locationService.getCoordinatesFromAddress(address);
    if (position == null) {
      throw Exception('No coordinates found for address');
    }
    return LocationModel.fromPosition(position);
  }

  @override
  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return _locationService.calculateDistance(startLat, startLng, endLat, endLng);
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return await _locationService.isLocationServiceEnabled();
  }

  @override
  Future<void> openLocationSettings() async {
    await _locationService.openLocationSettings();
  }

  @override
  Future<void> openAppSettings() async {
    await _locationService.openAppSettings();
  }
}
