import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../logger/app_logger.dart';

/// Singleton service để xử lý location và geocoding
class LocationService {
  static LocationService? _instance;

  LocationService._();

  static LocationService get instance {
    _instance ??= LocationService._();
    return _instance!;
  }

  /// Yêu cầu quyền truy cập location
  Future<bool> requestLocationPermission() async {
    try {
      AppLogger.d('Requesting location permission');

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        AppLogger.w('Location service is disabled');
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AppLogger.w('Location permission denied');
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        AppLogger.w('Location permission denied forever');
        return false;
      }

      AppLogger.i('Location permission granted');
      return true;
    } catch (e) {
      AppLogger.e('Error requesting location permission', e);
      return false;
    }
  }

  /// Lấy vị trí hiện tại
  Future<Position?> getCurrentPosition() async {
    try {
      AppLogger.d('Getting current position');

      bool hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        throw Exception('Location permission denied');
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );

      AppLogger.i(
        'Current position obtained: ${position.latitude}, ${position.longitude}',
      );
      return position;
    } catch (e) {
      AppLogger.e('Error getting current position', e);
      rethrow;
    }
  }

  /// Chuyển đổi tọa độ thành địa chỉ
  Future<String> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      AppLogger.d('Getting address from coordinates: $latitude, $longitude');

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

        AppLogger.i('Address obtained: $address');
        return address.isNotEmpty ? address : 'Không thể xác định địa chỉ';
      } else {
        AppLogger.w('No placemarks found for coordinates');
        return 'Không thể xác định địa chỉ';
      }
    } catch (e) {
      AppLogger.e('Error getting address from coordinates', e);
      return 'Không thể xác định địa chỉ';
    }
  }

  /// Chuyển đổi địa chỉ thành tọa độ
  Future<Position?> getCoordinatesFromAddress(String address) async {
    try {
      AppLogger.d('Getting coordinates from address: $address');

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

        AppLogger.i(
          'Coordinates obtained: ${position.latitude}, ${position.longitude}',
        );
        return position;
      } else {
        AppLogger.w('No coordinates found for address');
        return null;
      }
    } catch (e) {
      AppLogger.e('Error getting coordinates from address', e);
      return null;
    }
  }

  /// Tính khoảng cách giữa 2 điểm
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

  /// Kiểm tra location service có được bật không
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Mở settings để bật location service
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// Mở app settings để cấp quyền
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
