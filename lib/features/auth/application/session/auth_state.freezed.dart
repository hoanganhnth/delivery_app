// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthStateInitial value)?  initial,TResult Function( AuthStateUnauthenticated value)?  unauthenticated,TResult Function( AuthStateAuthenticated value)?  authenticated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthStateInitial() when initial != null:
return initial(_that);case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthStateInitial value)  initial,required TResult Function( AuthStateUnauthenticated value)  unauthenticated,required TResult Function( AuthStateAuthenticated value)  authenticated,}){
final _that = this;
switch (_that) {
case AuthStateInitial():
return initial(_that);case AuthStateUnauthenticated():
return unauthenticated(_that);case AuthStateAuthenticated():
return authenticated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthStateInitial value)?  initial,TResult? Function( AuthStateUnauthenticated value)?  unauthenticated,TResult? Function( AuthStateAuthenticated value)?  authenticated,}){
final _that = this;
switch (_that) {
case AuthStateInitial() when initial != null:
return initial(_that);case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( bool isLoginLoading,  bool isRegisterLoading,  Failure? failure)?  unauthenticated,TResult Function( String accessToken,  String refreshToken,  bool isRefreshLoading,  Failure? failure)?  authenticated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthStateInitial() when initial != null:
return initial();case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.isLoginLoading,_that.isRegisterLoading,_that.failure);case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that.accessToken,_that.refreshToken,_that.isRefreshLoading,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( bool isLoginLoading,  bool isRegisterLoading,  Failure? failure)  unauthenticated,required TResult Function( String accessToken,  String refreshToken,  bool isRefreshLoading,  Failure? failure)  authenticated,}) {final _that = this;
switch (_that) {
case AuthStateInitial():
return initial();case AuthStateUnauthenticated():
return unauthenticated(_that.isLoginLoading,_that.isRegisterLoading,_that.failure);case AuthStateAuthenticated():
return authenticated(_that.accessToken,_that.refreshToken,_that.isRefreshLoading,_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( bool isLoginLoading,  bool isRegisterLoading,  Failure? failure)?  unauthenticated,TResult? Function( String accessToken,  String refreshToken,  bool isRefreshLoading,  Failure? failure)?  authenticated,}) {final _that = this;
switch (_that) {
case AuthStateInitial() when initial != null:
return initial();case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.isLoginLoading,_that.isRegisterLoading,_that.failure);case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that.accessToken,_that.refreshToken,_that.isRefreshLoading,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class AuthStateInitial extends AuthState {
  const AuthStateInitial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated({this.isLoginLoading = false, this.isRegisterLoading = false, this.failure}): super._();
  

@JsonKey() final  bool isLoginLoading;
@JsonKey() final  bool isRegisterLoading;
 final  Failure? failure;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateUnauthenticatedCopyWith<AuthStateUnauthenticated> get copyWith => _$AuthStateUnauthenticatedCopyWithImpl<AuthStateUnauthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateUnauthenticated&&(identical(other.isLoginLoading, isLoginLoading) || other.isLoginLoading == isLoginLoading)&&(identical(other.isRegisterLoading, isRegisterLoading) || other.isRegisterLoading == isRegisterLoading)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoginLoading,isRegisterLoading,failure);

@override
String toString() {
  return 'AuthState.unauthenticated(isLoginLoading: $isLoginLoading, isRegisterLoading: $isRegisterLoading, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AuthStateUnauthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthStateUnauthenticatedCopyWith(AuthStateUnauthenticated value, $Res Function(AuthStateUnauthenticated) _then) = _$AuthStateUnauthenticatedCopyWithImpl;
@useResult
$Res call({
 bool isLoginLoading, bool isRegisterLoading, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$AuthStateUnauthenticatedCopyWithImpl<$Res>
    implements $AuthStateUnauthenticatedCopyWith<$Res> {
  _$AuthStateUnauthenticatedCopyWithImpl(this._self, this._then);

  final AuthStateUnauthenticated _self;
  final $Res Function(AuthStateUnauthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isLoginLoading = null,Object? isRegisterLoading = null,Object? failure = freezed,}) {
  return _then(AuthStateUnauthenticated(
isLoginLoading: null == isLoginLoading ? _self.isLoginLoading : isLoginLoading // ignore: cast_nullable_to_non_nullable
as bool,isRegisterLoading: null == isRegisterLoading ? _self.isRegisterLoading : isRegisterLoading // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc


class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated({this.accessToken = '', this.refreshToken = '', this.isRefreshLoading = false, this.failure}): super._();
  

@JsonKey() final  String accessToken;
@JsonKey() final  String refreshToken;
@JsonKey() final  bool isRefreshLoading;
 final  Failure? failure;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateAuthenticatedCopyWith<AuthStateAuthenticated> get copyWith => _$AuthStateAuthenticatedCopyWithImpl<AuthStateAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateAuthenticated&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.isRefreshLoading, isRefreshLoading) || other.isRefreshLoading == isRefreshLoading)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,isRefreshLoading,failure);

@override
String toString() {
  return 'AuthState.authenticated(accessToken: $accessToken, refreshToken: $refreshToken, isRefreshLoading: $isRefreshLoading, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AuthStateAuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthStateAuthenticatedCopyWith(AuthStateAuthenticated value, $Res Function(AuthStateAuthenticated) _then) = _$AuthStateAuthenticatedCopyWithImpl;
@useResult
$Res call({
 String accessToken, String refreshToken, bool isRefreshLoading, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$AuthStateAuthenticatedCopyWithImpl<$Res>
    implements $AuthStateAuthenticatedCopyWith<$Res> {
  _$AuthStateAuthenticatedCopyWithImpl(this._self, this._then);

  final AuthStateAuthenticated _self;
  final $Res Function(AuthStateAuthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? isRefreshLoading = null,Object? failure = freezed,}) {
  return _then(AuthStateAuthenticated(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,isRefreshLoading: null == isRefreshLoading ? _self.isRefreshLoading : isRefreshLoading // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
