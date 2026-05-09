// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'non_consumable_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NonConsumableState {

 bool get isLoading; List<NonConsumableEntity> get products; List<FeatureType> get unlockedFeatures; Failure? get failure; String? get successMessage;
/// Create a copy of NonConsumableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NonConsumableStateCopyWith<NonConsumableState> get copyWith => _$NonConsumableStateCopyWithImpl<NonConsumableState>(this as NonConsumableState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NonConsumableState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.unlockedFeatures, unlockedFeatures)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(unlockedFeatures),failure,successMessage);

@override
String toString() {
  return 'NonConsumableState(isLoading: $isLoading, products: $products, unlockedFeatures: $unlockedFeatures, failure: $failure, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $NonConsumableStateCopyWith<$Res>  {
  factory $NonConsumableStateCopyWith(NonConsumableState value, $Res Function(NonConsumableState) _then) = _$NonConsumableStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<NonConsumableEntity> products, List<FeatureType> unlockedFeatures, Failure? failure, String? successMessage
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$NonConsumableStateCopyWithImpl<$Res>
    implements $NonConsumableStateCopyWith<$Res> {
  _$NonConsumableStateCopyWithImpl(this._self, this._then);

  final NonConsumableState _self;
  final $Res Function(NonConsumableState) _then;

/// Create a copy of NonConsumableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? products = null,Object? unlockedFeatures = null,Object? failure = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<NonConsumableEntity>,unlockedFeatures: null == unlockedFeatures ? _self.unlockedFeatures : unlockedFeatures // ignore: cast_nullable_to_non_nullable
as List<FeatureType>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of NonConsumableState
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


/// Adds pattern-matching-related methods to [NonConsumableState].
extension NonConsumableStatePatterns on NonConsumableState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NonConsumableState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NonConsumableState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NonConsumableState value)  $default,){
final _that = this;
switch (_that) {
case _NonConsumableState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NonConsumableState value)?  $default,){
final _that = this;
switch (_that) {
case _NonConsumableState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<NonConsumableEntity> products,  List<FeatureType> unlockedFeatures,  Failure? failure,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NonConsumableState() when $default != null:
return $default(_that.isLoading,_that.products,_that.unlockedFeatures,_that.failure,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<NonConsumableEntity> products,  List<FeatureType> unlockedFeatures,  Failure? failure,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _NonConsumableState():
return $default(_that.isLoading,_that.products,_that.unlockedFeatures,_that.failure,_that.successMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<NonConsumableEntity> products,  List<FeatureType> unlockedFeatures,  Failure? failure,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _NonConsumableState() when $default != null:
return $default(_that.isLoading,_that.products,_that.unlockedFeatures,_that.failure,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _NonConsumableState extends NonConsumableState {
  const _NonConsumableState({this.isLoading = false, final  List<NonConsumableEntity> products = const [], final  List<FeatureType> unlockedFeatures = const [], this.failure, this.successMessage}): _products = products,_unlockedFeatures = unlockedFeatures,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<NonConsumableEntity> _products;
@override@JsonKey() List<NonConsumableEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<FeatureType> _unlockedFeatures;
@override@JsonKey() List<FeatureType> get unlockedFeatures {
  if (_unlockedFeatures is EqualUnmodifiableListView) return _unlockedFeatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unlockedFeatures);
}

@override final  Failure? failure;
@override final  String? successMessage;

/// Create a copy of NonConsumableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NonConsumableStateCopyWith<_NonConsumableState> get copyWith => __$NonConsumableStateCopyWithImpl<_NonConsumableState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NonConsumableState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._unlockedFeatures, _unlockedFeatures)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_unlockedFeatures),failure,successMessage);

@override
String toString() {
  return 'NonConsumableState(isLoading: $isLoading, products: $products, unlockedFeatures: $unlockedFeatures, failure: $failure, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$NonConsumableStateCopyWith<$Res> implements $NonConsumableStateCopyWith<$Res> {
  factory _$NonConsumableStateCopyWith(_NonConsumableState value, $Res Function(_NonConsumableState) _then) = __$NonConsumableStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<NonConsumableEntity> products, List<FeatureType> unlockedFeatures, Failure? failure, String? successMessage
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$NonConsumableStateCopyWithImpl<$Res>
    implements _$NonConsumableStateCopyWith<$Res> {
  __$NonConsumableStateCopyWithImpl(this._self, this._then);

  final _NonConsumableState _self;
  final $Res Function(_NonConsumableState) _then;

/// Create a copy of NonConsumableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? products = null,Object? unlockedFeatures = null,Object? failure = freezed,Object? successMessage = freezed,}) {
  return _then(_NonConsumableState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<NonConsumableEntity>,unlockedFeatures: null == unlockedFeatures ? _self._unlockedFeatures : unlockedFeatures // ignore: cast_nullable_to_non_nullable
as List<FeatureType>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of NonConsumableState
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
