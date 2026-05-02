// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_context_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartContextRequestDto {

 int get shopId; int get userId; double get subTotal; double get shippingFee;
/// Create a copy of CartContextRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartContextRequestDtoCopyWith<CartContextRequestDto> get copyWith => _$CartContextRequestDtoCopyWithImpl<CartContextRequestDto>(this as CartContextRequestDto, _$identity);

  /// Serializes this CartContextRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartContextRequestDto&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.subTotal, subTotal) || other.subTotal == subTotal)&&(identical(other.shippingFee, shippingFee) || other.shippingFee == shippingFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,userId,subTotal,shippingFee);

@override
String toString() {
  return 'CartContextRequestDto(shopId: $shopId, userId: $userId, subTotal: $subTotal, shippingFee: $shippingFee)';
}


}

/// @nodoc
abstract mixin class $CartContextRequestDtoCopyWith<$Res>  {
  factory $CartContextRequestDtoCopyWith(CartContextRequestDto value, $Res Function(CartContextRequestDto) _then) = _$CartContextRequestDtoCopyWithImpl;
@useResult
$Res call({
 int shopId, int userId, double subTotal, double shippingFee
});




}
/// @nodoc
class _$CartContextRequestDtoCopyWithImpl<$Res>
    implements $CartContextRequestDtoCopyWith<$Res> {
  _$CartContextRequestDtoCopyWithImpl(this._self, this._then);

  final CartContextRequestDto _self;
  final $Res Function(CartContextRequestDto) _then;

/// Create a copy of CartContextRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shopId = null,Object? userId = null,Object? subTotal = null,Object? shippingFee = null,}) {
  return _then(_self.copyWith(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,subTotal: null == subTotal ? _self.subTotal : subTotal // ignore: cast_nullable_to_non_nullable
as double,shippingFee: null == shippingFee ? _self.shippingFee : shippingFee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CartContextRequestDto].
extension CartContextRequestDtoPatterns on CartContextRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartContextRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartContextRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartContextRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CartContextRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartContextRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CartContextRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int shopId,  int userId,  double subTotal,  double shippingFee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartContextRequestDto() when $default != null:
return $default(_that.shopId,_that.userId,_that.subTotal,_that.shippingFee);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int shopId,  int userId,  double subTotal,  double shippingFee)  $default,) {final _that = this;
switch (_that) {
case _CartContextRequestDto():
return $default(_that.shopId,_that.userId,_that.subTotal,_that.shippingFee);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int shopId,  int userId,  double subTotal,  double shippingFee)?  $default,) {final _that = this;
switch (_that) {
case _CartContextRequestDto() when $default != null:
return $default(_that.shopId,_that.userId,_that.subTotal,_that.shippingFee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartContextRequestDto implements CartContextRequestDto {
  const _CartContextRequestDto({required this.shopId, required this.userId, required this.subTotal, required this.shippingFee});
  factory _CartContextRequestDto.fromJson(Map<String, dynamic> json) => _$CartContextRequestDtoFromJson(json);

@override final  int shopId;
@override final  int userId;
@override final  double subTotal;
@override final  double shippingFee;

/// Create a copy of CartContextRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartContextRequestDtoCopyWith<_CartContextRequestDto> get copyWith => __$CartContextRequestDtoCopyWithImpl<_CartContextRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartContextRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartContextRequestDto&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.subTotal, subTotal) || other.subTotal == subTotal)&&(identical(other.shippingFee, shippingFee) || other.shippingFee == shippingFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shopId,userId,subTotal,shippingFee);

@override
String toString() {
  return 'CartContextRequestDto(shopId: $shopId, userId: $userId, subTotal: $subTotal, shippingFee: $shippingFee)';
}


}

/// @nodoc
abstract mixin class _$CartContextRequestDtoCopyWith<$Res> implements $CartContextRequestDtoCopyWith<$Res> {
  factory _$CartContextRequestDtoCopyWith(_CartContextRequestDto value, $Res Function(_CartContextRequestDto) _then) = __$CartContextRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 int shopId, int userId, double subTotal, double shippingFee
});




}
/// @nodoc
class __$CartContextRequestDtoCopyWithImpl<$Res>
    implements _$CartContextRequestDtoCopyWith<$Res> {
  __$CartContextRequestDtoCopyWithImpl(this._self, this._then);

  final _CartContextRequestDto _self;
  final $Res Function(_CartContextRequestDto) _then;

/// Create a copy of CartContextRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shopId = null,Object? userId = null,Object? subTotal = null,Object? shippingFee = null,}) {
  return _then(_CartContextRequestDto(
shopId: null == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,subTotal: null == subTotal ? _self.subTotal : subTotal // ignore: cast_nullable_to_non_nullable
as double,shippingFee: null == shippingFee ? _self.shippingFee : shippingFee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
