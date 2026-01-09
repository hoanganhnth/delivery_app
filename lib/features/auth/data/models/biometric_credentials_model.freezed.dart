// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biometric_credentials_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiometricCredentialsModel {

 String get email; String get encryptedPassword; DateTime get savedAt;
/// Create a copy of BiometricCredentialsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiometricCredentialsModelCopyWith<BiometricCredentialsModel> get copyWith => _$BiometricCredentialsModelCopyWithImpl<BiometricCredentialsModel>(this as BiometricCredentialsModel, _$identity);

  /// Serializes this BiometricCredentialsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiometricCredentialsModel&&(identical(other.email, email) || other.email == email)&&(identical(other.encryptedPassword, encryptedPassword) || other.encryptedPassword == encryptedPassword)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,encryptedPassword,savedAt);

@override
String toString() {
  return 'BiometricCredentialsModel(email: $email, encryptedPassword: $encryptedPassword, savedAt: $savedAt)';
}


}

/// @nodoc
abstract mixin class $BiometricCredentialsModelCopyWith<$Res>  {
  factory $BiometricCredentialsModelCopyWith(BiometricCredentialsModel value, $Res Function(BiometricCredentialsModel) _then) = _$BiometricCredentialsModelCopyWithImpl;
@useResult
$Res call({
 String email, String encryptedPassword, DateTime savedAt
});




}
/// @nodoc
class _$BiometricCredentialsModelCopyWithImpl<$Res>
    implements $BiometricCredentialsModelCopyWith<$Res> {
  _$BiometricCredentialsModelCopyWithImpl(this._self, this._then);

  final BiometricCredentialsModel _self;
  final $Res Function(BiometricCredentialsModel) _then;

/// Create a copy of BiometricCredentialsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? encryptedPassword = null,Object? savedAt = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,encryptedPassword: null == encryptedPassword ? _self.encryptedPassword : encryptedPassword // ignore: cast_nullable_to_non_nullable
as String,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BiometricCredentialsModel].
extension BiometricCredentialsModelPatterns on BiometricCredentialsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiometricCredentialsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiometricCredentialsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiometricCredentialsModel value)  $default,){
final _that = this;
switch (_that) {
case _BiometricCredentialsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiometricCredentialsModel value)?  $default,){
final _that = this;
switch (_that) {
case _BiometricCredentialsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String encryptedPassword,  DateTime savedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiometricCredentialsModel() when $default != null:
return $default(_that.email,_that.encryptedPassword,_that.savedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String encryptedPassword,  DateTime savedAt)  $default,) {final _that = this;
switch (_that) {
case _BiometricCredentialsModel():
return $default(_that.email,_that.encryptedPassword,_that.savedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String encryptedPassword,  DateTime savedAt)?  $default,) {final _that = this;
switch (_that) {
case _BiometricCredentialsModel() when $default != null:
return $default(_that.email,_that.encryptedPassword,_that.savedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiometricCredentialsModel extends BiometricCredentialsModel {
  const _BiometricCredentialsModel({required this.email, required this.encryptedPassword, required this.savedAt}): super._();
  factory _BiometricCredentialsModel.fromJson(Map<String, dynamic> json) => _$BiometricCredentialsModelFromJson(json);

@override final  String email;
@override final  String encryptedPassword;
@override final  DateTime savedAt;

/// Create a copy of BiometricCredentialsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiometricCredentialsModelCopyWith<_BiometricCredentialsModel> get copyWith => __$BiometricCredentialsModelCopyWithImpl<_BiometricCredentialsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiometricCredentialsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiometricCredentialsModel&&(identical(other.email, email) || other.email == email)&&(identical(other.encryptedPassword, encryptedPassword) || other.encryptedPassword == encryptedPassword)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,encryptedPassword,savedAt);

@override
String toString() {
  return 'BiometricCredentialsModel(email: $email, encryptedPassword: $encryptedPassword, savedAt: $savedAt)';
}


}

/// @nodoc
abstract mixin class _$BiometricCredentialsModelCopyWith<$Res> implements $BiometricCredentialsModelCopyWith<$Res> {
  factory _$BiometricCredentialsModelCopyWith(_BiometricCredentialsModel value, $Res Function(_BiometricCredentialsModel) _then) = __$BiometricCredentialsModelCopyWithImpl;
@override @useResult
$Res call({
 String email, String encryptedPassword, DateTime savedAt
});




}
/// @nodoc
class __$BiometricCredentialsModelCopyWithImpl<$Res>
    implements _$BiometricCredentialsModelCopyWith<$Res> {
  __$BiometricCredentialsModelCopyWithImpl(this._self, this._then);

  final _BiometricCredentialsModel _self;
  final $Res Function(_BiometricCredentialsModel) _then;

/// Create a copy of BiometricCredentialsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? encryptedPassword = null,Object? savedAt = null,}) {
  return _then(_BiometricCredentialsModel(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,encryptedPassword: null == encryptedPassword ? _self.encryptedPassword : encryptedPassword // ignore: cast_nullable_to_non_nullable
as String,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
