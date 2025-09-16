import 'delivery_status.dart';

/// Entity cho thông tin delivery tracking
class DeliveryTrackingEntity {
  final int id;
  final int orderId;
  final int shipperId;
  final DeliveryStatus status;
  final String pickupAddress;
  final double pickupLat;
  final double pickupLng;
  final String deliveryAddress;
  final double deliveryLat;
  final double deliveryLng;
  final double? shipperCurrentLat;
  final double? shipperCurrentLng;
  final DateTime? assignedAt;
  final DateTime? pickedUpAt;
  final DateTime? deliveredAt;
  final DateTime? estimatedDeliveryTime;
  final String? notes;

  const DeliveryTrackingEntity({
    required this.id,
    required this.orderId,
    required this.shipperId,
    required this.status,
    required this.pickupAddress,
    required this.pickupLat,
    required this.pickupLng,
    required this.deliveryAddress,
    required this.deliveryLat,
    required this.deliveryLng,
    this.shipperCurrentLat,
    this.shipperCurrentLng,
    this.assignedAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.estimatedDeliveryTime,
    this.notes,
  });

  DeliveryTrackingEntity copyWith({
    int? id,
    int? orderId,
    int? shipperId,
    DeliveryStatus? status,
    String? pickupAddress,
    double? pickupLat,
    double? pickupLng,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    double? shipperCurrentLat,
    double? shipperCurrentLng,
    DateTime? assignedAt,
    DateTime? pickedUpAt,
    DateTime? deliveredAt,
    DateTime? estimatedDeliveryTime,
    String? notes,
  }) {
    return DeliveryTrackingEntity(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      shipperId: shipperId ?? this.shipperId,
      status: status ?? this.status,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      pickupLat: pickupLat ?? this.pickupLat,
      pickupLng: pickupLng ?? this.pickupLng,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLat: deliveryLat ?? this.deliveryLat,
      deliveryLng: deliveryLng ?? this.deliveryLng,
      shipperCurrentLat: shipperCurrentLat ?? this.shipperCurrentLat,
      shipperCurrentLng: shipperCurrentLng ?? this.shipperCurrentLng,
      assignedAt: assignedAt ?? this.assignedAt,
      pickedUpAt: pickedUpAt ?? this.pickedUpAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      notes: notes ?? this.notes,
    );
  }
}

