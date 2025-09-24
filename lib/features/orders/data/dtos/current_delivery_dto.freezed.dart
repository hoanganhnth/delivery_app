// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_delivery_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentDeliveryDto {

 int get orderId; int? get shipperId; String get status; double get pickupLat; double get pickupLng; double get deliveryLat; double get deliveryLng; String? get pickupAddress; String? get deliveryAddress; String? get estimatedTime; String? get notes; String? get createdAt; String? get updatedAt;
/// Create a copy of CurrentDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentDeliveryDtoCopyWith<CurrentDeliveryDto> get copyWith => _$CurrentDeliveryDtoCopyWithImpl<CurrentDeliveryDto>(this as CurrentDeliveryDto, _$identity);

  /// Serializes this CurrentDeliveryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentDeliveryDto&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.shipperId, shipperId) || other.shipperId == shipperId)&&(identical(other.status, status) || other.status == status)&&(identical(other.pickupLat, pickupLat) || other.pickupLat == pickupLat)&&(identical(other.pickupLng, pickupLng) || other.pickupLng == pickupLng)&&(identical(other.deliveryLat, deliveryLat) || other.deliveryLat == deliveryLat)&&(identical(other.deliveryLng, deliveryLng) || other.deliveryLng == deliveryLng)&&(identical(other.pickupAddress, pickupAddress) || other.pickupAddress == pickupAddress)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.estimatedTime, estimatedTime) || other.estimatedTime == estimatedTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,shipperId,status,pickupLat,pickupLng,deliveryLat,deliveryLng,pickupAddress,deliveryAddress,estimatedTime,notes,createdAt,updatedAt);

