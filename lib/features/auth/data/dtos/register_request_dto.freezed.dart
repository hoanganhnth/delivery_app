// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterRequestDto {

 String get email; String get password; String? get name; String? get role;
/// Create a copy of RegisterRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterRequestDtoCopyWith<RegisterRequestDto> get copyWith => _$RegisterRequestDtoCopyWithImpl<RegisterRequestDto>(this as RegisterRequestDto, _$identity);

  /// Serializes this RegisterRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterRequestDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,name,role);

@override
String toString() {
  return 'RegisterRequestDto(email: $email, password: $password, name: $name, role: $role)';
}


}

/// @nodoc
abstract mixin class $RegisterRequestDtoCopyWith<$Res>  {
  factory $RegisterRequestDtoCopyWith(RegisterRequestDto value, $Res Function(RegisterRequestDto) _then) = _$RegisterRequestDtoCopyWithImpl;
@useResult
$Res call({
 String email, String password, String? name, String? role
});




}
/// @nodoc
class _$RegisterRequestDtoCopyWithImpl<$Res>
    implements $RegisterRequestDtoCopyWith<$Res> {
  _$RegisterRequestDtoCopyWithImpl(this._self, this._then);

  final RegisterRequestDto _self;
  final $Res Function(RegisterRequestDto) _then;

/// Create a copy of RegisterRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? name = freezed,Object? role = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterRequestDto].
extension RegisterRequestDtoPatterns on RegisterRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _RegisterRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  String? name,  String? role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterRequestDto() when $default != null:
return $default(_that.email,_that.password,_that.name,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  String? name,  String? role)  $default,) {final _that = this;
switch (_that) {
case _RegisterRequestDto():
return $default(_that.email,_that.password,_that.name,_that.role);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  String? name,  String? role)?  $default,) {final _that = this;
switch (_that) {
case _RegisterRequestDto() when $default != null:
return $default(_that.email,_that.password,_that.name,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterRequestDto implements RegisterRequestDto {
  const _RegisterRequestDto({required this.email, required this.password, this.name, this.role});
  factory _RegisterRequestDto.fromJson(Map<String, dynamic> json) => _$RegisterRequestDtoFromJson(json);

@override final  String email;
@override final  String password;
@override final  String? name;
@override final  String? role;

/// Create a copy of RegisterRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterRequestDtoCopyWith<_RegisterRequestDto> get copyWith => __$RegisterRequestDtoCopyWithImpl<_RegisterRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterRequestDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,name,role);

@override
String toString() {
  return 'RegisterRequestDto(email: $email, password: $password, name: $name, role: $role)';
}


}

/// @nodoc
abstract mixin class _$RegisterRequestDtoCopyWith<$Res> implements $RegisterRequestDtoCopyWith<$Res> {
  factory _$RegisterRequestDtoCopyWith(_RegisterRequestDto value, $Res Function(_RegisterRequestDto) _then) = __$RegisterRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String? name, String? role
});




}
/// @nodoc
class __$RegisterRequestDtoCopyWithImpl<$Res>
    implements _$RegisterRequestDtoCopyWith<$Res> {
  __$RegisterRequestDtoCopyWithImpl(this._self, this._then);

  final _RegisterRequestDto _self;
  final $Res Function(_RegisterRequestDto) _then;

/// Create a copy of RegisterRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? name = freezed,Object? role = freezed,}) {
  return _then(_RegisterRequestDto(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AuthRegistrationDataDto {

 int get authId; String get email; String get role; String get provisioningToken;
/// Create a copy of AuthRegistrationDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthRegistrationDataDtoCopyWith<AuthRegistrationDataDto> get copyWith => _$AuthRegistrationDataDtoCopyWithImpl<AuthRegistrationDataDto>(this as AuthRegistrationDataDto, _$identity);

  /// Serializes this AuthRegistrationDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthRegistrationDataDto&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.provisioningToken, provisioningToken) || other.provisioningToken == provisioningToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authId,email,role,provisioningToken);

@override
String toString() {
  return 'AuthRegistrationDataDto(authId: $authId, email: $email, role: $role, provisioningToken: $provisioningToken)';
}


}

/// @nodoc
abstract mixin class $AuthRegistrationDataDtoCopyWith<$Res>  {
  factory $AuthRegistrationDataDtoCopyWith(AuthRegistrationDataDto value, $Res Function(AuthRegistrationDataDto) _then) = _$AuthRegistrationDataDtoCopyWithImpl;
@useResult
$Res call({
 int authId, String email, String role, String provisioningToken
});




}
/// @nodoc
class _$AuthRegistrationDataDtoCopyWithImpl<$Res>
    implements $AuthRegistrationDataDtoCopyWith<$Res> {
  _$AuthRegistrationDataDtoCopyWithImpl(this._self, this._then);

  final AuthRegistrationDataDto _self;
  final $Res Function(AuthRegistrationDataDto) _then;

/// Create a copy of AuthRegistrationDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authId = null,Object? email = null,Object? role = null,Object? provisioningToken = null,}) {
  return _then(_self.copyWith(
authId: null == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,provisioningToken: null == provisioningToken ? _self.provisioningToken : provisioningToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthRegistrationDataDto].
extension AuthRegistrationDataDtoPatterns on AuthRegistrationDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthRegistrationDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthRegistrationDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthRegistrationDataDto value)  $default,){
final _that = this;
switch (_that) {
case _AuthRegistrationDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthRegistrationDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _AuthRegistrationDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int authId,  String email,  String role,  String provisioningToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthRegistrationDataDto() when $default != null:
return $default(_that.authId,_that.email,_that.role,_that.provisioningToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int authId,  String email,  String role,  String provisioningToken)  $default,) {final _that = this;
switch (_that) {
case _AuthRegistrationDataDto():
return $default(_that.authId,_that.email,_that.role,_that.provisioningToken);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int authId,  String email,  String role,  String provisioningToken)?  $default,) {final _that = this;
switch (_that) {
case _AuthRegistrationDataDto() when $default != null:
return $default(_that.authId,_that.email,_that.role,_that.provisioningToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthRegistrationDataDto implements AuthRegistrationDataDto {
  const _AuthRegistrationDataDto({required this.authId, required this.email, required this.role, required this.provisioningToken});
  factory _AuthRegistrationDataDto.fromJson(Map<String, dynamic> json) => _$AuthRegistrationDataDtoFromJson(json);

@override final  int authId;
@override final  String email;
@override final  String role;
@override final  String provisioningToken;

/// Create a copy of AuthRegistrationDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthRegistrationDataDtoCopyWith<_AuthRegistrationDataDto> get copyWith => __$AuthRegistrationDataDtoCopyWithImpl<_AuthRegistrationDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthRegistrationDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthRegistrationDataDto&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.provisioningToken, provisioningToken) || other.provisioningToken == provisioningToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authId,email,role,provisioningToken);

@override
String toString() {
  return 'AuthRegistrationDataDto(authId: $authId, email: $email, role: $role, provisioningToken: $provisioningToken)';
}


}

/// @nodoc
abstract mixin class _$AuthRegistrationDataDtoCopyWith<$Res> implements $AuthRegistrationDataDtoCopyWith<$Res> {
  factory _$AuthRegistrationDataDtoCopyWith(_AuthRegistrationDataDto value, $Res Function(_AuthRegistrationDataDto) _then) = __$AuthRegistrationDataDtoCopyWithImpl;
@override @useResult
$Res call({
 int authId, String email, String role, String provisioningToken
});




}
/// @nodoc
class __$AuthRegistrationDataDtoCopyWithImpl<$Res>
    implements _$AuthRegistrationDataDtoCopyWith<$Res> {
  __$AuthRegistrationDataDtoCopyWithImpl(this._self, this._then);

  final _AuthRegistrationDataDto _self;
  final $Res Function(_AuthRegistrationDataDto) _then;

/// Create a copy of AuthRegistrationDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authId = null,Object? email = null,Object? role = null,Object? provisioningToken = null,}) {
  return _then(_AuthRegistrationDataDto(
authId: null == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,provisioningToken: null == provisioningToken ? _self.provisioningToken : provisioningToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UserRegistrationRequestDto {

 String get provisioningToken; String? get fullName;
/// Create a copy of UserRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRegistrationRequestDtoCopyWith<UserRegistrationRequestDto> get copyWith => _$UserRegistrationRequestDtoCopyWithImpl<UserRegistrationRequestDto>(this as UserRegistrationRequestDto, _$identity);

  /// Serializes this UserRegistrationRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRegistrationRequestDto&&(identical(other.provisioningToken, provisioningToken) || other.provisioningToken == provisioningToken)&&(identical(other.fullName, fullName) || other.fullName == fullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provisioningToken,fullName);

@override
String toString() {
  return 'UserRegistrationRequestDto(provisioningToken: $provisioningToken, fullName: $fullName)';
}


}

/// @nodoc
abstract mixin class $UserRegistrationRequestDtoCopyWith<$Res>  {
  factory $UserRegistrationRequestDtoCopyWith(UserRegistrationRequestDto value, $Res Function(UserRegistrationRequestDto) _then) = _$UserRegistrationRequestDtoCopyWithImpl;
@useResult
$Res call({
 String provisioningToken, String? fullName
});




}
/// @nodoc
class _$UserRegistrationRequestDtoCopyWithImpl<$Res>
    implements $UserRegistrationRequestDtoCopyWith<$Res> {
  _$UserRegistrationRequestDtoCopyWithImpl(this._self, this._then);

  final UserRegistrationRequestDto _self;
  final $Res Function(UserRegistrationRequestDto) _then;

/// Create a copy of UserRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provisioningToken = null,Object? fullName = freezed,}) {
  return _then(_self.copyWith(
provisioningToken: null == provisioningToken ? _self.provisioningToken : provisioningToken // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRegistrationRequestDto].
extension UserRegistrationRequestDtoPatterns on UserRegistrationRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRegistrationRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRegistrationRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRegistrationRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _UserRegistrationRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRegistrationRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserRegistrationRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provisioningToken,  String? fullName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRegistrationRequestDto() when $default != null:
return $default(_that.provisioningToken,_that.fullName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provisioningToken,  String? fullName)  $default,) {final _that = this;
switch (_that) {
case _UserRegistrationRequestDto():
return $default(_that.provisioningToken,_that.fullName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provisioningToken,  String? fullName)?  $default,) {final _that = this;
switch (_that) {
case _UserRegistrationRequestDto() when $default != null:
return $default(_that.provisioningToken,_that.fullName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRegistrationRequestDto implements UserRegistrationRequestDto {
  const _UserRegistrationRequestDto({required this.provisioningToken, this.fullName});
  factory _UserRegistrationRequestDto.fromJson(Map<String, dynamic> json) => _$UserRegistrationRequestDtoFromJson(json);

@override final  String provisioningToken;
@override final  String? fullName;

/// Create a copy of UserRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRegistrationRequestDtoCopyWith<_UserRegistrationRequestDto> get copyWith => __$UserRegistrationRequestDtoCopyWithImpl<_UserRegistrationRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRegistrationRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRegistrationRequestDto&&(identical(other.provisioningToken, provisioningToken) || other.provisioningToken == provisioningToken)&&(identical(other.fullName, fullName) || other.fullName == fullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provisioningToken,fullName);

@override
String toString() {
  return 'UserRegistrationRequestDto(provisioningToken: $provisioningToken, fullName: $fullName)';
}


}

/// @nodoc
abstract mixin class _$UserRegistrationRequestDtoCopyWith<$Res> implements $UserRegistrationRequestDtoCopyWith<$Res> {
  factory _$UserRegistrationRequestDtoCopyWith(_UserRegistrationRequestDto value, $Res Function(_UserRegistrationRequestDto) _then) = __$UserRegistrationRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String provisioningToken, String? fullName
});




}
/// @nodoc
class __$UserRegistrationRequestDtoCopyWithImpl<$Res>
    implements _$UserRegistrationRequestDtoCopyWith<$Res> {
  __$UserRegistrationRequestDtoCopyWithImpl(this._self, this._then);

  final _UserRegistrationRequestDto _self;
  final $Res Function(_UserRegistrationRequestDto) _then;

/// Create a copy of UserRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provisioningToken = null,Object? fullName = freezed,}) {
  return _then(_UserRegistrationRequestDto(
provisioningToken: null == provisioningToken ? _self.provisioningToken : provisioningToken // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserRegistrationDataDto {

 int get id; int get authId; String get email; String get role; String? get fullName;
/// Create a copy of UserRegistrationDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRegistrationDataDtoCopyWith<UserRegistrationDataDto> get copyWith => _$UserRegistrationDataDtoCopyWithImpl<UserRegistrationDataDto>(this as UserRegistrationDataDto, _$identity);

  /// Serializes this UserRegistrationDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRegistrationDataDto&&(identical(other.id, id) || other.id == id)&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authId,email,role,fullName);

@override
String toString() {
  return 'UserRegistrationDataDto(id: $id, authId: $authId, email: $email, role: $role, fullName: $fullName)';
}


}

/// @nodoc
abstract mixin class $UserRegistrationDataDtoCopyWith<$Res>  {
  factory $UserRegistrationDataDtoCopyWith(UserRegistrationDataDto value, $Res Function(UserRegistrationDataDto) _then) = _$UserRegistrationDataDtoCopyWithImpl;
@useResult
$Res call({
 int id, int authId, String email, String role, String? fullName
});




}
/// @nodoc
class _$UserRegistrationDataDtoCopyWithImpl<$Res>
    implements $UserRegistrationDataDtoCopyWith<$Res> {
  _$UserRegistrationDataDtoCopyWithImpl(this._self, this._then);

  final UserRegistrationDataDto _self;
  final $Res Function(UserRegistrationDataDto) _then;

/// Create a copy of UserRegistrationDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authId = null,Object? email = null,Object? role = null,Object? fullName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,authId: null == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRegistrationDataDto].
extension UserRegistrationDataDtoPatterns on UserRegistrationDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRegistrationDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRegistrationDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRegistrationDataDto value)  $default,){
final _that = this;
switch (_that) {
case _UserRegistrationDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRegistrationDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserRegistrationDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int authId,  String email,  String role,  String? fullName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRegistrationDataDto() when $default != null:
return $default(_that.id,_that.authId,_that.email,_that.role,_that.fullName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int authId,  String email,  String role,  String? fullName)  $default,) {final _that = this;
switch (_that) {
case _UserRegistrationDataDto():
return $default(_that.id,_that.authId,_that.email,_that.role,_that.fullName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int authId,  String email,  String role,  String? fullName)?  $default,) {final _that = this;
switch (_that) {
case _UserRegistrationDataDto() when $default != null:
return $default(_that.id,_that.authId,_that.email,_that.role,_that.fullName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRegistrationDataDto implements UserRegistrationDataDto {
  const _UserRegistrationDataDto({required this.id, required this.authId, required this.email, required this.role, this.fullName});
  factory _UserRegistrationDataDto.fromJson(Map<String, dynamic> json) => _$UserRegistrationDataDtoFromJson(json);

@override final  int id;
@override final  int authId;
@override final  String email;
@override final  String role;
@override final  String? fullName;

/// Create a copy of UserRegistrationDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRegistrationDataDtoCopyWith<_UserRegistrationDataDto> get copyWith => __$UserRegistrationDataDtoCopyWithImpl<_UserRegistrationDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRegistrationDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRegistrationDataDto&&(identical(other.id, id) || other.id == id)&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authId,email,role,fullName);

@override
String toString() {
  return 'UserRegistrationDataDto(id: $id, authId: $authId, email: $email, role: $role, fullName: $fullName)';
}


}

/// @nodoc
abstract mixin class _$UserRegistrationDataDtoCopyWith<$Res> implements $UserRegistrationDataDtoCopyWith<$Res> {
  factory _$UserRegistrationDataDtoCopyWith(_UserRegistrationDataDto value, $Res Function(_UserRegistrationDataDto) _then) = __$UserRegistrationDataDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int authId, String email, String role, String? fullName
});




}
/// @nodoc
class __$UserRegistrationDataDtoCopyWithImpl<$Res>
    implements _$UserRegistrationDataDtoCopyWith<$Res> {
  __$UserRegistrationDataDtoCopyWithImpl(this._self, this._then);

  final _UserRegistrationDataDto _self;
  final $Res Function(_UserRegistrationDataDto) _then;

/// Create a copy of UserRegistrationDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authId = null,Object? email = null,Object? role = null,Object? fullName = freezed,}) {
  return _then(_UserRegistrationDataDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,authId: null == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
