import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/shipper_entity.dart';

part 'shipper_dto.freezed.dart';
part 'shipper_dto.g.dart';

/// DTO cho thông tin shipper từ API
@freezed
abstract class ShipperDto with _$ShipperDto {
  const factory ShipperDto({
    required int id,
    required String name,
    required String phone,
    @JsonKey(name: 'vehicle_type') required String vehicleType,
    @JsonKey(name: 'vehicle_number') required String vehicleNumber,
    String? avatar,
    double? rating,
    @JsonKey(name: 'total_trips') int? totalTrips,
    @JsonKey(name: 'is_online') bool? isOnline,
    @JsonKey(name: 'last_seen_at') String? lastSeenAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ShipperDto;

  factory ShipperDto.fromJson(Map<String, dynamic> json) => 
      _$ShipperDtoFromJson(json);
}

/// Extension để convert DTO sang Entity
extension ShipperDtoX on ShipperDto {
  ShipperEntity toEntity() {
    return ShipperEntity(
      id: id,
      name: name,
      phone: phone,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      avatar: avatar,
      rating: rating,
      totalTrips: totalTrips,
      isOnline: isOnline,
      lastSeenAt: lastSeenAt != null ? DateTime.tryParse(lastSeenAt!) : null,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    );
  }
}

/// Request DTO cho lấy shipper trong khu vực
@freezed
abstract class GetShippersInAreaRequestDto with _$GetShippersInAreaRequestDto {
  const factory GetShippersInAreaRequestDto({
    required double latitude,
    required double longitude,
    @Default(10.0) double radius,
  }) = _GetShippersInAreaRequestDto;

  factory GetShippersInAreaRequestDto.fromJson(Map<String, dynamic> json) => 
      _$GetShippersInAreaRequestDtoFromJson(json);
}
