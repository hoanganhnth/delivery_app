// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipper_rating_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShipperRatingRequestDto {

 int get orderId; int get rating; String? get comment;
/// Create a copy of ShipperRatingRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipperRatingRequestDtoCopyWith<ShipperRatingRequestDto> get copyWith => _$ShipperRatingRequestDtoCopyWithImpl<ShipperRatingRequestDto>(this as ShipperRatingRequestDto, _$identity);

  /// Serializes this ShipperRatingRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipperRatingRequestDto&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,rating,comment);

@override
String toString() {
  return 'ShipperRatingRequestDto(orderId: $orderId, rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $ShipperRatingRequestDtoCopyWith<$Res>  {
  factory $ShipperRatingRequestDtoCopyWith(ShipperRatingRequestDto value, $Res Function(ShipperRatingRequestDto) _then) = _$ShipperRatingRequestDtoCopyWithImpl;
@useResult
$Res call({
 int orderId, int rating, String? comment
});




}
/// @nodoc
class _$ShipperRatingRequestDtoCopyWithImpl<$Res>
    implements $ShipperRatingRequestDtoCopyWith<$Res> {
  _$ShipperRatingRequestDtoCopyWithImpl(this._self, this._then);

  final ShipperRatingRequestDto _self;
  final $Res Function(ShipperRatingRequestDto) _then;

/// Create a copy of ShipperRatingRequestDto
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


/// Adds pattern-matching-related methods to [ShipperRatingRequestDto].
extension ShipperRatingRequestDtoPatterns on ShipperRatingRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipperRatingRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipperRatingRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipperRatingRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _ShipperRatingRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipperRatingRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShipperRatingRequestDto() when $default != null:
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
case _ShipperRatingRequestDto() when $default != null:
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
case _ShipperRatingRequestDto():
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
case _ShipperRatingRequestDto() when $default != null:
return $default(_that.orderId,_that.rating,_that.comment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShipperRatingRequestDto implements ShipperRatingRequestDto {
  const _ShipperRatingRequestDto({required this.orderId, required this.rating, this.comment});
  factory _ShipperRatingRequestDto.fromJson(Map<String, dynamic> json) => _$ShipperRatingRequestDtoFromJson(json);

@override final  int orderId;
@override final  int rating;
@override final  String? comment;

/// Create a copy of ShipperRatingRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipperRatingRequestDtoCopyWith<_ShipperRatingRequestDto> get copyWith => __$ShipperRatingRequestDtoCopyWithImpl<_ShipperRatingRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShipperRatingRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipperRatingRequestDto&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,rating,comment);

@override
String toString() {
  return 'ShipperRatingRequestDto(orderId: $orderId, rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$ShipperRatingRequestDtoCopyWith<$Res> implements $ShipperRatingRequestDtoCopyWith<$Res> {
  factory _$ShipperRatingRequestDtoCopyWith(_ShipperRatingRequestDto value, $Res Function(_ShipperRatingRequestDto) _then) = __$ShipperRatingRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 int orderId, int rating, String? comment
});




}
/// @nodoc
class __$ShipperRatingRequestDtoCopyWithImpl<$Res>
    implements _$ShipperRatingRequestDtoCopyWith<$Res> {
  __$ShipperRatingRequestDtoCopyWithImpl(this._self, this._then);

  final _ShipperRatingRequestDto _self;
  final $Res Function(_ShipperRatingRequestDto) _then;

/// Create a copy of ShipperRatingRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? rating = null,Object? comment = freezed,}) {
  return _then(_ShipperRatingRequestDto(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
