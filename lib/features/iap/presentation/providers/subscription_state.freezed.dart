// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionState {

 bool get isLoading; List<SubscriptionEntity> get availableTiers; SubscriptionEntity? get activeSubscription; PurchaseEntity? get currentPurchase; Failure? get failure; String? get successMessage;
/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateCopyWith<SubscriptionState> get copyWith => _$SubscriptionStateCopyWithImpl<SubscriptionState>(this as SubscriptionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.availableTiers, availableTiers)&&(identical(other.activeSubscription, activeSubscription) || other.activeSubscription == activeSubscription)&&(identical(other.currentPurchase, currentPurchase) || other.currentPurchase == currentPurchase)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(availableTiers),activeSubscription,currentPurchase,failure,successMessage);

@override
String toString() {
  return 'SubscriptionState(isLoading: $isLoading, availableTiers: $availableTiers, activeSubscription: $activeSubscription, currentPurchase: $currentPurchase, failure: $failure, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateCopyWith<$Res>  {
  factory $SubscriptionStateCopyWith(SubscriptionState value, $Res Function(SubscriptionState) _then) = _$SubscriptionStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<SubscriptionEntity> availableTiers, SubscriptionEntity? activeSubscription, PurchaseEntity? currentPurchase, Failure? failure, String? successMessage
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._self, this._then);

  final SubscriptionState _self;
  final $Res Function(SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? availableTiers = null,Object? activeSubscription = freezed,Object? currentPurchase = freezed,Object? failure = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,availableTiers: null == availableTiers ? _self.availableTiers : availableTiers // ignore: cast_nullable_to_non_nullable
as List<SubscriptionEntity>,activeSubscription: freezed == activeSubscription ? _self.activeSubscription : activeSubscription // ignore: cast_nullable_to_non_nullable
as SubscriptionEntity?,currentPurchase: freezed == currentPurchase ? _self.currentPurchase : currentPurchase // ignore: cast_nullable_to_non_nullable
as PurchaseEntity?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SubscriptionState
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


/// Adds pattern-matching-related methods to [SubscriptionState].
extension SubscriptionStatePatterns on SubscriptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionState value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionState value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<SubscriptionEntity> availableTiers,  SubscriptionEntity? activeSubscription,  PurchaseEntity? currentPurchase,  Failure? failure,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.isLoading,_that.availableTiers,_that.activeSubscription,_that.currentPurchase,_that.failure,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<SubscriptionEntity> availableTiers,  SubscriptionEntity? activeSubscription,  PurchaseEntity? currentPurchase,  Failure? failure,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState():
return $default(_that.isLoading,_that.availableTiers,_that.activeSubscription,_that.currentPurchase,_that.failure,_that.successMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<SubscriptionEntity> availableTiers,  SubscriptionEntity? activeSubscription,  PurchaseEntity? currentPurchase,  Failure? failure,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.isLoading,_that.availableTiers,_that.activeSubscription,_that.currentPurchase,_that.failure,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SubscriptionState extends SubscriptionState {
  const _SubscriptionState({this.isLoading = false, final  List<SubscriptionEntity> availableTiers = const [], this.activeSubscription, this.currentPurchase, this.failure, this.successMessage}): _availableTiers = availableTiers,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<SubscriptionEntity> _availableTiers;
@override@JsonKey() List<SubscriptionEntity> get availableTiers {
  if (_availableTiers is EqualUnmodifiableListView) return _availableTiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableTiers);
}

@override final  SubscriptionEntity? activeSubscription;
@override final  PurchaseEntity? currentPurchase;
@override final  Failure? failure;
@override final  String? successMessage;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionStateCopyWith<_SubscriptionState> get copyWith => __$SubscriptionStateCopyWithImpl<_SubscriptionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._availableTiers, _availableTiers)&&(identical(other.activeSubscription, activeSubscription) || other.activeSubscription == activeSubscription)&&(identical(other.currentPurchase, currentPurchase) || other.currentPurchase == currentPurchase)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_availableTiers),activeSubscription,currentPurchase,failure,successMessage);

@override
String toString() {
  return 'SubscriptionState(isLoading: $isLoading, availableTiers: $availableTiers, activeSubscription: $activeSubscription, currentPurchase: $currentPurchase, failure: $failure, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionStateCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory _$SubscriptionStateCopyWith(_SubscriptionState value, $Res Function(_SubscriptionState) _then) = __$SubscriptionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<SubscriptionEntity> availableTiers, SubscriptionEntity? activeSubscription, PurchaseEntity? currentPurchase, Failure? failure, String? successMessage
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$SubscriptionStateCopyWithImpl<$Res>
    implements _$SubscriptionStateCopyWith<$Res> {
  __$SubscriptionStateCopyWithImpl(this._self, this._then);

  final _SubscriptionState _self;
  final $Res Function(_SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? availableTiers = null,Object? activeSubscription = freezed,Object? currentPurchase = freezed,Object? failure = freezed,Object? successMessage = freezed,}) {
  return _then(_SubscriptionState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,availableTiers: null == availableTiers ? _self._availableTiers : availableTiers // ignore: cast_nullable_to_non_nullable
as List<SubscriptionEntity>,activeSubscription: freezed == activeSubscription ? _self.activeSubscription : activeSubscription // ignore: cast_nullable_to_non_nullable
as SubscriptionEntity?,currentPurchase: freezed == currentPurchase ? _self.currentPurchase : currentPurchase // ignore: cast_nullable_to_non_nullable
as PurchaseEntity?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SubscriptionState
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
