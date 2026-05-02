// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipper_rating_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShipperRatingDto {

 int get id; int get shipperId; int get customerId; int get orderId; int get rating; String? get comment; DateTime get createdAt;
/// Create a copy of ShipperRatingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipperRatingDtoCopyWith<ShipperRatingDto> get copyWith => _$ShipperRatingDtoCopyWithImpl<ShipperRatingDto>(this as ShipperRatingDto, _$identity);

  /// Serializes this ShipperRatingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipperRatingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.shipperId, shipperId) || other.shipperId == shipperId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shipperId,customerId,orderId,rating,comment,createdAt);

@override
String toString() {
  return 'ShipperRatingDto(id: $id, shipperId: $shipperId, customerId: $customerId, orderId: $orderId, rating: $rating, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ShipperRatingDtoCopyWith<$Res>  {
  factory $ShipperRatingDtoCopyWith(ShipperRatingDto value, $Res Function(ShipperRatingDto) _then) = _$ShipperRatingDtoCopyWithImpl;
@useResult
$Res call({
 int id, int shipperId, int customerId, int orderId, int rating, String? comment, DateTime createdAt
});




}
/// @nodoc
class _$ShipperRatingDtoCopyWithImpl<$Res>
    implements $ShipperRatingDtoCopyWith<$Res> {
  _$ShipperRatingDtoCopyWithImpl(this._self, this._then);

  final ShipperRatingDto _self;
  final $Res Function(ShipperRatingDto) _then;

/// Create a copy of ShipperRatingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shipperId = null,Object? customerId = null,Object? orderId = null,Object? rating = null,Object? comment = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shipperId: null == shipperId ? _self.shipperId : shipperId // ignore: cast_nullable_to_non_nullable
as int,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipperRatingDto].
extension ShipperRatingDtoPatterns on ShipperRatingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipperRatingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipperRatingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipperRatingDto value)  $default,){
final _that = this;
switch (_that) {
case _ShipperRatingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipperRatingDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShipperRatingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int shipperId,  int customerId,  int orderId,  int rating,  String? comment,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipperRatingDto() when $default != null:
return $default(_that.id,_that.shipperId,_that.customerId,_that.orderId,_that.rating,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int shipperId,  int customerId,  int orderId,  int rating,  String? comment,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ShipperRatingDto():
return $default(_that.id,_that.shipperId,_that.customerId,_that.orderId,_that.rating,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int shipperId,  int customerId,  int orderId,  int rating,  String? comment,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ShipperRatingDto() when $default != null:
return $default(_that.id,_that.shipperId,_that.customerId,_that.orderId,_that.rating,_that.comment,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShipperRatingDto implements ShipperRatingDto {
  const _ShipperRatingDto({required this.id, required this.shipperId, required this.customerId, required this.orderId, required this.rating, this.comment, required this.createdAt});
  factory _ShipperRatingDto.fromJson(Map<String, dynamic> json) => _$ShipperRatingDtoFromJson(json);

@override final  int id;
@override final  int shipperId;
@override final  int customerId;
@override final  int orderId;
@override final  int rating;
@override final  String? comment;
@override final  DateTime createdAt;

/// Create a copy of ShipperRatingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipperRatingDtoCopyWith<_ShipperRatingDto> get copyWith => __$ShipperRatingDtoCopyWithImpl<_ShipperRatingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShipperRatingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipperRatingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.shipperId, shipperId) || other.shipperId == shipperId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shipperId,customerId,orderId,rating,comment,createdAt);

@override
String toString() {
  return 'ShipperRatingDto(id: $id, shipperId: $shipperId, customerId: $customerId, orderId: $orderId, rating: $rating, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ShipperRatingDtoCopyWith<$Res> implements $ShipperRatingDtoCopyWith<$Res> {
  factory _$ShipperRatingDtoCopyWith(_ShipperRatingDto value, $Res Function(_ShipperRatingDto) _then) = __$ShipperRatingDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int shipperId, int customerId, int orderId, int rating, String? comment, DateTime createdAt
});




}
/// @nodoc
class __$ShipperRatingDtoCopyWithImpl<$Res>
    implements _$ShipperRatingDtoCopyWith<$Res> {
  __$ShipperRatingDtoCopyWithImpl(this._self, this._then);

  final _ShipperRatingDto _self;
  final $Res Function(_ShipperRatingDto) _then;

/// Create a copy of ShipperRatingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shipperId = null,Object? customerId = null,Object? orderId = null,Object? rating = null,Object? comment = freezed,Object? createdAt = null,}) {
  return _then(_ShipperRatingDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shipperId: null == shipperId ? _self.shipperId : shipperId // ignore: cast_nullable_to_non_nullable
as int,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
