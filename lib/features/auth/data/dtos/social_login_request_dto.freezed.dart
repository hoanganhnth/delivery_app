// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_login_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialLoginRequestDto {

 String get provider; String get token; String? get role; String? get deviceId; String? get deviceName; String? get deviceType; String? get ipAddress;
/// Create a copy of SocialLoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLoginRequestDtoCopyWith<SocialLoginRequestDto> get copyWith => _$SocialLoginRequestDtoCopyWithImpl<SocialLoginRequestDto>(this as SocialLoginRequestDto, _$identity);

  /// Serializes this SocialLoginRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLoginRequestDto&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.token, token) || other.token == token)&&(identical(other.role, role) || other.role == role)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,token,role,deviceId,deviceName,deviceType,ipAddress);

@override
String toString() {
  return 'SocialLoginRequestDto(provider: $provider, token: $token, role: $role, deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType, ipAddress: $ipAddress)';
}


}

/// @nodoc
abstract mixin class $SocialLoginRequestDtoCopyWith<$Res>  {
  factory $SocialLoginRequestDtoCopyWith(SocialLoginRequestDto value, $Res Function(SocialLoginRequestDto) _then) = _$SocialLoginRequestDtoCopyWithImpl;
@useResult
$Res call({
 String provider, String token, String? role, String? deviceId, String? deviceName, String? deviceType, String? ipAddress
});




}
/// @nodoc
class _$SocialLoginRequestDtoCopyWithImpl<$Res>
    implements $SocialLoginRequestDtoCopyWith<$Res> {
  _$SocialLoginRequestDtoCopyWithImpl(this._self, this._then);

  final SocialLoginRequestDto _self;
  final $Res Function(SocialLoginRequestDto) _then;

/// Create a copy of SocialLoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? token = null,Object? role = freezed,Object? deviceId = freezed,Object? deviceName = freezed,Object? deviceType = freezed,Object? ipAddress = freezed,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,deviceName: freezed == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String?,deviceType: freezed == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialLoginRequestDto].
extension SocialLoginRequestDtoPatterns on SocialLoginRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialLoginRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialLoginRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialLoginRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _SocialLoginRequestDto():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialLoginRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _SocialLoginRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provider,  String token,  String? role,  String? deviceId,  String? deviceName,  String? deviceType,  String? ipAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialLoginRequestDto() when $default != null:
return $default(_that.provider,_that.token,_that.role,_that.deviceId,_that.deviceName,_that.deviceType,_that.ipAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provider,  String token,  String? role,  String? deviceId,  String? deviceName,  String? deviceType,  String? ipAddress)  $default,) {final _that = this;
switch (_that) {
case _SocialLoginRequestDto():
return $default(_that.provider,_that.token,_that.role,_that.deviceId,_that.deviceName,_that.deviceType,_that.ipAddress);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provider,  String token,  String? role,  String? deviceId,  String? deviceName,  String? deviceType,  String? ipAddress)?  $default,) {final _that = this;
switch (_that) {
case _SocialLoginRequestDto() when $default != null:
return $default(_that.provider,_that.token,_that.role,_that.deviceId,_that.deviceName,_that.deviceType,_that.ipAddress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialLoginRequestDto implements SocialLoginRequestDto {
  const _SocialLoginRequestDto({required this.provider, required this.token, this.role, this.deviceId, this.deviceName, this.deviceType, this.ipAddress});
  factory _SocialLoginRequestDto.fromJson(Map<String, dynamic> json) => _$SocialLoginRequestDtoFromJson(json);

@override final  String provider;
@override final  String token;
@override final  String? role;
@override final  String? deviceId;
@override final  String? deviceName;
@override final  String? deviceType;
@override final  String? ipAddress;

/// Create a copy of SocialLoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLoginRequestDtoCopyWith<_SocialLoginRequestDto> get copyWith => __$SocialLoginRequestDtoCopyWithImpl<_SocialLoginRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialLoginRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLoginRequestDto&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.token, token) || other.token == token)&&(identical(other.role, role) || other.role == role)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,token,role,deviceId,deviceName,deviceType,ipAddress);

@override
String toString() {
  return 'SocialLoginRequestDto(provider: $provider, token: $token, role: $role, deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType, ipAddress: $ipAddress)';
}


}

/// @nodoc
abstract mixin class _$SocialLoginRequestDtoCopyWith<$Res> implements $SocialLoginRequestDtoCopyWith<$Res> {
  factory _$SocialLoginRequestDtoCopyWith(_SocialLoginRequestDto value, $Res Function(_SocialLoginRequestDto) _then) = __$SocialLoginRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String provider, String token, String? role, String? deviceId, String? deviceName, String? deviceType, String? ipAddress
});




}
/// @nodoc
class __$SocialLoginRequestDtoCopyWithImpl<$Res>
    implements _$SocialLoginRequestDtoCopyWith<$Res> {
  __$SocialLoginRequestDtoCopyWithImpl(this._self, this._then);

  final _SocialLoginRequestDto _self;
  final $Res Function(_SocialLoginRequestDto) _then;

/// Create a copy of SocialLoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? token = null,Object? role = freezed,Object? deviceId = freezed,Object? deviceName = freezed,Object? deviceType = freezed,Object? ipAddress = freezed,}) {
  return _then(_SocialLoginRequestDto(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,deviceName: freezed == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String?,deviceType: freezed == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
