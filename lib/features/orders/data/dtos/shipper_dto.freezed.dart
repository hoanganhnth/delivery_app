// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipper_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShipperDto {

 int get id; String get name; String get phone;@JsonKey(name: 'vehicle_type') String get vehicleType;@JsonKey(name: 'vehicle_number') String get vehicleNumber; String? get avatar; double? get rating;@JsonKey(name: 'total_trips') int? get totalTrips;@JsonKey(name: 'is_online') bool? get isOnline;@JsonKey(name: 'last_seen_at') String? get lastSeenAt;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;
/// Create a copy of ShipperDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipperDtoCopyWith<ShipperDto> get copyWith => _$ShipperDtoCopyWithImpl<ShipperDto>(this as ShipperDto, _$identity);

  /// Serializes this ShipperDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipperDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalTrips, totalTrips) || other.totalTrips == totalTrips)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,vehicleType,vehicleNumber,avatar,rating,totalTrips,isOnline,lastSeenAt,createdAt,updatedAt);

@override
String toString() {
  return 'ShipperDto(id: $id, name: $name, phone: $phone, vehicleType: $vehicleType, vehicleNumber: $vehicleNumber, avatar: $avatar, rating: $rating, totalTrips: $totalTrips, isOnline: $isOnline, lastSeenAt: $lastSeenAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ShipperDtoCopyWith<$Res>  {
  factory $ShipperDtoCopyWith(ShipperDto value, $Res Function(ShipperDto) _then) = _$ShipperDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String phone,@JsonKey(name: 'vehicle_type') String vehicleType,@JsonKey(name: 'vehicle_number') String vehicleNumber, String? avatar, double? rating,@JsonKey(name: 'total_trips') int? totalTrips,@JsonKey(name: 'is_online') bool? isOnline,@JsonKey(name: 'last_seen_at') String? lastSeenAt,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class _$ShipperDtoCopyWithImpl<$Res>
    implements $ShipperDtoCopyWith<$Res> {
  _$ShipperDtoCopyWithImpl(this._self, this._then);

  final ShipperDto _self;
  final $Res Function(ShipperDto) _then;

/// Create a copy of ShipperDto
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
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipperDto].
extension ShipperDtoPatterns on ShipperDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipperDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipperDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipperDto value)  $default,){
final _that = this;
switch (_that) {
case _ShipperDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipperDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShipperDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String phone, @JsonKey(name: 'vehicle_type')  String vehicleType, @JsonKey(name: 'vehicle_number')  String vehicleNumber,  String? avatar,  double? rating, @JsonKey(name: 'total_trips')  int? totalTrips, @JsonKey(name: 'is_online')  bool? isOnline, @JsonKey(name: 'last_seen_at')  String? lastSeenAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipperDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String phone, @JsonKey(name: 'vehicle_type')  String vehicleType, @JsonKey(name: 'vehicle_number')  String vehicleNumber,  String? avatar,  double? rating, @JsonKey(name: 'total_trips')  int? totalTrips, @JsonKey(name: 'is_online')  bool? isOnline, @JsonKey(name: 'last_seen_at')  String? lastSeenAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ShipperDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String phone, @JsonKey(name: 'vehicle_type')  String vehicleType, @JsonKey(name: 'vehicle_number')  String vehicleNumber,  String? avatar,  double? rating, @JsonKey(name: 'total_trips')  int? totalTrips, @JsonKey(name: 'is_online')  bool? isOnline, @JsonKey(name: 'last_seen_at')  String? lastSeenAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ShipperDto() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.vehicleType,_that.vehicleNumber,_that.avatar,_that.rating,_that.totalTrips,_that.isOnline,_that.lastSeenAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShipperDto implements ShipperDto {
  const _ShipperDto({required this.id, required this.name, required this.phone, @JsonKey(name: 'vehicle_type') required this.vehicleType, @JsonKey(name: 'vehicle_number') required this.vehicleNumber, this.avatar, this.rating, @JsonKey(name: 'total_trips') this.totalTrips, @JsonKey(name: 'is_online') this.isOnline, @JsonKey(name: 'last_seen_at') this.lastSeenAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _ShipperDto.fromJson(Map<String, dynamic> json) => _$ShipperDtoFromJson(json);

@override final  int id;
@override final  String name;
@override final  String phone;
@override@JsonKey(name: 'vehicle_type') final  String vehicleType;
@override@JsonKey(name: 'vehicle_number') final  String vehicleNumber;
@override final  String? avatar;
@override final  double? rating;
@override@JsonKey(name: 'total_trips') final  int? totalTrips;
@override@JsonKey(name: 'is_online') final  bool? isOnline;
@override@JsonKey(name: 'last_seen_at') final  String? lastSeenAt;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;

/// Create a copy of ShipperDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipperDtoCopyWith<_ShipperDto> get copyWith => __$ShipperDtoCopyWithImpl<_ShipperDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShipperDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipperDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalTrips, totalTrips) || other.totalTrips == totalTrips)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,vehicleType,vehicleNumber,avatar,rating,totalTrips,isOnline,lastSeenAt,createdAt,updatedAt);

@override
String toString() {
  return 'ShipperDto(id: $id, name: $name, phone: $phone, vehicleType: $vehicleType, vehicleNumber: $vehicleNumber, avatar: $avatar, rating: $rating, totalTrips: $totalTrips, isOnline: $isOnline, lastSeenAt: $lastSeenAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ShipperDtoCopyWith<$Res> implements $ShipperDtoCopyWith<$Res> {
  factory _$ShipperDtoCopyWith(_ShipperDto value, $Res Function(_ShipperDto) _then) = __$ShipperDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String phone,@JsonKey(name: 'vehicle_type') String vehicleType,@JsonKey(name: 'vehicle_number') String vehicleNumber, String? avatar, double? rating,@JsonKey(name: 'total_trips') int? totalTrips,@JsonKey(name: 'is_online') bool? isOnline,@JsonKey(name: 'last_seen_at') String? lastSeenAt,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class __$ShipperDtoCopyWithImpl<$Res>
    implements _$ShipperDtoCopyWith<$Res> {
  __$ShipperDtoCopyWithImpl(this._self, this._then);

  final _ShipperDto _self;
  final $Res Function(_ShipperDto) _then;

/// Create a copy of ShipperDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? vehicleType = null,Object? vehicleNumber = null,Object? avatar = freezed,Object? rating = freezed,Object? totalTrips = freezed,Object? isOnline = freezed,Object? lastSeenAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ShipperDto(
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
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GetShippersInAreaRequestDto {

 double get latitude; double get longitude; double get radius;
/// Create a copy of GetShippersInAreaRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetShippersInAreaRequestDtoCopyWith<GetShippersInAreaRequestDto> get copyWith => _$GetShippersInAreaRequestDtoCopyWithImpl<GetShippersInAreaRequestDto>(this as GetShippersInAreaRequestDto, _$identity);

  /// Serializes this GetShippersInAreaRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetShippersInAreaRequestDto&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,radius);

@override
String toString() {
  return 'GetShippersInAreaRequestDto(latitude: $latitude, longitude: $longitude, radius: $radius)';
}


}

/// @nodoc
abstract mixin class $GetShippersInAreaRequestDtoCopyWith<$Res>  {
  factory $GetShippersInAreaRequestDtoCopyWith(GetShippersInAreaRequestDto value, $Res Function(GetShippersInAreaRequestDto) _then) = _$GetShippersInAreaRequestDtoCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double radius
});




}
/// @nodoc
class _$GetShippersInAreaRequestDtoCopyWithImpl<$Res>
    implements $GetShippersInAreaRequestDtoCopyWith<$Res> {
  _$GetShippersInAreaRequestDtoCopyWithImpl(this._self, this._then);

  final GetShippersInAreaRequestDto _self;
  final $Res Function(GetShippersInAreaRequestDto) _then;

/// Create a copy of GetShippersInAreaRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? radius = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GetShippersInAreaRequestDto].
extension GetShippersInAreaRequestDtoPatterns on GetShippersInAreaRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetShippersInAreaRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetShippersInAreaRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetShippersInAreaRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _GetShippersInAreaRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetShippersInAreaRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _GetShippersInAreaRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double radius)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetShippersInAreaRequestDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double radius)  $default,) {final _that = this;
switch (_that) {
case _GetShippersInAreaRequestDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  double radius)?  $default,) {final _that = this;
switch (_that) {
case _GetShippersInAreaRequestDto() when $default != null:
return $default(_that.latitude,_that.longitude,_that.radius);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetShippersInAreaRequestDto implements GetShippersInAreaRequestDto {
  const _GetShippersInAreaRequestDto({required this.latitude, required this.longitude, this.radius = 10.0});
  factory _GetShippersInAreaRequestDto.fromJson(Map<String, dynamic> json) => _$GetShippersInAreaRequestDtoFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override@JsonKey() final  double radius;

/// Create a copy of GetShippersInAreaRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetShippersInAreaRequestDtoCopyWith<_GetShippersInAreaRequestDto> get copyWith => __$GetShippersInAreaRequestDtoCopyWithImpl<_GetShippersInAreaRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetShippersInAreaRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetShippersInAreaRequestDto&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,radius);

@override
String toString() {
  return 'GetShippersInAreaRequestDto(latitude: $latitude, longitude: $longitude, radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$GetShippersInAreaRequestDtoCopyWith<$Res> implements $GetShippersInAreaRequestDtoCopyWith<$Res> {
  factory _$GetShippersInAreaRequestDtoCopyWith(_GetShippersInAreaRequestDto value, $Res Function(_GetShippersInAreaRequestDto) _then) = __$GetShippersInAreaRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double radius
});




}
/// @nodoc
class __$GetShippersInAreaRequestDtoCopyWithImpl<$Res>
    implements _$GetShippersInAreaRequestDtoCopyWith<$Res> {
  __$GetShippersInAreaRequestDtoCopyWithImpl(this._self, this._then);

  final _GetShippersInAreaRequestDto _self;
  final $Res Function(_GetShippersInAreaRequestDto) _then;

/// Create a copy of GetShippersInAreaRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? radius = null,}) {
  return _then(_GetShippersInAreaRequestDto(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
