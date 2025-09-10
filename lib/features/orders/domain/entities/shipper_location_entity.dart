/// Entity cho vị trí shipper real-time
class ShipperLocationEntity {
  final int shipperId;
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? speed;
  final double? heading;
  final bool isOnline;
  final DateTime? lastPing;
  final DateTime updatedAt;

  const ShipperLocationEntity({
    required this.shipperId,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.speed,
    this.heading,
    this.isOnline = true,
    this.lastPing,
    required this.updatedAt,
  });

  ShipperLocationEntity copyWith({
    int? shipperId,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? speed,
    double? heading,
    bool? isOnline,
    DateTime? lastPing,
    DateTime? updatedAt,
  }) {
    return ShipperLocationEntity(
      shipperId: shipperId ?? this.shipperId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      speed: speed ?? this.speed,
      heading: heading ?? this.heading,
      isOnline: isOnline ?? this.isOnline,
      lastPing: lastPing ?? this.lastPing,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShipperLocationEntity &&
        other.shipperId == shipperId &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.accuracy == accuracy &&
        other.speed == speed &&
        other.heading == heading &&
        other.isOnline == isOnline &&
        other.lastPing == lastPing &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return shipperId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        accuracy.hashCode ^
        speed.hashCode ^
        heading.hashCode ^
        isOnline.hashCode ^
        lastPing.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'ShipperLocationEntity(shipperId: $shipperId, lat: $latitude, lng: $longitude, isOnline: $isOnline, updatedAt: $updatedAt)';
  }
}
