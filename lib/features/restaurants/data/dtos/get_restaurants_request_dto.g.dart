// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_restaurants_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetRestaurantsRequestDto _$GetRestaurantsRequestDtoFromJson(
  Map<String, dynamic> json,
) => _GetRestaurantsRequestDto(
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  category: json['category'] as String?,
  searchQuery: json['searchQuery'] as String?,
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
);

Map<String, dynamic> _$GetRestaurantsRequestDtoToJson(
  _GetRestaurantsRequestDto instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'category': instance.category,
  'searchQuery': instance.searchQuery,
  'page': instance.page,
  'limit': instance.limit,
};
