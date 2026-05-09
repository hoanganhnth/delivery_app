// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipper_location_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShipperLocationState {

 bool get isLoading; bool get isTracking; bool get isConnected; ShipperLocationEntity? get currentLocation; int? get trackingShipperId; Failure? get failure;
/// Create a copy of ShipperLocationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipperLocationStateCopyWith<ShipperLocationState> get copyWith => _$ShipperLocationStateCopyWithImpl<ShipperLocationState>(this as ShipperLocationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipperLocationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isTracking, isTracking) || other.isTracking == isTracking)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.currentLocation, currentLocation) || other.currentLocation == currentLocation)&&(identical(other.trackingShipperId, trackingShipperId) || other.trackingShipperId == trackingShipperId)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isTracking,isConnected,currentLocation,trackingShipperId,failure);

@override
String toString() {
  return 'ShipperLocationState(isLoading: $isLoading, isTracking: $isTracking, isConnected: $isConnected, currentLocation: $currentLocation, trackingShipperId: $trackingShipperId, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ShipperLocationStateCopyWith<$Res>  {
  factory $ShipperLocationStateCopyWith(ShipperLocationState value, $Res Function(ShipperLocationState) _then) = _$ShipperLocationStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isTracking, bool isConnected, ShipperLocationEntity? currentLocation, int? trackingShipperId, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ShipperLocationStateCopyWithImpl<$Res>
    implements $ShipperLocationStateCopyWith<$Res> {
  _$ShipperLocationStateCopyWithImpl(this._self, this._then);

  final ShipperLocationState _self;
  final $Res Function(ShipperLocationState) _then;

/// Create a copy of ShipperLocationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isTracking = null,Object? isConnected = null,Object? currentLocation = freezed,Object? trackingShipperId = freezed,Object? failure = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isTracking: null == isTracking ? _self.isTracking : isTracking // ignore: cast_nullable_to_non_nullable
as bool,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,currentLocation: freezed == currentLocation ? _self.currentLocation : currentLocation // ignore: cast_nullable_to_non_nullable
as ShipperLocationEntity?,trackingShipperId: freezed == trackingShipperId ? _self.trackingShipperId : trackingShipperId // ignore: cast_nullable_to_non_nullable
as int?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of ShipperLocationState
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


/// Adds pattern-matching-related methods to [ShipperLocationState].
extension ShipperLocationStatePatterns on ShipperLocationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipperLocationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipperLocationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipperLocationState value)  $default,){
final _that = this;
switch (_that) {
case _ShipperLocationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipperLocationState value)?  $default,){
final _that = this;
switch (_that) {
case _ShipperLocationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isTracking,  bool isConnected,  ShipperLocationEntity? currentLocation,  int? trackingShipperId,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipperLocationState() when $default != null:
return $default(_that.isLoading,_that.isTracking,_that.isConnected,_that.currentLocation,_that.trackingShipperId,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isTracking,  bool isConnected,  ShipperLocationEntity? currentLocation,  int? trackingShipperId,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _ShipperLocationState():
return $default(_that.isLoading,_that.isTracking,_that.isConnected,_that.currentLocation,_that.trackingShipperId,_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isTracking,  bool isConnected,  ShipperLocationEntity? currentLocation,  int? trackingShipperId,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _ShipperLocationState() when $default != null:
return $default(_that.isLoading,_that.isTracking,_that.isConnected,_that.currentLocation,_that.trackingShipperId,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _ShipperLocationState extends ShipperLocationState {
  const _ShipperLocationState({this.isLoading = false, this.isTracking = false, this.isConnected = false, this.currentLocation, this.trackingShipperId, this.failure}): super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isTracking;
@override@JsonKey() final  bool isConnected;
@override final  ShipperLocationEntity? currentLocation;
@override final  int? trackingShipperId;
@override final  Failure? failure;

/// Create a copy of ShipperLocationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipperLocationStateCopyWith<_ShipperLocationState> get copyWith => __$ShipperLocationStateCopyWithImpl<_ShipperLocationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipperLocationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isTracking, isTracking) || other.isTracking == isTracking)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.currentLocation, currentLocation) || other.currentLocation == currentLocation)&&(identical(other.trackingShipperId, trackingShipperId) || other.trackingShipperId == trackingShipperId)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isTracking,isConnected,currentLocation,trackingShipperId,failure);

@override
String toString() {
  return 'ShipperLocationState(isLoading: $isLoading, isTracking: $isTracking, isConnected: $isConnected, currentLocation: $currentLocation, trackingShipperId: $trackingShipperId, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ShipperLocationStateCopyWith<$Res> implements $ShipperLocationStateCopyWith<$Res> {
  factory _$ShipperLocationStateCopyWith(_ShipperLocationState value, $Res Function(_ShipperLocationState) _then) = __$ShipperLocationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isTracking, bool isConnected, ShipperLocationEntity? currentLocation, int? trackingShipperId, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ShipperLocationStateCopyWithImpl<$Res>
    implements _$ShipperLocationStateCopyWith<$Res> {
  __$ShipperLocationStateCopyWithImpl(this._self, this._then);

  final _ShipperLocationState _self;
  final $Res Function(_ShipperLocationState) _then;

/// Create a copy of ShipperLocationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isTracking = null,Object? isConnected = null,Object? currentLocation = freezed,Object? trackingShipperId = freezed,Object? failure = freezed,}) {
  return _then(_ShipperLocationState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isTracking: null == isTracking ? _self.isTracking : isTracking // ignore: cast_nullable_to_non_nullable
as bool,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,currentLocation: freezed == currentLocation ? _self.currentLocation : currentLocation // ignore: cast_nullable_to_non_nullable
as ShipperLocationEntity?,trackingShipperId: freezed == trackingShipperId ? _self.trackingShipperId : trackingShipperId // ignore: cast_nullable_to_non_nullable
as int?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of ShipperLocationState
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
