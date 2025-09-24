import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/delivery_status.dart';

part 'current_delivery_dto.freezed.dart';
part 'current_delivery_dto.g.dart';

/// DTO cho response của current delivery API
@freezed
abstract class CurrentDeliveryDto with _$CurrentDeliveryDto {
  const factory CurrentDeliveryDto({
    required int orderId,
     int? shipperId,
    required String status,
    required double pickupLat,
    required double pickupLng,
    required double deliveryLat,
    required double deliveryLng,
    String? pickupAddress,
    String? deliveryAddress,
    String? estimatedTime,
    String? notes,
    String? createdAt,
    String? updatedAt,
  }) = _CurrentDeliveryDto;

  factory CurrentDeliveryDto.fromJson(Map<String, dynamic> json) => 
      _$CurrentDeliveryDtoFromJson(json);
}

/// Extension để convert DTO sang Entity
extension CurrentDeliveryDtoX on CurrentDeliveryDto {
  DeliveryTrackingEntity toEntity() {
    return DeliveryTrackingEntity(
      id: orderId * 1000, // Mock ID
      orderId: orderId,
      shipperId: shipperId,
      status: DeliveryStatus.fromValueOrDefault(status, DeliveryStatus.pending),
      pickupAddress: pickupAddress ?? 'Địa chỉ lấy hàng',
      pickupLat: pickupLat,
      pickupLng: pickupLng,
      deliveryAddress: deliveryAddress ?? 'Địa chỉ giao hàng',
      deliveryLat: deliveryLat,
      deliveryLng: deliveryLng,
      estimatedDeliveryTime: estimatedTime != null ? DateTime.tryParse(estimatedTime!) : null,
      notes: notes,
    );
  }
}
