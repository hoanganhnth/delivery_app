// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_tracking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryTrackingState {

 bool get isConnected; bool get isTracking; DeliveryTrackingEntity? get currentTracking; ShipperEntity? get shipper; int? get currentShipperId;// Theo dõi shipper ID hiện tại để biết khi nào cần fetch lại
 bool get isLoadingShipper;// Loading state riêng cho shipper
 List<List<double>>? get polylinePoints;// Danh sách toạ độ vẽ đường đi
 Failure? get failure; bool get isLoading;
/// Create a copy of DeliveryTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryTrackingStateCopyWith<DeliveryTrackingState> get copyWith => _$DeliveryTrackingStateCopyWithImpl<DeliveryTrackingState>(this as DeliveryTrackingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryTrackingState&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.isTracking, isTracking) || other.isTracking == isTracking)&&(identical(other.currentTracking, currentTracking) || other.currentTracking == currentTracking)&&(identical(other.shipper, shipper) || other.shipper == shipper)&&(identical(other.currentShipperId, currentShipperId) || other.currentShipperId == currentShipperId)&&(identical(other.isLoadingShipper, isLoadingShipper) || other.isLoadingShipper == isLoadingShipper)&&const DeepCollectionEquality().equals(other.polylinePoints, polylinePoints)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected,isTracking,currentTracking,shipper,currentShipperId,isLoadingShipper,const DeepCollectionEquality().hash(polylinePoints),failure,isLoading);

