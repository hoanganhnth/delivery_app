// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurants_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RestaurantsState {

 bool get isLoading; List<RestaurantEntity> get restaurants; Failure? get failure; bool get isSearchLoading; bool get isNearbyLoading; bool get isFeaturedLoading;
/// Create a copy of RestaurantsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantsStateCopyWith<RestaurantsState> get copyWith => _$RestaurantsStateCopyWithImpl<RestaurantsState>(this as RestaurantsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.restaurants, restaurants)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isSearchLoading, isSearchLoading) || other.isSearchLoading == isSearchLoading)&&(identical(other.isNearbyLoading, isNearbyLoading) || other.isNearbyLoading == isNearbyLoading)&&(identical(other.isFeaturedLoading, isFeaturedLoading) || other.isFeaturedLoading == isFeaturedLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(restaurants),failure,isSearchLoading,isNearbyLoading,isFeaturedLoading);

@override
String toString() {
  return 'RestaurantsState(isLoading: $isLoading, restaurants: $restaurants, failure: $failure, isSearchLoading: $isSearchLoading, isNearbyLoading: $isNearbyLoading, isFeaturedLoading: $isFeaturedLoading)';
}


}

/// @nodoc
abstract mixin class $RestaurantsStateCopyWith<$Res>  {
  factory $RestaurantsStateCopyWith(RestaurantsState value, $Res Function(RestaurantsState) _then) = _$RestaurantsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<RestaurantEntity> restaurants, Failure? failure, bool isSearchLoading, bool isNearbyLoading, bool isFeaturedLoading
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$RestaurantsStateCopyWithImpl<$Res>
    implements $RestaurantsStateCopyWith<$Res> {
  _$RestaurantsStateCopyWithImpl(this._self, this._then);

  final RestaurantsState _self;
  final $Res Function(RestaurantsState) _then;

/// Create a copy of RestaurantsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? restaurants = null,Object? failure = freezed,Object? isSearchLoading = null,Object? isNearbyLoading = null,Object? isFeaturedLoading = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,restaurants: null == restaurants ? _self.restaurants : restaurants // ignore: cast_nullable_to_non_nullable
as List<RestaurantEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isSearchLoading: null == isSearchLoading ? _self.isSearchLoading : isSearchLoading // ignore: cast_nullable_to_non_nullable
as bool,isNearbyLoading: null == isNearbyLoading ? _self.isNearbyLoading : isNearbyLoading // ignore: cast_nullable_to_non_nullable
as bool,isFeaturedLoading: null == isFeaturedLoading ? _self.isFeaturedLoading : isFeaturedLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of RestaurantsState
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


/// Adds pattern-matching-related methods to [RestaurantsState].
extension RestaurantsStatePatterns on RestaurantsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantsState value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantsState value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<RestaurantEntity> restaurants,  Failure? failure,  bool isSearchLoading,  bool isNearbyLoading,  bool isFeaturedLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantsState() when $default != null:
return $default(_that.isLoading,_that.restaurants,_that.failure,_that.isSearchLoading,_that.isNearbyLoading,_that.isFeaturedLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<RestaurantEntity> restaurants,  Failure? failure,  bool isSearchLoading,  bool isNearbyLoading,  bool isFeaturedLoading)  $default,) {final _that = this;
switch (_that) {
case _RestaurantsState():
return $default(_that.isLoading,_that.restaurants,_that.failure,_that.isSearchLoading,_that.isNearbyLoading,_that.isFeaturedLoading);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<RestaurantEntity> restaurants,  Failure? failure,  bool isSearchLoading,  bool isNearbyLoading,  bool isFeaturedLoading)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantsState() when $default != null:
return $default(_that.isLoading,_that.restaurants,_that.failure,_that.isSearchLoading,_that.isNearbyLoading,_that.isFeaturedLoading);case _:
  return null;

}
}

}

/// @nodoc


class _RestaurantsState extends RestaurantsState {
  const _RestaurantsState({this.isLoading = false, final  List<RestaurantEntity> restaurants = const [], this.failure, this.isSearchLoading = false, this.isNearbyLoading = false, this.isFeaturedLoading = false}): _restaurants = restaurants,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<RestaurantEntity> _restaurants;
@override@JsonKey() List<RestaurantEntity> get restaurants {
  if (_restaurants is EqualUnmodifiableListView) return _restaurants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_restaurants);
}

@override final  Failure? failure;
@override@JsonKey() final  bool isSearchLoading;
@override@JsonKey() final  bool isNearbyLoading;
@override@JsonKey() final  bool isFeaturedLoading;

/// Create a copy of RestaurantsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantsStateCopyWith<_RestaurantsState> get copyWith => __$RestaurantsStateCopyWithImpl<_RestaurantsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._restaurants, _restaurants)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isSearchLoading, isSearchLoading) || other.isSearchLoading == isSearchLoading)&&(identical(other.isNearbyLoading, isNearbyLoading) || other.isNearbyLoading == isNearbyLoading)&&(identical(other.isFeaturedLoading, isFeaturedLoading) || other.isFeaturedLoading == isFeaturedLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_restaurants),failure,isSearchLoading,isNearbyLoading,isFeaturedLoading);

@override
String toString() {
  return 'RestaurantsState(isLoading: $isLoading, restaurants: $restaurants, failure: $failure, isSearchLoading: $isSearchLoading, isNearbyLoading: $isNearbyLoading, isFeaturedLoading: $isFeaturedLoading)';
}


}

/// @nodoc
abstract mixin class _$RestaurantsStateCopyWith<$Res> implements $RestaurantsStateCopyWith<$Res> {
  factory _$RestaurantsStateCopyWith(_RestaurantsState value, $Res Function(_RestaurantsState) _then) = __$RestaurantsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<RestaurantEntity> restaurants, Failure? failure, bool isSearchLoading, bool isNearbyLoading, bool isFeaturedLoading
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$RestaurantsStateCopyWithImpl<$Res>
    implements _$RestaurantsStateCopyWith<$Res> {
  __$RestaurantsStateCopyWithImpl(this._self, this._then);

  final _RestaurantsState _self;
  final $Res Function(_RestaurantsState) _then;

/// Create a copy of RestaurantsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? restaurants = null,Object? failure = freezed,Object? isSearchLoading = null,Object? isNearbyLoading = null,Object? isFeaturedLoading = null,}) {
  return _then(_RestaurantsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,restaurants: null == restaurants ? _self._restaurants : restaurants // ignore: cast_nullable_to_non_nullable
as List<RestaurantEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isSearchLoading: null == isSearchLoading ? _self.isSearchLoading : isSearchLoading // ignore: cast_nullable_to_non_nullable
as bool,isNearbyLoading: null == isNearbyLoading ? _self.isNearbyLoading : isNearbyLoading // ignore: cast_nullable_to_non_nullable
as bool,isFeaturedLoading: null == isFeaturedLoading ? _self.isFeaturedLoading : isFeaturedLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RestaurantsState
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
