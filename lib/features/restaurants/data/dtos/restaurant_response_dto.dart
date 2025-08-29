import 'package:json_annotation/json_annotation.dart';
import '../../../../core/data/dtos/base_response_dto.dart';

part 'restaurant_response_dto.g.dart';

@JsonSerializable()
class RestaurantDto {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final String cuisine;
  final double deliveryFee;
  final int deliveryTime;
  final bool isOpen;
  final double latitude;
  final double longitude;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  RestaurantDto({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.cuisine,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.isOpen,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RestaurantDto.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDtoToJson(this);
}

// Single restaurant response
typedef RestaurantResponseDto = BaseResponseDto<RestaurantDto>;

// List of restaurants response
typedef RestaurantsListResponseDto = BaseResponseDto<List<RestaurantDto>>;