@override
String toString() {
  return 'DeliveryTrackingState(isConnected: $isConnected, isTracking: $isTracking, currentTracking: $currentTracking, shipper: $shipper, currentShipperId: $currentShipperId, isLoadingShipper: $isLoadingShipper, polylinePoints: $polylinePoints, failure: $failure, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $DeliveryTrackingStateCopyWith<$Res>  {
  factory $DeliveryTrackingStateCopyWith(DeliveryTrackingState value, $Res Function(DeliveryTrackingState) _then) = _$DeliveryTrackingStateCopyWithImpl;
@useResult
$Res call({
 bool isConnected, bool isTracking, DeliveryTrackingEntity? currentTracking, ShipperEntity? shipper, int? currentShipperId, bool isLoadingShipper, List<List<double>>? polylinePoints, Failure? failure, bool isLoading
});


$ShipperEntityCopyWith<$Res>? get shipper;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$DeliveryTrackingStateCopyWithImpl<$Res>
    implements $DeliveryTrackingStateCopyWith<$Res> {
  _$DeliveryTrackingStateCopyWithImpl(this._self, this._then);

  final DeliveryTrackingState _self;
  final $Res Function(DeliveryTrackingState) _then;

/// Create a copy of DeliveryTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isConnected = null,Object? isTracking = null,Object? currentTracking = freezed,Object? shipper = freezed,Object? currentShipperId = freezed,Object? isLoadingShipper = null,Object? polylinePoints = freezed,Object? failure = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,isTracking: null == isTracking ? _self.isTracking : isTracking // ignore: cast_nullable_to_non_nullable
as bool,currentTracking: freezed == currentTracking ? _self.currentTracking : currentTracking // ignore: cast_nullable_to_non_nullable
as DeliveryTrackingEntity?,shipper: freezed == shipper ? _self.shipper : shipper // ignore: cast_nullable_to_non_nullable
as ShipperEntity?,currentShipperId: freezed == currentShipperId ? _self.currentShipperId : currentShipperId // ignore: cast_nullable_to_non_nullable
as int?,isLoadingShipper: null == isLoadingShipper ? _self.isLoadingShipper : isLoadingShipper // ignore: cast_nullable_to_non_nullable
as bool,polylinePoints: freezed == polylinePoints ? _self.polylinePoints : polylinePoints // ignore: cast_nullable_to_non_nullable
as List<List<double>>?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of DeliveryTrackingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShipperEntityCopyWith<$Res>? get shipper {
    if (_self.shipper == null) {
    return null;
  }

  return $ShipperEntityCopyWith<$Res>(_self.shipper!, (value) {
    return _then(_self.copyWith(shipper: value));
  });
}/// Create a copy of DeliveryTrackingState
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


/// Adds pattern-matching-related methods to [DeliveryTrackingState].
extension DeliveryTrackingStatePatterns on DeliveryTrackingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryTrackingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryTrackingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryTrackingState value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryTrackingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryTrackingState value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryTrackingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isConnected,  bool isTracking,  DeliveryTrackingEntity? currentTracking,  ShipperEntity? shipper,  int? currentShipperId,  bool isLoadingShipper,  List<List<double>>? polylinePoints,  Failure? failure,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryTrackingState() when $default != null:
return $default(_that.isConnected,_that.isTracking,_that.currentTracking,_that.shipper,_that.currentShipperId,_that.isLoadingShipper,_that.polylinePoints,_that.failure,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isConnected,  bool isTracking,  DeliveryTrackingEntity? currentTracking,  ShipperEntity? shipper,  int? currentShipperId,  bool isLoadingShipper,  List<List<double>>? polylinePoints,  Failure? failure,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _DeliveryTrackingState():
return $default(_that.isConnected,_that.isTracking,_that.currentTracking,_that.shipper,_that.currentShipperId,_that.isLoadingShipper,_that.polylinePoints,_that.failure,_that.isLoading);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isConnected,  bool isTracking,  DeliveryTrackingEntity? currentTracking,  ShipperEntity? shipper,  int? currentShipperId,  bool isLoadingShipper,  List<List<double>>? polylinePoints,  Failure? failure,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryTrackingState() when $default != null:
return $default(_that.isConnected,_that.isTracking,_that.currentTracking,_that.shipper,_that.currentShipperId,_that.isLoadingShipper,_that.polylinePoints,_that.failure,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryTrackingState extends DeliveryTrackingState {
  const _DeliveryTrackingState({this.isConnected = false, this.isTracking = false, this.currentTracking, this.shipper, this.currentShipperId, this.isLoadingShipper = false, final  List<List<double>>? polylinePoints, this.failure, this.isLoading = false}): _polylinePoints = polylinePoints,super._();
  

@override@JsonKey() final  bool isConnected;
@override@JsonKey() final  bool isTracking;
@override final  DeliveryTrackingEntity? currentTracking;
@override final  ShipperEntity? shipper;
@override final  int? currentShipperId;
// Theo dõi shipper ID hiện tại để biết khi nào cần fetch lại
@override@JsonKey() final  bool isLoadingShipper;
// Loading state riêng cho shipper
 final  List<List<double>>? _polylinePoints;
// Loading state riêng cho shipper
@override List<List<double>>? get polylinePoints {
  final value = _polylinePoints;
  if (value == null) return null;
  if (_polylinePoints is EqualUnmodifiableListView) return _polylinePoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// Danh sách toạ độ vẽ đường đi
@override final  Failure? failure;
@override@JsonKey() final  bool isLoading;

/// Create a copy of DeliveryTrackingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryTrackingStateCopyWith<_DeliveryTrackingState> get copyWith => __$DeliveryTrackingStateCopyWithImpl<_DeliveryTrackingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryTrackingState&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.isTracking, isTracking) || other.isTracking == isTracking)&&(identical(other.currentTracking, currentTracking) || other.currentTracking == currentTracking)&&(identical(other.shipper, shipper) || other.shipper == shipper)&&(identical(other.currentShipperId, currentShipperId) || other.currentShipperId == currentShipperId)&&(identical(other.isLoadingShipper, isLoadingShipper) || other.isLoadingShipper == isLoadingShipper)&&const DeepCollectionEquality().equals(other._polylinePoints, _polylinePoints)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected,isTracking,currentTracking,shipper,currentShipperId,isLoadingShipper,const DeepCollectionEquality().hash(_polylinePoints),failure,isLoading);

@override
String toString() {
  return 'DeliveryTrackingState(isConnected: $isConnected, isTracking: $isTracking, currentTracking: $currentTracking, shipper: $shipper, currentShipperId: $currentShipperId, isLoadingShipper: $isLoadingShipper, polylinePoints: $polylinePoints, failure: $failure, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$DeliveryTrackingStateCopyWith<$Res> implements $DeliveryTrackingStateCopyWith<$Res> {
  factory _$DeliveryTrackingStateCopyWith(_DeliveryTrackingState value, $Res Function(_DeliveryTrackingState) _then) = __$DeliveryTrackingStateCopyWithImpl;
@override @useResult
$Res call({
 bool isConnected, bool isTracking, DeliveryTrackingEntity? currentTracking, ShipperEntity? shipper, int? currentShipperId, bool isLoadingShipper, List<List<double>>? polylinePoints, Failure? failure, bool isLoading
});


@override $ShipperEntityCopyWith<$Res>? get shipper;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$DeliveryTrackingStateCopyWithImpl<$Res>
    implements _$DeliveryTrackingStateCopyWith<$Res> {
  __$DeliveryTrackingStateCopyWithImpl(this._self, this._then);

  final _DeliveryTrackingState _self;
  final $Res Function(_DeliveryTrackingState) _then;

/// Create a copy of DeliveryTrackingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isConnected = null,Object? isTracking = null,Object? currentTracking = freezed,Object? shipper = freezed,Object? currentShipperId = freezed,Object? isLoadingShipper = null,Object? polylinePoints = freezed,Object? failure = freezed,Object? isLoading = null,}) {
  return _then(_DeliveryTrackingState(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,isTracking: null == isTracking ? _self.isTracking : isTracking // ignore: cast_nullable_to_non_nullable
as bool,currentTracking: freezed == currentTracking ? _self.currentTracking : currentTracking // ignore: cast_nullable_to_non_nullable
as DeliveryTrackingEntity?,shipper: freezed == shipper ? _self.shipper : shipper // ignore: cast_nullable_to_non_nullable
as ShipperEntity?,currentShipperId: freezed == currentShipperId ? _self.currentShipperId : currentShipperId // ignore: cast_nullable_to_non_nullable
as int?,isLoadingShipper: null == isLoadingShipper ? _self.isLoadingShipper : isLoadingShipper // ignore: cast_nullable_to_non_nullable
as bool,polylinePoints: freezed == polylinePoints ? _self._polylinePoints : polylinePoints // ignore: cast_nullable_to_non_nullable
as List<List<double>>?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DeliveryTrackingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShipperEntityCopyWith<$Res>? get shipper {
    if (_self.shipper == null) {
    return null;
  }

  return $ShipperEntityCopyWith<$Res>(_self.shipper!, (value) {
    return _then(_self.copyWith(shipper: value));
  });
}/// Create a copy of DeliveryTrackingState
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
