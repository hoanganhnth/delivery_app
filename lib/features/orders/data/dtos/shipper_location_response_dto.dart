import '../../domain/entities/shipper_location_entity.dart';

/// DTO cho response vị trí shipper real-time
class ShipperLocationResponseDto {
  final int shipperId;
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? speed;
  final double? heading;
  final bool isOnline;
  final String? lastPing;
  final String? updatedAt;

  const ShipperLocationResponseDto({
    required this.shipperId,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.speed,
    this.heading,
    this.isOnline = true,
    this.lastPing,
    this.updatedAt,
  });

  factory ShipperLocationResponseDto.fromJson(Map<String, dynamic> json) {
    return ShipperLocationResponseDto(
      shipperId: json['shipperId'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: json['accuracy'] != null ? (json['accuracy'] as num).toDouble() : null,
      speed: json['speed'] != null ? (json['speed'] as num).toDouble() : null,
      heading: json['heading'] != null ? (json['heading'] as num).toDouble() : null,
      isOnline: json['isOnline'] as bool? ?? true,
      lastPing: json['lastPing'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipperId': shipperId,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'speed': speed,
      'heading': heading,
      'isOnline': isOnline,
      'lastPing': lastPing,
      'updatedAt': updatedAt,
    };
  }

  /// Convert sang Entity
  ShipperLocationEntity toEntity() {
    return ShipperLocationEntity(
      shipperId: shipperId,
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      speed: speed,
      heading: heading,
      isOnline: isOnline,
      lastPing: lastPing != null ? DateTime.tryParse(lastPing!) : null,
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) ?? DateTime.now() : DateTime.now(),
    );
  }
}
