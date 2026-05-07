// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RestaurantDetailState {

 bool get isLoading; RestaurantEntity? get restaurant; List<MenuItemEntity> get menuItems; Failure? get failure; bool get isMenuLoading;
/// Create a copy of RestaurantDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantDetailStateCopyWith<RestaurantDetailState> get copyWith => _$RestaurantDetailStateCopyWithImpl<RestaurantDetailState>(this as RestaurantDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.restaurant, restaurant) || other.restaurant == restaurant)&&const DeepCollectionEquality().equals(other.menuItems, menuItems)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isMenuLoading, isMenuLoading) || other.isMenuLoading == isMenuLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,restaurant,const DeepCollectionEquality().hash(menuItems),failure,isMenuLoading);

@override
String toString() {
  return 'RestaurantDetailState(isLoading: $isLoading, restaurant: $restaurant, menuItems: $menuItems, failure: $failure, isMenuLoading: $isMenuLoading)';
}


}

/// @nodoc
abstract mixin class $RestaurantDetailStateCopyWith<$Res>  {
  factory $RestaurantDetailStateCopyWith(RestaurantDetailState value, $Res Function(RestaurantDetailState) _then) = _$RestaurantDetailStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, RestaurantEntity? restaurant, List<MenuItemEntity> menuItems, Failure? failure, bool isMenuLoading
});


$RestaurantEntityCopyWith<$Res>? get restaurant;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$RestaurantDetailStateCopyWithImpl<$Res>
    implements $RestaurantDetailStateCopyWith<$Res> {
  _$RestaurantDetailStateCopyWithImpl(this._self, this._then);

  final RestaurantDetailState _self;
  final $Res Function(RestaurantDetailState) _then;

/// Create a copy of RestaurantDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? restaurant = freezed,Object? menuItems = null,Object? failure = freezed,Object? isMenuLoading = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,restaurant: freezed == restaurant ? _self.restaurant : restaurant // ignore: cast_nullable_to_non_nullable
as RestaurantEntity?,menuItems: null == menuItems ? _self.menuItems : menuItems // ignore: cast_nullable_to_non_nullable
as List<MenuItemEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isMenuLoading: null == isMenuLoading ? _self.isMenuLoading : isMenuLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of RestaurantDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RestaurantEntityCopyWith<$Res>? get restaurant {
    if (_self.restaurant == null) {
    return null;
  }

  return $RestaurantEntityCopyWith<$Res>(_self.restaurant!, (value) {
    return _then(_self.copyWith(restaurant: value));
  });
}/// Create a copy of RestaurantDetailState
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


/// Adds pattern-matching-related methods to [RestaurantDetailState].
extension RestaurantDetailStatePatterns on RestaurantDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantDetailState value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  RestaurantEntity? restaurant,  List<MenuItemEntity> menuItems,  Failure? failure,  bool isMenuLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantDetailState() when $default != null:
return $default(_that.isLoading,_that.restaurant,_that.menuItems,_that.failure,_that.isMenuLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  RestaurantEntity? restaurant,  List<MenuItemEntity> menuItems,  Failure? failure,  bool isMenuLoading)  $default,) {final _that = this;
switch (_that) {
case _RestaurantDetailState():
return $default(_that.isLoading,_that.restaurant,_that.menuItems,_that.failure,_that.isMenuLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  RestaurantEntity? restaurant,  List<MenuItemEntity> menuItems,  Failure? failure,  bool isMenuLoading)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantDetailState() when $default != null:
return $default(_that.isLoading,_that.restaurant,_that.menuItems,_that.failure,_that.isMenuLoading);case _:
  return null;

}
}

}

/// @nodoc


class _RestaurantDetailState extends RestaurantDetailState {
  const _RestaurantDetailState({this.isLoading = false, this.restaurant, final  List<MenuItemEntity> menuItems = const [], this.failure, this.isMenuLoading = false}): _menuItems = menuItems,super._();
  

@override@JsonKey() final  bool isLoading;
@override final  RestaurantEntity? restaurant;
 final  List<MenuItemEntity> _menuItems;
@override@JsonKey() List<MenuItemEntity> get menuItems {
  if (_menuItems is EqualUnmodifiableListView) return _menuItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuItems);
}

@override final  Failure? failure;
@override@JsonKey() final  bool isMenuLoading;

/// Create a copy of RestaurantDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantDetailStateCopyWith<_RestaurantDetailState> get copyWith => __$RestaurantDetailStateCopyWithImpl<_RestaurantDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.restaurant, restaurant) || other.restaurant == restaurant)&&const DeepCollectionEquality().equals(other._menuItems, _menuItems)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isMenuLoading, isMenuLoading) || other.isMenuLoading == isMenuLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,restaurant,const DeepCollectionEquality().hash(_menuItems),failure,isMenuLoading);

@override
String toString() {
  return 'RestaurantDetailState(isLoading: $isLoading, restaurant: $restaurant, menuItems: $menuItems, failure: $failure, isMenuLoading: $isMenuLoading)';
}


}

/// @nodoc
abstract mixin class _$RestaurantDetailStateCopyWith<$Res> implements $RestaurantDetailStateCopyWith<$Res> {
  factory _$RestaurantDetailStateCopyWith(_RestaurantDetailState value, $Res Function(_RestaurantDetailState) _then) = __$RestaurantDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, RestaurantEntity? restaurant, List<MenuItemEntity> menuItems, Failure? failure, bool isMenuLoading
});


@override $RestaurantEntityCopyWith<$Res>? get restaurant;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$RestaurantDetailStateCopyWithImpl<$Res>
    implements _$RestaurantDetailStateCopyWith<$Res> {
  __$RestaurantDetailStateCopyWithImpl(this._self, this._then);

  final _RestaurantDetailState _self;
  final $Res Function(_RestaurantDetailState) _then;

/// Create a copy of RestaurantDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? restaurant = freezed,Object? menuItems = null,Object? failure = freezed,Object? isMenuLoading = null,}) {
  return _then(_RestaurantDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,restaurant: freezed == restaurant ? _self.restaurant : restaurant // ignore: cast_nullable_to_non_nullable
as RestaurantEntity?,menuItems: null == menuItems ? _self._menuItems : menuItems // ignore: cast_nullable_to_non_nullable
as List<MenuItemEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isMenuLoading: null == isMenuLoading ? _self.isMenuLoading : isMenuLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RestaurantDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RestaurantEntityCopyWith<$Res>? get restaurant {
    if (_self.restaurant == null) {
    return null;
  }

  return $RestaurantEntityCopyWith<$Res>(_self.restaurant!, (value) {
    return _then(_self.copyWith(restaurant: value));
  });
}/// Create a copy of RestaurantDetailState
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
