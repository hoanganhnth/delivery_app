// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_rating_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestaurantRatingRequestDto {

 int get orderId; int get rating; String? get comment;
/// Create a copy of RestaurantRatingRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantRatingRequestDtoCopyWith<RestaurantRatingRequestDto> get copyWith => _$RestaurantRatingRequestDtoCopyWithImpl<RestaurantRatingRequestDto>(this as RestaurantRatingRequestDto, _$identity);

  /// Serializes this RestaurantRatingRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantRatingRequestDto&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,rating,comment);

@override
String toString() {
  return 'RestaurantRatingRequestDto(orderId: $orderId, rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $RestaurantRatingRequestDtoCopyWith<$Res>  {
  factory $RestaurantRatingRequestDtoCopyWith(RestaurantRatingRequestDto value, $Res Function(RestaurantRatingRequestDto) _then) = _$RestaurantRatingRequestDtoCopyWithImpl;
@useResult
$Res call({
 int orderId, int rating, String? comment
});




}
/// @nodoc
class _$RestaurantRatingRequestDtoCopyWithImpl<$Res>
    implements $RestaurantRatingRequestDtoCopyWith<$Res> {
  _$RestaurantRatingRequestDtoCopyWithImpl(this._self, this._then);

  final RestaurantRatingRequestDto _self;
  final $Res Function(RestaurantRatingRequestDto) _then;

/// Create a copy of RestaurantRatingRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? rating = null,Object? comment = freezed,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantRatingRequestDto].
extension RestaurantRatingRequestDtoPatterns on RestaurantRatingRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantRatingRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantRatingRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantRatingRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantRatingRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantRatingRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantRatingRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int orderId,  int rating,  String? comment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantRatingRequestDto() when $default != null:
return $default(_that.orderId,_that.rating,_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int orderId,  int rating,  String? comment)  $default,) {final _that = this;
switch (_that) {
case _RestaurantRatingRequestDto():
return $default(_that.orderId,_that.rating,_that.comment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int orderId,  int rating,  String? comment)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantRatingRequestDto() when $default != null:
return $default(_that.orderId,_that.rating,_that.comment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestaurantRatingRequestDto implements RestaurantRatingRequestDto {
  const _RestaurantRatingRequestDto({required this.orderId, required this.rating, this.comment});
  factory _RestaurantRatingRequestDto.fromJson(Map<String, dynamic> json) => _$RestaurantRatingRequestDtoFromJson(json);

@override final  int orderId;
@override final  int rating;
@override final  String? comment;

/// Create a copy of RestaurantRatingRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantRatingRequestDtoCopyWith<_RestaurantRatingRequestDto> get copyWith => __$RestaurantRatingRequestDtoCopyWithImpl<_RestaurantRatingRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantRatingRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantRatingRequestDto&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,rating,comment);

@override
String toString() {
  return 'RestaurantRatingRequestDto(orderId: $orderId, rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$RestaurantRatingRequestDtoCopyWith<$Res> implements $RestaurantRatingRequestDtoCopyWith<$Res> {
  factory _$RestaurantRatingRequestDtoCopyWith(_RestaurantRatingRequestDto value, $Res Function(_RestaurantRatingRequestDto) _then) = __$RestaurantRatingRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 int orderId, int rating, String? comment
});




}
/// @nodoc
class __$RestaurantRatingRequestDtoCopyWithImpl<$Res>
    implements _$RestaurantRatingRequestDtoCopyWith<$Res> {
  __$RestaurantRatingRequestDtoCopyWithImpl(this._self, this._then);

  final _RestaurantRatingRequestDto _self;
  final $Res Function(_RestaurantRatingRequestDto) _then;

/// Create a copy of RestaurantRatingRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? rating = null,Object? comment = freezed,}) {
  return _then(_RestaurantRatingRequestDto(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
