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
      addressLat: (json['addressLat'] as num).toDouble(),
      addressLng: (json['addressLng'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      openingHour: DateTime.parse(json['openingHour'] as String),
      closingHour: DateTime.parse(json['closingHour'] as String),
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
      'addressLat': instance.addressLat,
      'addressLng': instance.addressLng,
      'openingHour': instance.openingHour.toIso8601String(),
      'closingHour': instance.closingHour.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
