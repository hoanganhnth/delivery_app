// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumable_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsumableState {

 bool get isLoading; List<ConsumableEntity> get products; int get creditsBalance; List<ConsumableEntity> get userVouchers; Failure? get failure; String? get successMessage;
/// Create a copy of ConsumableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsumableStateCopyWith<ConsumableState> get copyWith => _$ConsumableStateCopyWithImpl<ConsumableState>(this as ConsumableState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsumableState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.creditsBalance, creditsBalance) || other.creditsBalance == creditsBalance)&&const DeepCollectionEquality().equals(other.userVouchers, userVouchers)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(products),creditsBalance,const DeepCollectionEquality().hash(userVouchers),failure,successMessage);

@override
String toString() {
  return 'ConsumableState(isLoading: $isLoading, products: $products, creditsBalance: $creditsBalance, userVouchers: $userVouchers, failure: $failure, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $ConsumableStateCopyWith<$Res>  {
  factory $ConsumableStateCopyWith(ConsumableState value, $Res Function(ConsumableState) _then) = _$ConsumableStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ConsumableEntity> products, int creditsBalance, List<ConsumableEntity> userVouchers, Failure? failure, String? successMessage
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ConsumableStateCopyWithImpl<$Res>
    implements $ConsumableStateCopyWith<$Res> {
  _$ConsumableStateCopyWithImpl(this._self, this._then);

  final ConsumableState _self;
  final $Res Function(ConsumableState) _then;

/// Create a copy of ConsumableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? products = null,Object? creditsBalance = null,Object? userVouchers = null,Object? failure = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ConsumableEntity>,creditsBalance: null == creditsBalance ? _self.creditsBalance : creditsBalance // ignore: cast_nullable_to_non_nullable
as int,userVouchers: null == userVouchers ? _self.userVouchers : userVouchers // ignore: cast_nullable_to_non_nullable
as List<ConsumableEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ConsumableState
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


/// Adds pattern-matching-related methods to [ConsumableState].
extension ConsumableStatePatterns on ConsumableState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsumableState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsumableState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsumableState value)  $default,){
final _that = this;
switch (_that) {
case _ConsumableState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsumableState value)?  $default,){
final _that = this;
switch (_that) {
case _ConsumableState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<ConsumableEntity> products,  int creditsBalance,  List<ConsumableEntity> userVouchers,  Failure? failure,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsumableState() when $default != null:
return $default(_that.isLoading,_that.products,_that.creditsBalance,_that.userVouchers,_that.failure,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<ConsumableEntity> products,  int creditsBalance,  List<ConsumableEntity> userVouchers,  Failure? failure,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _ConsumableState():
return $default(_that.isLoading,_that.products,_that.creditsBalance,_that.userVouchers,_that.failure,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<ConsumableEntity> products,  int creditsBalance,  List<ConsumableEntity> userVouchers,  Failure? failure,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _ConsumableState() when $default != null:
return $default(_that.isLoading,_that.products,_that.creditsBalance,_that.userVouchers,_that.failure,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ConsumableState extends ConsumableState {
  const _ConsumableState({this.isLoading = false, final  List<ConsumableEntity> products = const [], this.creditsBalance = 0, final  List<ConsumableEntity> userVouchers = const [], this.failure, this.successMessage}): _products = products,_userVouchers = userVouchers,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<ConsumableEntity> _products;
@override@JsonKey() List<ConsumableEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override@JsonKey() final  int creditsBalance;
 final  List<ConsumableEntity> _userVouchers;
@override@JsonKey() List<ConsumableEntity> get userVouchers {
  if (_userVouchers is EqualUnmodifiableListView) return _userVouchers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userVouchers);
}

@override final  Failure? failure;
@override final  String? successMessage;

/// Create a copy of ConsumableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsumableStateCopyWith<_ConsumableState> get copyWith => __$ConsumableStateCopyWithImpl<_ConsumableState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsumableState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.creditsBalance, creditsBalance) || other.creditsBalance == creditsBalance)&&const DeepCollectionEquality().equals(other._userVouchers, _userVouchers)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_products),creditsBalance,const DeepCollectionEquality().hash(_userVouchers),failure,successMessage);

@override
String toString() {
  return 'ConsumableState(isLoading: $isLoading, products: $products, creditsBalance: $creditsBalance, userVouchers: $userVouchers, failure: $failure, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$ConsumableStateCopyWith<$Res> implements $ConsumableStateCopyWith<$Res> {
  factory _$ConsumableStateCopyWith(_ConsumableState value, $Res Function(_ConsumableState) _then) = __$ConsumableStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ConsumableEntity> products, int creditsBalance, List<ConsumableEntity> userVouchers, Failure? failure, String? successMessage
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ConsumableStateCopyWithImpl<$Res>
    implements _$ConsumableStateCopyWith<$Res> {
  __$ConsumableStateCopyWithImpl(this._self, this._then);

  final _ConsumableState _self;
  final $Res Function(_ConsumableState) _then;

/// Create a copy of ConsumableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? products = null,Object? creditsBalance = null,Object? userVouchers = null,Object? failure = freezed,Object? successMessage = freezed,}) {
  return _then(_ConsumableState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ConsumableEntity>,creditsBalance: null == creditsBalance ? _self.creditsBalance : creditsBalance // ignore: cast_nullable_to_non_nullable
as int,userVouchers: null == userVouchers ? _self._userVouchers : userVouchers // ignore: cast_nullable_to_non_nullable
as List<ConsumableEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ConsumableState
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
