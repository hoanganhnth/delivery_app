// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_restaurants_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NearbyRestaurantsRequestDto {

 double get latitude; double get longitude; double? get radius;
/// Create a copy of NearbyRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyRestaurantsRequestDtoCopyWith<NearbyRestaurantsRequestDto> get copyWith => _$NearbyRestaurantsRequestDtoCopyWithImpl<NearbyRestaurantsRequestDto>(this as NearbyRestaurantsRequestDto, _$identity);

  /// Serializes this NearbyRestaurantsRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyRestaurantsRequestDto&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,radius);

@override
String toString() {
  return 'NearbyRestaurantsRequestDto(latitude: $latitude, longitude: $longitude, radius: $radius)';
}


}

/// @nodoc
abstract mixin class $NearbyRestaurantsRequestDtoCopyWith<$Res>  {
  factory $NearbyRestaurantsRequestDtoCopyWith(NearbyRestaurantsRequestDto value, $Res Function(NearbyRestaurantsRequestDto) _then) = _$NearbyRestaurantsRequestDtoCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double? radius
});




}
/// @nodoc
class _$NearbyRestaurantsRequestDtoCopyWithImpl<$Res>
    implements $NearbyRestaurantsRequestDtoCopyWith<$Res> {
  _$NearbyRestaurantsRequestDtoCopyWithImpl(this._self, this._then);

  final NearbyRestaurantsRequestDto _self;
  final $Res Function(NearbyRestaurantsRequestDto) _then;

/// Create a copy of NearbyRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? radius = freezed,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,radius: freezed == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [NearbyRestaurantsRequestDto].
extension NearbyRestaurantsRequestDtoPatterns on NearbyRestaurantsRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyRestaurantsRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyRestaurantsRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyRestaurantsRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _NearbyRestaurantsRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyRestaurantsRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyRestaurantsRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double? radius)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyRestaurantsRequestDto() when $default != null:
return $default(_that.latitude,_that.longitude,_that.radius);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double? radius)  $default,) {final _that = this;
switch (_that) {
case _NearbyRestaurantsRequestDto():
return $default(_that.latitude,_that.longitude,_that.radius);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  double? radius)?  $default,) {final _that = this;
switch (_that) {
case _NearbyRestaurantsRequestDto() when $default != null:
return $default(_that.latitude,_that.longitude,_that.radius);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbyRestaurantsRequestDto implements NearbyRestaurantsRequestDto {
  const _NearbyRestaurantsRequestDto({required this.latitude, required this.longitude, this.radius});
  factory _NearbyRestaurantsRequestDto.fromJson(Map<String, dynamic> json) => _$NearbyRestaurantsRequestDtoFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override final  double? radius;

/// Create a copy of NearbyRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyRestaurantsRequestDtoCopyWith<_NearbyRestaurantsRequestDto> get copyWith => __$NearbyRestaurantsRequestDtoCopyWithImpl<_NearbyRestaurantsRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbyRestaurantsRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyRestaurantsRequestDto&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,radius);

@override
String toString() {
  return 'NearbyRestaurantsRequestDto(latitude: $latitude, longitude: $longitude, radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$NearbyRestaurantsRequestDtoCopyWith<$Res> implements $NearbyRestaurantsRequestDtoCopyWith<$Res> {
  factory _$NearbyRestaurantsRequestDtoCopyWith(_NearbyRestaurantsRequestDto value, $Res Function(_NearbyRestaurantsRequestDto) _then) = __$NearbyRestaurantsRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double? radius
});




}
/// @nodoc
class __$NearbyRestaurantsRequestDtoCopyWithImpl<$Res>
    implements _$NearbyRestaurantsRequestDtoCopyWith<$Res> {
  __$NearbyRestaurantsRequestDtoCopyWithImpl(this._self, this._then);

  final _NearbyRestaurantsRequestDto _self;
  final $Res Function(_NearbyRestaurantsRequestDto) _then;

/// Create a copy of NearbyRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? radius = freezed,}) {
  return _then(_NearbyRestaurantsRequestDto(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,radius: freezed == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
