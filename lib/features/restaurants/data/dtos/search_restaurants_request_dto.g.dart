// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_restaurants_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchRestaurantsRequestDto _$SearchRestaurantsRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _SearchRestaurantsRequestDto(
      query: json['query'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      category: json['category'] as String?,
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchRestaurantsRequestDtoToJson(
        _SearchRestaurantsRequestDto instance) =>
    <String, dynamic>{
      'query': instance.query,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'category': instance.category,
      'page': instance.page,
      'limit': instance.limit,
    };
