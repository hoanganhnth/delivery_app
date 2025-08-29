// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantDto _$RestaurantDtoFromJson(Map<String, dynamic> json) =>
    RestaurantDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      cuisine: json['cuisine'] as String,
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      deliveryTime: (json['deliveryTime'] as num).toInt(),
      isOpen: json['isOpen'] as bool,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$RestaurantDtoToJson(RestaurantDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'cuisine': instance.cuisine,
      'deliveryFee': instance.deliveryFee,
      'deliveryTime': instance.deliveryTime,
      'isOpen': instance.isOpen,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
