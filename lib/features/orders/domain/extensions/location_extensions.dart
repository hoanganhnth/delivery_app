/// Extension on double for human-readable distance formatting.
/// Feature-layer helper — converts raw meters to user-friendly strings.
extension LocationDisplayX on double {
  /// Convert meters to human-readable distance string.
  /// e.g., 500.0 → "500 m", 1200.0 → "1.2 km"
  String toHumanDistance() {
    if (this < 1000) {
      return '${toInt()} m';
    } else {
      final km = this / 1000;
      return '${km.toStringAsFixed(1)} km';
    }
  }
}

/// Extension on (lat, lng) pairs for constructing map URLs.
extension LocationLinkX on ({double lat, double lng}) {
  /// Generate a Google Maps URL from coordinates
  String toGoogleMapsLink() {
    return 'https://www.google.com/maps?q=$lat,$lng';
  }

  /// Generate an Apple Maps URL from coordinates
  String toAppleMapsLink() {
    return 'https://maps.apple.com/?ll=$lat,$lng';
  }
}
