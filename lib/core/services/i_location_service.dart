import 'package:geolocator/geolocator.dart';

/// Interface for location service
abstract class ILocationService {
  /// Request location permission
  Future<bool> requestLocationPermission();

  /// Get current position
  Future<Position?> getCurrentPosition();

  /// Convert coordinates to address
  Future<String> getAddressFromCoordinates(double latitude, double longitude);

  /// Convert address to coordinates
  Future<Position?> getCoordinatesFromAddress(String address);

  /// Calculate distance between two points
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  );

  /// Check if location service is enabled
  Future<bool> isLocationServiceEnabled();

  /// Open location settings
  Future<void> openLocationSettings();

  /// Open app settings
  Future<void> openAppSettings();
}
