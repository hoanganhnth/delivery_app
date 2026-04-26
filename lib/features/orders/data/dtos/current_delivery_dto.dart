import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/delivery_status.dart';

/// DTO cho response của current delivery API
/// Đã chuyển từ @freezed sang standard class để handle null an toàn và bypass lỗi build_runner
class CurrentDeliveryDto {
  final int? orderId;
  final int? shipperId;
  final String? status;
  final double? pickupLat;
  final double? pickupLng;
  final double? deliveryLat;
  final double? deliveryLng;
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
    this.orderId,
    this.shipperId,
    this.status,
    this.pickupLat,
    this.pickupLng,
    this.deliveryLat,
    this.deliveryLng,
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
      orderId: (json['orderId'] as num?)?.toInt(),
      shipperId: (json['shipperId'] as num?)?.toInt(),
      status: json['status'] as String?,
      pickupLat: (json['pickupLat'] as num?)?.toDouble(),
      pickupLng: (json['pickupLng'] as num?)?.toDouble(),
      deliveryLat: (json['deliveryLat'] as num?)?.toDouble(),
      deliveryLng: (json['deliveryLng'] as num?)?.toDouble(),
      pickupAddress: json['pickupAddress'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      estimatedTime: json['estimatedTime'] as String?,
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
      'orderId': orderId,
      'shipperId': shipperId,
      'status': status,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'deliveryLat': deliveryLat,
      'deliveryLng': deliveryLng,
      'pickupAddress': pickupAddress,
      'deliveryAddress': deliveryAddress,
      'estimatedTime': estimatedTime,
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
    return DeliveryTrackingEntity(
      id: (orderId ?? 0) * 1000, // Mock ID
      orderId: orderId ?? 0,
      shipperId: shipperId,
      status: DeliveryStatus.fromValueOrDefault(status ?? '', DeliveryStatus.pending),
      pickupAddress: pickupAddress ?? 'Địa chỉ lấy hàng',
      pickupLat: pickupLat ?? 0.0,
      pickupLng: pickupLng ?? 0.0,
      deliveryAddress: deliveryAddress ?? 'Địa chỉ giao hàng',
      deliveryLat: deliveryLat ?? 0.0,
      deliveryLng: deliveryLng ?? 0.0,
      estimatedDeliveryTime: estimatedTime != null ? DateTime.tryParse(estimatedTime!) : null,
      notes: notes,
    );
  }
}
