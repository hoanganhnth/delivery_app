// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_restaurants_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetRestaurantsRequestDto {

 double? get latitude; double? get longitude; String? get category; String? get searchQuery; int? get page; int? get limit;
/// Create a copy of GetRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetRestaurantsRequestDtoCopyWith<GetRestaurantsRequestDto> get copyWith => _$GetRestaurantsRequestDtoCopyWithImpl<GetRestaurantsRequestDto>(this as GetRestaurantsRequestDto, _$identity);

  /// Serializes this GetRestaurantsRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetRestaurantsRequestDto&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.category, category) || other.category == category)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,category,searchQuery,page,limit);

@override
String toString() {
  return 'GetRestaurantsRequestDto(latitude: $latitude, longitude: $longitude, category: $category, searchQuery: $searchQuery, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $GetRestaurantsRequestDtoCopyWith<$Res>  {
  factory $GetRestaurantsRequestDtoCopyWith(GetRestaurantsRequestDto value, $Res Function(GetRestaurantsRequestDto) _then) = _$GetRestaurantsRequestDtoCopyWithImpl;
@useResult
$Res call({
 double? latitude, double? longitude, String? category, String? searchQuery, int? page, int? limit
});




}
/// @nodoc
class _$GetRestaurantsRequestDtoCopyWithImpl<$Res>
    implements $GetRestaurantsRequestDtoCopyWith<$Res> {
  _$GetRestaurantsRequestDtoCopyWithImpl(this._self, this._then);

  final GetRestaurantsRequestDto _self;
  final $Res Function(GetRestaurantsRequestDto) _then;

/// Create a copy of GetRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? category = freezed,Object? searchQuery = freezed,Object? page = freezed,Object? limit = freezed,}) {
  return _then(_self.copyWith(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetRestaurantsRequestDto].
extension GetRestaurantsRequestDtoPatterns on GetRestaurantsRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetRestaurantsRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetRestaurantsRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetRestaurantsRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _GetRestaurantsRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetRestaurantsRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _GetRestaurantsRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? latitude,  double? longitude,  String? category,  String? searchQuery,  int? page,  int? limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetRestaurantsRequestDto() when $default != null:
return $default(_that.latitude,_that.longitude,_that.category,_that.searchQuery,_that.page,_that.limit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? latitude,  double? longitude,  String? category,  String? searchQuery,  int? page,  int? limit)  $default,) {final _that = this;
switch (_that) {
case _GetRestaurantsRequestDto():
return $default(_that.latitude,_that.longitude,_that.category,_that.searchQuery,_that.page,_that.limit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? latitude,  double? longitude,  String? category,  String? searchQuery,  int? page,  int? limit)?  $default,) {final _that = this;
switch (_that) {
case _GetRestaurantsRequestDto() when $default != null:
return $default(_that.latitude,_that.longitude,_that.category,_that.searchQuery,_that.page,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetRestaurantsRequestDto implements GetRestaurantsRequestDto {
  const _GetRestaurantsRequestDto({this.latitude, this.longitude, this.category, this.searchQuery, this.page, this.limit});
  factory _GetRestaurantsRequestDto.fromJson(Map<String, dynamic> json) => _$GetRestaurantsRequestDtoFromJson(json);

@override final  double? latitude;
@override final  double? longitude;
@override final  String? category;
@override final  String? searchQuery;
@override final  int? page;
@override final  int? limit;

/// Create a copy of GetRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetRestaurantsRequestDtoCopyWith<_GetRestaurantsRequestDto> get copyWith => __$GetRestaurantsRequestDtoCopyWithImpl<_GetRestaurantsRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetRestaurantsRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetRestaurantsRequestDto&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.category, category) || other.category == category)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,category,searchQuery,page,limit);

@override
String toString() {
  return 'GetRestaurantsRequestDto(latitude: $latitude, longitude: $longitude, category: $category, searchQuery: $searchQuery, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$GetRestaurantsRequestDtoCopyWith<$Res> implements $GetRestaurantsRequestDtoCopyWith<$Res> {
  factory _$GetRestaurantsRequestDtoCopyWith(_GetRestaurantsRequestDto value, $Res Function(_GetRestaurantsRequestDto) _then) = __$GetRestaurantsRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 double? latitude, double? longitude, String? category, String? searchQuery, int? page, int? limit
});




}
/// @nodoc
class __$GetRestaurantsRequestDtoCopyWithImpl<$Res>
    implements _$GetRestaurantsRequestDtoCopyWith<$Res> {
  __$GetRestaurantsRequestDtoCopyWithImpl(this._self, this._then);

  final _GetRestaurantsRequestDto _self;
  final $Res Function(_GetRestaurantsRequestDto) _then;

/// Create a copy of GetRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? category = freezed,Object? searchQuery = freezed,Object? page = freezed,Object? limit = freezed,}) {
  return _then(_GetRestaurantsRequestDto(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
