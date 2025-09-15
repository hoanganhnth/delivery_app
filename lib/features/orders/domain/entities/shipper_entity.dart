import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipper_entity.freezed.dart';
part 'shipper_entity.g.dart';

/// Entity cho thông tin shipper
@freezed
abstract class ShipperEntity with _$ShipperEntity {
  const factory ShipperEntity({
    required int id,
    required String name,
    required String phone,
    required String vehicleType,
    required String vehicleNumber,
    String? avatar,
    double? rating,
    int? totalTrips,
    bool? isOnline,
    DateTime? lastSeenAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ShipperEntity;

  factory ShipperEntity.fromJson(Map<String, dynamic> json) => 
      _$ShipperEntityFromJson(json);
}
