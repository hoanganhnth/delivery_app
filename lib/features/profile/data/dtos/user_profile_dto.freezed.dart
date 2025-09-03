// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileDto {

 int? get id; int get authId; String get email; String get role; String? get fullName; String? get phone; String? get dob; String? get avatarUrl; String? get address; String? get createdAtString; String? get updatedAtString;
/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDtoCopyWith<UserProfileDto> get copyWith => _$UserProfileDtoCopyWithImpl<UserProfileDto>(this as UserProfileDto, _$identity);

  /// Serializes this UserProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.createdAtString, createdAtString) || other.createdAtString == createdAtString)&&(identical(other.updatedAtString, updatedAtString) || other.updatedAtString == updatedAtString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authId,email,role,fullName,phone,dob,avatarUrl,address,createdAtString,updatedAtString);

@override
String toString() {
  return 'UserProfileDto(id: $id, authId: $authId, email: $email, role: $role, fullName: $fullName, phone: $phone, dob: $dob, avatarUrl: $avatarUrl, address: $address, createdAtString: $createdAtString, updatedAtString: $updatedAtString)';
}


}

/// @nodoc
abstract mixin class $UserProfileDtoCopyWith<$Res>  {
  factory $UserProfileDtoCopyWith(UserProfileDto value, $Res Function(UserProfileDto) _then) = _$UserProfileDtoCopyWithImpl;
@useResult
$Res call({
 int? id, int authId, String email, String role, String? fullName, String? phone, String? dob, String? avatarUrl, String? address, String? createdAtString, String? updatedAtString
});




}
/// @nodoc
class _$UserProfileDtoCopyWithImpl<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  _$UserProfileDtoCopyWithImpl(this._self, this._then);

  final UserProfileDto _self;
  final $Res Function(UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? authId = null,Object? email = null,Object? role = null,Object? fullName = freezed,Object? phone = freezed,Object? dob = freezed,Object? avatarUrl = freezed,Object? address = freezed,Object? createdAtString = freezed,Object? updatedAtString = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,authId: null == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,createdAtString: freezed == createdAtString ? _self.createdAtString : createdAtString // ignore: cast_nullable_to_non_nullable
as String?,updatedAtString: freezed == updatedAtString ? _self.updatedAtString : updatedAtString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileDto].
extension UserProfileDtoPatterns on UserProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int authId,  String email,  String role,  String? fullName,  String? phone,  String? dob,  String? avatarUrl,  String? address,  String? createdAtString,  String? updatedAtString)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.authId,_that.email,_that.role,_that.fullName,_that.phone,_that.dob,_that.avatarUrl,_that.address,_that.createdAtString,_that.updatedAtString);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int authId,  String email,  String role,  String? fullName,  String? phone,  String? dob,  String? avatarUrl,  String? address,  String? createdAtString,  String? updatedAtString)  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto():
return $default(_that.id,_that.authId,_that.email,_that.role,_that.fullName,_that.phone,_that.dob,_that.avatarUrl,_that.address,_that.createdAtString,_that.updatedAtString);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int authId,  String email,  String role,  String? fullName,  String? phone,  String? dob,  String? avatarUrl,  String? address,  String? createdAtString,  String? updatedAtString)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.authId,_that.email,_that.role,_that.fullName,_that.phone,_that.dob,_that.avatarUrl,_that.address,_that.createdAtString,_that.updatedAtString);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileDto implements UserProfileDto {
  const _UserProfileDto({this.id, required this.authId, required this.email, required this.role, this.fullName, this.phone, this.dob, this.avatarUrl, this.address, this.createdAtString, this.updatedAtString});
  factory _UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);

@override final  int? id;
@override final  int authId;
@override final  String email;
@override final  String role;
@override final  String? fullName;
@override final  String? phone;
@override final  String? dob;
@override final  String? avatarUrl;
@override final  String? address;
@override final  String? createdAtString;
@override final  String? updatedAtString;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDtoCopyWith<_UserProfileDto> get copyWith => __$UserProfileDtoCopyWithImpl<_UserProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.createdAtString, createdAtString) || other.createdAtString == createdAtString)&&(identical(other.updatedAtString, updatedAtString) || other.updatedAtString == updatedAtString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authId,email,role,fullName,phone,dob,avatarUrl,address,createdAtString,updatedAtString);

@override
String toString() {
  return 'UserProfileDto(id: $id, authId: $authId, email: $email, role: $role, fullName: $fullName, phone: $phone, dob: $dob, avatarUrl: $avatarUrl, address: $address, createdAtString: $createdAtString, updatedAtString: $updatedAtString)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDtoCopyWith<$Res> implements $UserProfileDtoCopyWith<$Res> {
  factory _$UserProfileDtoCopyWith(_UserProfileDto value, $Res Function(_UserProfileDto) _then) = __$UserProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 int? id, int authId, String email, String role, String? fullName, String? phone, String? dob, String? avatarUrl, String? address, String? createdAtString, String? updatedAtString
});




}
/// @nodoc
class __$UserProfileDtoCopyWithImpl<$Res>
    implements _$UserProfileDtoCopyWith<$Res> {
  __$UserProfileDtoCopyWithImpl(this._self, this._then);

  final _UserProfileDto _self;
  final $Res Function(_UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? authId = null,Object? email = null,Object? role = null,Object? fullName = freezed,Object? phone = freezed,Object? dob = freezed,Object? avatarUrl = freezed,Object? address = freezed,Object? createdAtString = freezed,Object? updatedAtString = freezed,}) {
  return _then(_UserProfileDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,authId: null == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,createdAtString: freezed == createdAtString ? _self.createdAtString : createdAtString // ignore: cast_nullable_to_non_nullable
as String?,updatedAtString: freezed == updatedAtString ? _self.updatedAtString : updatedAtString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