@override
String toString() {
  return 'CurrentDeliveryDto(orderId: $orderId, shipperId: $shipperId, status: $status, pickupLat: $pickupLat, pickupLng: $pickupLng, deliveryLat: $deliveryLat, deliveryLng: $deliveryLng, pickupAddress: $pickupAddress, deliveryAddress: $deliveryAddress, estimatedTime: $estimatedTime, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CurrentDeliveryDtoCopyWith<$Res>  {
  factory $CurrentDeliveryDtoCopyWith(CurrentDeliveryDto value, $Res Function(CurrentDeliveryDto) _then) = _$CurrentDeliveryDtoCopyWithImpl;
@useResult
$Res call({
 int orderId, int? shipperId, String status, double pickupLat, double pickupLng, double deliveryLat, double deliveryLng, String? pickupAddress, String? deliveryAddress, String? estimatedTime, String? notes, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$CurrentDeliveryDtoCopyWithImpl<$Res>
    implements $CurrentDeliveryDtoCopyWith<$Res> {
  _$CurrentDeliveryDtoCopyWithImpl(this._self, this._then);

  final CurrentDeliveryDto _self;
  final $Res Function(CurrentDeliveryDto) _then;

/// Create a copy of CurrentDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? shipperId = freezed,Object? status = null,Object? pickupLat = null,Object? pickupLng = null,Object? deliveryLat = null,Object? deliveryLng = null,Object? pickupAddress = freezed,Object? deliveryAddress = freezed,Object? estimatedTime = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,shipperId: freezed == shipperId ? _self.shipperId : shipperId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,pickupLat: null == pickupLat ? _self.pickupLat : pickupLat // ignore: cast_nullable_to_non_nullable
as double,pickupLng: null == pickupLng ? _self.pickupLng : pickupLng // ignore: cast_nullable_to_non_nullable
as double,deliveryLat: null == deliveryLat ? _self.deliveryLat : deliveryLat // ignore: cast_nullable_to_non_nullable
as double,deliveryLng: null == deliveryLng ? _self.deliveryLng : deliveryLng // ignore: cast_nullable_to_non_nullable
as double,pickupAddress: freezed == pickupAddress ? _self.pickupAddress : pickupAddress // ignore: cast_nullable_to_non_nullable
as String?,deliveryAddress: freezed == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String?,estimatedTime: freezed == estimatedTime ? _self.estimatedTime : estimatedTime // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentDeliveryDto].
extension CurrentDeliveryDtoPatterns on CurrentDeliveryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentDeliveryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentDeliveryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentDeliveryDto value)  $default,){
final _that = this;
switch (_that) {
case _CurrentDeliveryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentDeliveryDto value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentDeliveryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int orderId,  int? shipperId,  String status,  double pickupLat,  double pickupLng,  double deliveryLat,  double deliveryLng,  String? pickupAddress,  String? deliveryAddress,  String? estimatedTime,  String? notes,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentDeliveryDto() when $default != null:
return $default(_that.orderId,_that.shipperId,_that.status,_that.pickupLat,_that.pickupLng,_that.deliveryLat,_that.deliveryLng,_that.pickupAddress,_that.deliveryAddress,_that.estimatedTime,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int orderId,  int? shipperId,  String status,  double pickupLat,  double pickupLng,  double deliveryLat,  double deliveryLng,  String? pickupAddress,  String? deliveryAddress,  String? estimatedTime,  String? notes,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CurrentDeliveryDto():
return $default(_that.orderId,_that.shipperId,_that.status,_that.pickupLat,_that.pickupLng,_that.deliveryLat,_that.deliveryLng,_that.pickupAddress,_that.deliveryAddress,_that.estimatedTime,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int orderId,  int? shipperId,  String status,  double pickupLat,  double pickupLng,  double deliveryLat,  double deliveryLng,  String? pickupAddress,  String? deliveryAddress,  String? estimatedTime,  String? notes,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CurrentDeliveryDto() when $default != null:
return $default(_that.orderId,_that.shipperId,_that.status,_that.pickupLat,_that.pickupLng,_that.deliveryLat,_that.deliveryLng,_that.pickupAddress,_that.deliveryAddress,_that.estimatedTime,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentDeliveryDto implements CurrentDeliveryDto {
  const _CurrentDeliveryDto({required this.orderId, this.shipperId, required this.status, required this.pickupLat, required this.pickupLng, required this.deliveryLat, required this.deliveryLng, this.pickupAddress, this.deliveryAddress, this.estimatedTime, this.notes, this.createdAt, this.updatedAt});
  factory _CurrentDeliveryDto.fromJson(Map<String, dynamic> json) => _$CurrentDeliveryDtoFromJson(json);

@override final  int orderId;
@override final  int? shipperId;
@override final  String status;
@override final  double pickupLat;
@override final  double pickupLng;
@override final  double deliveryLat;
@override final  double deliveryLng;
@override final  String? pickupAddress;
@override final  String? deliveryAddress;
@override final  String? estimatedTime;
@override final  String? notes;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of CurrentDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentDeliveryDtoCopyWith<_CurrentDeliveryDto> get copyWith => __$CurrentDeliveryDtoCopyWithImpl<_CurrentDeliveryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentDeliveryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentDeliveryDto&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.shipperId, shipperId) || other.shipperId == shipperId)&&(identical(other.status, status) || other.status == status)&&(identical(other.pickupLat, pickupLat) || other.pickupLat == pickupLat)&&(identical(other.pickupLng, pickupLng) || other.pickupLng == pickupLng)&&(identical(other.deliveryLat, deliveryLat) || other.deliveryLat == deliveryLat)&&(identical(other.deliveryLng, deliveryLng) || other.deliveryLng == deliveryLng)&&(identical(other.pickupAddress, pickupAddress) || other.pickupAddress == pickupAddress)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.estimatedTime, estimatedTime) || other.estimatedTime == estimatedTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,shipperId,status,pickupLat,pickupLng,deliveryLat,deliveryLng,pickupAddress,deliveryAddress,estimatedTime,notes,createdAt,updatedAt);

@override
String toString() {
  return 'CurrentDeliveryDto(orderId: $orderId, shipperId: $shipperId, status: $status, pickupLat: $pickupLat, pickupLng: $pickupLng, deliveryLat: $deliveryLat, deliveryLng: $deliveryLng, pickupAddress: $pickupAddress, deliveryAddress: $deliveryAddress, estimatedTime: $estimatedTime, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CurrentDeliveryDtoCopyWith<$Res> implements $CurrentDeliveryDtoCopyWith<$Res> {
  factory _$CurrentDeliveryDtoCopyWith(_CurrentDeliveryDto value, $Res Function(_CurrentDeliveryDto) _then) = __$CurrentDeliveryDtoCopyWithImpl;
@override @useResult
$Res call({
 int orderId, int? shipperId, String status, double pickupLat, double pickupLng, double deliveryLat, double deliveryLng, String? pickupAddress, String? deliveryAddress, String? estimatedTime, String? notes, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$CurrentDeliveryDtoCopyWithImpl<$Res>
    implements _$CurrentDeliveryDtoCopyWith<$Res> {
  __$CurrentDeliveryDtoCopyWithImpl(this._self, this._then);

  final _CurrentDeliveryDto _self;
  final $Res Function(_CurrentDeliveryDto) _then;

/// Create a copy of CurrentDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? shipperId = freezed,Object? status = null,Object? pickupLat = null,Object? pickupLng = null,Object? deliveryLat = null,Object? deliveryLng = null,Object? pickupAddress = freezed,Object? deliveryAddress = freezed,Object? estimatedTime = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CurrentDeliveryDto(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,shipperId: freezed == shipperId ? _self.shipperId : shipperId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,pickupLat: null == pickupLat ? _self.pickupLat : pickupLat // ignore: cast_nullable_to_non_nullable
as double,pickupLng: null == pickupLng ? _self.pickupLng : pickupLng // ignore: cast_nullable_to_non_nullable
as double,deliveryLat: null == deliveryLat ? _self.deliveryLat : deliveryLat // ignore: cast_nullable_to_non_nullable
as double,deliveryLng: null == deliveryLng ? _self.deliveryLng : deliveryLng // ignore: cast_nullable_to_non_nullable
as double,pickupAddress: freezed == pickupAddress ? _self.pickupAddress : pickupAddress // ignore: cast_nullable_to_non_nullable
as String?,deliveryAddress: freezed == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String?,estimatedTime: freezed == estimatedTime ? _self.estimatedTime : estimatedTime // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
