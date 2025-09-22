import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/location_model.dart';
import '../models/address_model.dart';

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
  @override
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Kiểm tra location service có được bật không
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location service is disabled');
    }

    // Kiểm tra quyền
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied forever');
    }

    return true;
  }

  @override
  Future<LocationModel> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    return LocationModel.fromPosition(position);
  }

  @override
  Future<AddressModel> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isEmpty) {
      throw Exception('No address found for coordinates');
    }

    final placemark = placemarks.first;
    return AddressModel.fromPlacemark(placemark);
  }

  @override
  Future<LocationModel> getCoordinatesFromAddress(String address) async {
    final locations = await locationFromAddress(address);

    if (locations.isEmpty) {
      throw Exception('No coordinates found for address');
    }

    final location = locations.first;
    return LocationModel(
      latitude: location.latitude,
      longitude: location.longitude,
      accuracy: null,
      timestamp: DateTime.now(),
    );
  }

  @override
  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  @override
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
