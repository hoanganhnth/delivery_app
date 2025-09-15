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
    required String vehicleType,
    required String vehicleNumber,
    String? avatar,
    double? rating,
    int? totalTrips,
    bool? isOnline,
    String? lastSeenAt,
    String? createdAt,
    String? updatedAt,
  }) = _ShipperDto;

  factory ShipperDto.fromJson(Map<String, dynamic> json) => 
      _$ShipperDtoFromJson(json);

  /// Factory để convert từ snake_case API response
  factory ShipperDto.fromApiJson(Map<String, dynamic> json) {
    return ShipperDto(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      vehicleType: json['vehicle_type'] as String,
      vehicleNumber: json['vehicle_number'] as String,
      avatar: json['avatar'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      totalTrips: json['total_trips'] as int?,
      isOnline: json['is_online'] as bool?,
      lastSeenAt: json['last_seen_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
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
