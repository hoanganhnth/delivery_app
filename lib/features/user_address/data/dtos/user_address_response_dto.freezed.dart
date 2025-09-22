// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_address_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserAddressResponseDto {

 int? get id; int get userId; String get label; String get recipientName; String get phoneNumber; String get addressLine; String get ward; String get district; String get city; String? get postalCode; double? get latitude; double? get longitude; bool? get isDefault; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of UserAddressResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAddressResponseDtoCopyWith<UserAddressResponseDto> get copyWith => _$UserAddressResponseDtoCopyWithImpl<UserAddressResponseDto>(this as UserAddressResponseDto, _$identity);

  /// Serializes this UserAddressResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAddressResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.label, label) || other.label == label)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.ward, ward) || other.ward == ward)&&(identical(other.district, district) || other.district == district)&&(identical(other.city, city) || other.city == city)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,label,recipientName,phoneNumber,addressLine,ward,district,city,postalCode,latitude,longitude,isDefault,createdAt,updatedAt);

@override
String toString() {
  return 'UserAddressResponseDto(id: $id, userId: $userId, label: $label, recipientName: $recipientName, phoneNumber: $phoneNumber, addressLine: $addressLine, ward: $ward, district: $district, city: $city, postalCode: $postalCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserAddressResponseDtoCopyWith<$Res>  {
  factory $UserAddressResponseDtoCopyWith(UserAddressResponseDto value, $Res Function(UserAddressResponseDto) _then) = _$UserAddressResponseDtoCopyWithImpl;
@useResult
$Res call({
 int? id, int userId, String label, String recipientName, String phoneNumber, String addressLine, String ward, String district, String city, String? postalCode, double? latitude, double? longitude, bool? isDefault, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$UserAddressResponseDtoCopyWithImpl<$Res>
    implements $UserAddressResponseDtoCopyWith<$Res> {
  _$UserAddressResponseDtoCopyWithImpl(this._self, this._then);

  final UserAddressResponseDto _self;
  final $Res Function(UserAddressResponseDto) _then;

/// Create a copy of UserAddressResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? label = null,Object? recipientName = null,Object? phoneNumber = null,Object? addressLine = null,Object? ward = null,Object? district = null,Object? city = null,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,addressLine: null == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String,ward: null == ward ? _self.ward : ward // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAddressResponseDto].
extension UserAddressResponseDtoPatterns on UserAddressResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAddressResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAddressResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAddressResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _UserAddressResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAddressResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserAddressResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int userId,  String label,  String recipientName,  String phoneNumber,  String addressLine,  String ward,  String district,  String city,  String? postalCode,  double? latitude,  double? longitude,  bool? isDefault,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAddressResponseDto() when $default != null:
return $default(_that.id,_that.userId,_that.label,_that.recipientName,_that.phoneNumber,_that.addressLine,_that.ward,_that.district,_that.city,_that.postalCode,_that.latitude,_that.longitude,_that.isDefault,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int userId,  String label,  String recipientName,  String phoneNumber,  String addressLine,  String ward,  String district,  String city,  String? postalCode,  double? latitude,  double? longitude,  bool? isDefault,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserAddressResponseDto():
return $default(_that.id,_that.userId,_that.label,_that.recipientName,_that.phoneNumber,_that.addressLine,_that.ward,_that.district,_that.city,_that.postalCode,_that.latitude,_that.longitude,_that.isDefault,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int userId,  String label,  String recipientName,  String phoneNumber,  String addressLine,  String ward,  String district,  String city,  String? postalCode,  double? latitude,  double? longitude,  bool? isDefault,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserAddressResponseDto() when $default != null:
return $default(_that.id,_that.userId,_that.label,_that.recipientName,_that.phoneNumber,_that.addressLine,_that.ward,_that.district,_that.city,_that.postalCode,_that.latitude,_that.longitude,_that.isDefault,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserAddressResponseDto implements UserAddressResponseDto {
  const _UserAddressResponseDto({this.id, required this.userId, required this.label, required this.recipientName, required this.phoneNumber, required this.addressLine, required this.ward, required this.district, required this.city, this.postalCode, this.latitude, this.longitude, this.isDefault, this.createdAt, this.updatedAt});
  factory _UserAddressResponseDto.fromJson(Map<String, dynamic> json) => _$UserAddressResponseDtoFromJson(json);

@override final  int? id;
@override final  int userId;
@override final  String label;
@override final  String recipientName;
@override final  String phoneNumber;
@override final  String addressLine;
@override final  String ward;
@override final  String district;
@override final  String city;
@override final  String? postalCode;
@override final  double? latitude;
@override final  double? longitude;
@override final  bool? isDefault;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of UserAddressResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAddressResponseDtoCopyWith<_UserAddressResponseDto> get copyWith => __$UserAddressResponseDtoCopyWithImpl<_UserAddressResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserAddressResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAddressResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.label, label) || other.label == label)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.ward, ward) || other.ward == ward)&&(identical(other.district, district) || other.district == district)&&(identical(other.city, city) || other.city == city)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,label,recipientName,phoneNumber,addressLine,ward,district,city,postalCode,latitude,longitude,isDefault,createdAt,updatedAt);

@override
String toString() {
  return 'UserAddressResponseDto(id: $id, userId: $userId, label: $label, recipientName: $recipientName, phoneNumber: $phoneNumber, addressLine: $addressLine, ward: $ward, district: $district, city: $city, postalCode: $postalCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserAddressResponseDtoCopyWith<$Res> implements $UserAddressResponseDtoCopyWith<$Res> {
  factory _$UserAddressResponseDtoCopyWith(_UserAddressResponseDto value, $Res Function(_UserAddressResponseDto) _then) = __$UserAddressResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int? id, int userId, String label, String recipientName, String phoneNumber, String addressLine, String ward, String district, String city, String? postalCode, double? latitude, double? longitude, bool? isDefault, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$UserAddressResponseDtoCopyWithImpl<$Res>
    implements _$UserAddressResponseDtoCopyWith<$Res> {
  __$UserAddressResponseDtoCopyWithImpl(this._self, this._then);

  final _UserAddressResponseDto _self;
  final $Res Function(_UserAddressResponseDto) _then;

/// Create a copy of UserAddressResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? label = null,Object? recipientName = null,Object? phoneNumber = null,Object? addressLine = null,Object? ward = null,Object? district = null,Object? city = null,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_UserAddressResponseDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,addressLine: null == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String,ward: null == ward ? _self.ward : ward // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
