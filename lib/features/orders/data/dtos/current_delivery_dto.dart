import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/delivery_status.dart';

/// DTO cho response của current delivery API
/// Đã chuyển từ @freezed sang standard class để handle null an toàn và bypass lỗi build_runner
class CurrentDeliveryDto {
  final int? id;
  final int? orderId;
  final int? shipperId;
  final String? status;
  final double? pickupLat;
  final double? pickupLng;
  final double? deliveryLat;
  final double? deliveryLng;
  final double? shipperCurrentLat;
  final double? shipperCurrentLng;
  final String? pickupAddress;
  final String? deliveryAddress;
  final String? estimatedTime;
  final String? assignedAt;
  final String? pickedUpAt;
  final String? deliveredAt;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;

  const CurrentDeliveryDto({
    this.id,
    this.orderId,
    this.shipperId,
    this.status,
    this.pickupLat,
    this.pickupLng,
    this.deliveryLat,
    this.deliveryLng,
    this.shipperCurrentLat,
    this.shipperCurrentLng,
    this.pickupAddress,
    this.deliveryAddress,
    this.estimatedTime,
    this.assignedAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory CurrentDeliveryDto.fromJson(Map<String, dynamic> json) {
    return CurrentDeliveryDto(
      id: (json['id'] as num?)?.toInt(),
      orderId: (json['orderId'] as num?)?.toInt(),
      shipperId: (json['shipperId'] as num?)?.toInt(),
      status: json['status'] as String?,
      pickupLat: (json['pickupLat'] as num?)?.toDouble(),
      pickupLng: (json['pickupLng'] as num?)?.toDouble(),
      deliveryLat: (json['deliveryLat'] as num?)?.toDouble(),
      deliveryLng: (json['deliveryLng'] as num?)?.toDouble(),
      shipperCurrentLat: (json['shipperCurrentLat'] as num?)?.toDouble(),
      shipperCurrentLng: (json['shipperCurrentLng'] as num?)?.toDouble(),
      pickupAddress: json['pickupAddress'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      estimatedTime: json['estimatedDeliveryTime'] as String?,
      assignedAt: json['assignedAt'] as String?,
      pickedUpAt: json['pickedUpAt'] as String?,
      deliveredAt: json['deliveredAt'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'shipperId': shipperId,
      'status': status,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'deliveryLat': deliveryLat,
      'deliveryLng': deliveryLng,
      'shipperCurrentLat': shipperCurrentLat,
      'shipperCurrentLng': shipperCurrentLng,
      'pickupAddress': pickupAddress,
      'deliveryAddress': deliveryAddress,
      'estimatedDeliveryTime': estimatedTime,
      'assignedAt': assignedAt,
      'pickedUpAt': pickedUpAt,
      'deliveredAt': deliveredAt,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

/// Extension để convert DTO sang Entity
extension CurrentDeliveryDtoX on CurrentDeliveryDto {
  DeliveryTrackingEntity toEntity() {
    final deliveryId = id;
    final currentOrderId = orderId;
    final deliveryStatus = DeliveryStatus.fromValue(status);
    final currentPickupAddress = pickupAddress?.trim();
    final currentDeliveryAddress = deliveryAddress?.trim();

    if (deliveryId == null || deliveryId <= 0) {
      throw const FormatException('Delivery id must be positive');
    }
    if (currentOrderId == null || currentOrderId <= 0) {
      throw const FormatException('Order id must be positive');
    }
    if (shipperId != null && shipperId! <= 0) {
      throw const FormatException('Shipper id must be positive when present');
    }
    if (deliveryStatus == null) {
      throw const FormatException('Unknown delivery status');
    }
    if (currentPickupAddress == null || currentPickupAddress.isEmpty) {
      throw const FormatException('Pickup address is required');
    }
    if (currentDeliveryAddress == null || currentDeliveryAddress.isEmpty) {
      throw const FormatException('Delivery address is required');
    }
    if (!_isVietnamCoordinate(pickupLat, pickupLng)) {
      throw const FormatException('Pickup coordinates are invalid');
    }
    if (!_isVietnamCoordinate(deliveryLat, deliveryLng)) {
      throw const FormatException('Delivery coordinates are invalid');
    }
    if (shipperCurrentLat != null || shipperCurrentLng != null) {
      if (!_isVietnamCoordinate(shipperCurrentLat, shipperCurrentLng)) {
        throw const FormatException('Shipper coordinates are invalid');
      }
    }

    return DeliveryTrackingEntity(
      id: deliveryId,
      orderId: currentOrderId,
      shipperId: shipperId,
      status: deliveryStatus,
      pickupAddress: currentPickupAddress,
      pickupLat: pickupLat!,
      pickupLng: pickupLng!,
      deliveryAddress: currentDeliveryAddress,
      deliveryLat: deliveryLat!,
      deliveryLng: deliveryLng!,
      shipperCurrentLat: shipperCurrentLat,
      shipperCurrentLng: shipperCurrentLng,
      assignedAt: _parseOptionalDate(assignedAt, 'assignedAt'),
      pickedUpAt: _parseOptionalDate(pickedUpAt, 'pickedUpAt'),
      deliveredAt: _parseOptionalDate(deliveredAt, 'deliveredAt'),
      estimatedDeliveryTime: estimatedTime != null
          ? _parseRequiredDate(estimatedTime!, 'estimatedDeliveryTime')
          : null,
      notes: notes,
    );
  }

  static bool _isVietnamCoordinate(double? latitude, double? longitude) {
    return latitude != null &&
        longitude != null &&
        latitude.isFinite &&
        longitude.isFinite &&
        latitude >= 8.0 &&
        latitude <= 24.0 &&
        longitude >= 102.0 &&
        longitude <= 110.0;
  }

  static DateTime? _parseOptionalDate(String? value, String field) {
    if (value == null) return null;
    return _parseRequiredDate(value, field);
  }

  static DateTime _parseRequiredDate(String value, String field) {
    final parsed = DateTime.tryParse(value);
    if (parsed == null) {
      throw FormatException('$field must be an ISO-8601 timestamp');
    }
    return parsed;
  }
}
