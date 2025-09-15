// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipper_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShipperEntity {

 int get id; String get name; String get phone; String get vehicleType; String get vehicleNumber; String? get avatar; double? get rating; int? get totalTrips; bool? get isOnline; DateTime? get lastSeenAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of ShipperEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipperEntityCopyWith<ShipperEntity> get copyWith => _$ShipperEntityCopyWithImpl<ShipperEntity>(this as ShipperEntity, _$identity);

  /// Serializes this ShipperEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipperEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalTrips, totalTrips) || other.totalTrips == totalTrips)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,vehicleType,vehicleNumber,avatar,rating,totalTrips,isOnline,lastSeenAt,createdAt,updatedAt);

@override
String toString() {
  return 'ShipperEntity(id: $id, name: $name, phone: $phone, vehicleType: $vehicleType, vehicleNumber: $vehicleNumber, avatar: $avatar, rating: $rating, totalTrips: $totalTrips, isOnline: $isOnline, lastSeenAt: $lastSeenAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ShipperEntityCopyWith<$Res>  {
  factory $ShipperEntityCopyWith(ShipperEntity value, $Res Function(ShipperEntity) _then) = _$ShipperEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String phone, String vehicleType, String vehicleNumber, String? avatar, double? rating, int? totalTrips, bool? isOnline, DateTime? lastSeenAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ShipperEntityCopyWithImpl<$Res>
    implements $ShipperEntityCopyWith<$Res> {
  _$ShipperEntityCopyWithImpl(this._self, this._then);

  final ShipperEntity _self;
  final $Res Function(ShipperEntity) _then;

/// Create a copy of ShipperEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? vehicleType = null,Object? vehicleNumber = null,Object? avatar = freezed,Object? rating = freezed,Object? totalTrips = freezed,Object? isOnline = freezed,Object? lastSeenAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String,vehicleNumber: null == vehicleNumber ? _self.vehicleNumber : vehicleNumber // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,totalTrips: freezed == totalTrips ? _self.totalTrips : totalTrips // ignore: cast_nullable_to_non_nullable
as int?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool?,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipperEntity].
extension ShipperEntityPatterns on ShipperEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipperEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipperEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipperEntity value)  $default,){
final _that = this;
switch (_that) {
case _ShipperEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipperEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ShipperEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String phone,  String vehicleType,  String vehicleNumber,  String? avatar,  double? rating,  int? totalTrips,  bool? isOnline,  DateTime? lastSeenAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipperEntity() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.vehicleType,_that.vehicleNumber,_that.avatar,_that.rating,_that.totalTrips,_that.isOnline,_that.lastSeenAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String phone,  String vehicleType,  String vehicleNumber,  String? avatar,  double? rating,  int? totalTrips,  bool? isOnline,  DateTime? lastSeenAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ShipperEntity():
return $default(_that.id,_that.name,_that.phone,_that.vehicleType,_that.vehicleNumber,_that.avatar,_that.rating,_that.totalTrips,_that.isOnline,_that.lastSeenAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String phone,  String vehicleType,  String vehicleNumber,  String? avatar,  double? rating,  int? totalTrips,  bool? isOnline,  DateTime? lastSeenAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ShipperEntity() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.vehicleType,_that.vehicleNumber,_that.avatar,_that.rating,_that.totalTrips,_that.isOnline,_that.lastSeenAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShipperEntity implements ShipperEntity {
  const _ShipperEntity({required this.id, required this.name, required this.phone, required this.vehicleType, required this.vehicleNumber, this.avatar, this.rating, this.totalTrips, this.isOnline, this.lastSeenAt, this.createdAt, this.updatedAt});
  factory _ShipperEntity.fromJson(Map<String, dynamic> json) => _$ShipperEntityFromJson(json);

@override final  int id;
@override final  String name;
@override final  String phone;
@override final  String vehicleType;
@override final  String vehicleNumber;
@override final  String? avatar;
@override final  double? rating;
@override final  int? totalTrips;
@override final  bool? isOnline;
@override final  DateTime? lastSeenAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ShipperEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipperEntityCopyWith<_ShipperEntity> get copyWith => __$ShipperEntityCopyWithImpl<_ShipperEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShipperEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipperEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalTrips, totalTrips) || other.totalTrips == totalTrips)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,vehicleType,vehicleNumber,avatar,rating,totalTrips,isOnline,lastSeenAt,createdAt,updatedAt);

@override
String toString() {
  return 'ShipperEntity(id: $id, name: $name, phone: $phone, vehicleType: $vehicleType, vehicleNumber: $vehicleNumber, avatar: $avatar, rating: $rating, totalTrips: $totalTrips, isOnline: $isOnline, lastSeenAt: $lastSeenAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ShipperEntityCopyWith<$Res> implements $ShipperEntityCopyWith<$Res> {
  factory _$ShipperEntityCopyWith(_ShipperEntity value, $Res Function(_ShipperEntity) _then) = __$ShipperEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String phone, String vehicleType, String vehicleNumber, String? avatar, double? rating, int? totalTrips, bool? isOnline, DateTime? lastSeenAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ShipperEntityCopyWithImpl<$Res>
    implements _$ShipperEntityCopyWith<$Res> {
  __$ShipperEntityCopyWithImpl(this._self, this._then);

  final _ShipperEntity _self;
  final $Res Function(_ShipperEntity) _then;

/// Create a copy of ShipperEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? vehicleType = null,Object? vehicleNumber = null,Object? avatar = freezed,Object? rating = freezed,Object? totalTrips = freezed,Object? isOnline = freezed,Object? lastSeenAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ShipperEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String,vehicleNumber: null == vehicleNumber ? _self.vehicleNumber : vehicleNumber // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,totalTrips: freezed == totalTrips ? _self.totalTrips : totalTrips // ignore: cast_nullable_to_non_nullable
as int?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool?,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
