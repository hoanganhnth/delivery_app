// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageDto<T> _$PageDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _PageDto<T>(
  items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
  page: (json['page'] as num).toInt(),
  size: (json['size'] as num).toInt(),
  totalItems: (json['totalItems'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNext: json['hasNext'] as bool,
);

Map<String, dynamic> _$PageDtoToJson<T>(
  _PageDto<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'page': instance.page,
  'size': instance.size,
  'totalItems': instance.totalItems,
  'totalPages': instance.totalPages,
  'hasNext': instance.hasNext,
};
