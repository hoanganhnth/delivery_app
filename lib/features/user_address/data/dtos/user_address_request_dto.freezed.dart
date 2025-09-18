// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_address_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserAddressRequestDto {

 String get label; String get addressLine; String get ward; String get district; String get city; String? get postalCode; double? get latitude; double? get longitude; bool? get isDefault;
/// Create a copy of UserAddressRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAddressRequestDtoCopyWith<UserAddressRequestDto> get copyWith => _$UserAddressRequestDtoCopyWithImpl<UserAddressRequestDto>(this as UserAddressRequestDto, _$identity);

  /// Serializes this UserAddressRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAddressRequestDto&&(identical(other.label, label) || other.label == label)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.ward, ward) || other.ward == ward)&&(identical(other.district, district) || other.district == district)&&(identical(other.city, city) || other.city == city)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,addressLine,ward,district,city,postalCode,latitude,longitude,isDefault);

@override
String toString() {
  return 'UserAddressRequestDto(label: $label, addressLine: $addressLine, ward: $ward, district: $district, city: $city, postalCode: $postalCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $UserAddressRequestDtoCopyWith<$Res>  {
  factory $UserAddressRequestDtoCopyWith(UserAddressRequestDto value, $Res Function(UserAddressRequestDto) _then) = _$UserAddressRequestDtoCopyWithImpl;
@useResult
$Res call({
 String label, String addressLine, String ward, String district, String city, String? postalCode, double? latitude, double? longitude, bool? isDefault
});




}
/// @nodoc
class _$UserAddressRequestDtoCopyWithImpl<$Res>
    implements $UserAddressRequestDtoCopyWith<$Res> {
  _$UserAddressRequestDtoCopyWithImpl(this._self, this._then);

  final UserAddressRequestDto _self;
  final $Res Function(UserAddressRequestDto) _then;

/// Create a copy of UserAddressRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? addressLine = null,Object? ward = null,Object? district = null,Object? city = null,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,addressLine: null == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String,ward: null == ward ? _self.ward : ward // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAddressRequestDto].
extension UserAddressRequestDtoPatterns on UserAddressRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAddressRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAddressRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAddressRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _UserAddressRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAddressRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserAddressRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String addressLine,  String ward,  String district,  String city,  String? postalCode,  double? latitude,  double? longitude,  bool? isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAddressRequestDto() when $default != null:
return $default(_that.label,_that.addressLine,_that.ward,_that.district,_that.city,_that.postalCode,_that.latitude,_that.longitude,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String addressLine,  String ward,  String district,  String city,  String? postalCode,  double? latitude,  double? longitude,  bool? isDefault)  $default,) {final _that = this;
switch (_that) {
case _UserAddressRequestDto():
return $default(_that.label,_that.addressLine,_that.ward,_that.district,_that.city,_that.postalCode,_that.latitude,_that.longitude,_that.isDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String addressLine,  String ward,  String district,  String city,  String? postalCode,  double? latitude,  double? longitude,  bool? isDefault)?  $default,) {final _that = this;
switch (_that) {
case _UserAddressRequestDto() when $default != null:
return $default(_that.label,_that.addressLine,_that.ward,_that.district,_that.city,_that.postalCode,_that.latitude,_that.longitude,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserAddressRequestDto implements UserAddressRequestDto {
  const _UserAddressRequestDto({required this.label, required this.addressLine, required this.ward, required this.district, required this.city, this.postalCode, this.latitude, this.longitude, this.isDefault});
  factory _UserAddressRequestDto.fromJson(Map<String, dynamic> json) => _$UserAddressRequestDtoFromJson(json);

@override final  String label;
@override final  String addressLine;
@override final  String ward;
@override final  String district;
@override final  String city;
@override final  String? postalCode;
@override final  double? latitude;
@override final  double? longitude;
@override final  bool? isDefault;

/// Create a copy of UserAddressRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAddressRequestDtoCopyWith<_UserAddressRequestDto> get copyWith => __$UserAddressRequestDtoCopyWithImpl<_UserAddressRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserAddressRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAddressRequestDto&&(identical(other.label, label) || other.label == label)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.ward, ward) || other.ward == ward)&&(identical(other.district, district) || other.district == district)&&(identical(other.city, city) || other.city == city)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,addressLine,ward,district,city,postalCode,latitude,longitude,isDefault);

@override
String toString() {
  return 'UserAddressRequestDto(label: $label, addressLine: $addressLine, ward: $ward, district: $district, city: $city, postalCode: $postalCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$UserAddressRequestDtoCopyWith<$Res> implements $UserAddressRequestDtoCopyWith<$Res> {
  factory _$UserAddressRequestDtoCopyWith(_UserAddressRequestDto value, $Res Function(_UserAddressRequestDto) _then) = __$UserAddressRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String label, String addressLine, String ward, String district, String city, String? postalCode, double? latitude, double? longitude, bool? isDefault
});




}
/// @nodoc
class __$UserAddressRequestDtoCopyWithImpl<$Res>
    implements _$UserAddressRequestDtoCopyWith<$Res> {
  __$UserAddressRequestDtoCopyWithImpl(this._self, this._then);

  final _UserAddressRequestDto _self;
  final $Res Function(_UserAddressRequestDto) _then;

/// Create a copy of UserAddressRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? addressLine = null,Object? ward = null,Object? district = null,Object? city = null,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = freezed,}) {
  return _then(_UserAddressRequestDto(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,addressLine: null == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String,ward: null == ward ? _self.ward : ward // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
