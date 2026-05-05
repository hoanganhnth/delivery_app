// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantSearchResult _$RestaurantSearchResultFromJson(
  Map<String, dynamic> json,
) => _RestaurantSearchResult(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  cuisine: json['cuisine'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$RestaurantSearchResultToJson(
  _RestaurantSearchResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'cuisine': instance.cuisine,
  'rating': instance.rating,
  'imageUrl': instance.imageUrl,
};

_DishSearchResult _$DishSearchResultFromJson(Map<String, dynamic> json) =>
    _DishSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      restaurantId: json['restaurantId'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$DishSearchResultToJson(_DishSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'restaurantId': instance.restaurantId,
      'imageUrl': instance.imageUrl,
    };

_ShipperSearchResult _$ShipperSearchResultFromJson(Map<String, dynamic> json) =>
    _ShipperSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      vehicleType: json['vehicleType'] as String?,
      licensePlate: json['licensePlate'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      isOnline: json['isOnline'] as bool?,
    );

Map<String, dynamic> _$ShipperSearchResultToJson(
  _ShipperSearchResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'vehicleType': instance.vehicleType,
  'licensePlate': instance.licensePlate,
  'rating': instance.rating,
  'isOnline': instance.isOnline,
};
