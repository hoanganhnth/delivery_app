import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../logger/app_logger.dart';
import 'i_location_service.dart';

/// Implementation of ILocationService using Geolocator and Geocoding packages
class LocationService implements ILocationService {
  LocationService();

  @override
  Future<bool> requestLocationPermission() async {
    try {
      AppLogger.debug('Requesting location permission');

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        AppLogger.warn('Location service is disabled');
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AppLogger.warn('Location permission denied');
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        AppLogger.warn('Location permission denied forever');
        return false;
      }

      AppLogger.info('Location permission granted');
      return true;
    } catch (e) {
      AppLogger.error('Error requesting location permission', e);
      return false;
    }
  }

  @override
  Future<Position?> getCurrentPosition() async {
    try {
      AppLogger.debug('Getting current position');

      bool hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        throw Exception('Location permission denied');
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );

      AppLogger.info(
        'Current position obtained: ${position.latitude}, ${position.longitude}',
      );
      return position;
    } catch (e) {
      AppLogger.error('Error getting current position', e);
      rethrow;
    }
  }

  @override
  Future<String> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      AppLogger.debug('Getting address from coordinates: $latitude, $longitude');

      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = '';

        if (place.street != null && place.street!.isNotEmpty) {
          address += place.street!;
        }
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          if (address.isNotEmpty) address += ', ';
          address += place.subLocality!;
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          if (address.isNotEmpty) address += ', ';
          address += place.locality!;
        }
        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty) {
          if (address.isNotEmpty) address += ', ';
          address += place.administrativeArea!;
        }
        if (place.country != null && place.country!.isNotEmpty) {
          if (address.isNotEmpty) address += ', ';
          address += place.country!;
        }

        AppLogger.info('Address obtained: $address');
        return address.isNotEmpty ? address : 'Không thể xác định địa chỉ';
      } else {
        AppLogger.warn('No placemarks found for coordinates');
        return 'Không thể xác định địa chỉ';
      }
    } catch (e) {
      AppLogger.error('Error getting address from coordinates', e);
      return 'Không thể xác định địa chỉ';
    }
  }

  @override
  Future<Position?> getCoordinatesFromAddress(String address) async {
    try {
      AppLogger.debug('Getting coordinates from address: $address');

      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        Position position = Position(
          longitude: location.longitude,
          latitude: location.latitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );

        AppLogger.info(
          'Coordinates obtained: ${position.latitude}, ${position.longitude}',
        );
        return position;
      } else {
        AppLogger.warn('No coordinates found for address');
        return null;
      }
    } catch (e) {
      AppLogger.error('Error getting coordinates from address', e);
      return null;
    }
  }

  @override
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
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
