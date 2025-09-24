import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/shipper_entity.dart';

part 'shipper_dto.freezed.dart';
part 'shipper_dto.g.dart';

/// DTO cho thông tin shipper từ API
@freezed
abstract class ShipperDto with _$ShipperDto {
  const factory ShipperDto({
    required int id,
    String? name,
    required String phone,
    required String vehicleType,
    required String licenseNumber,
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
}

/// Extension để convert DTO sang Entity
extension ShipperDtoX on ShipperDto {
  ShipperEntity toEntity() {
    return ShipperEntity(
      id: id,
      name: name ??'',
      phone: phone,
      vehicleType: vehicleType,
      vehicleNumber: licenseNumber,
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
