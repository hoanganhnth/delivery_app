// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartEntity {

 List<CartItemEntity> get items; num? get currentRestaurantId; String? get currentRestaurantName;
/// Create a copy of CartEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartEntityCopyWith<CartEntity> get copyWith => _$CartEntityCopyWithImpl<CartEntity>(this as CartEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartEntity&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.currentRestaurantId, currentRestaurantId) || other.currentRestaurantId == currentRestaurantId)&&(identical(other.currentRestaurantName, currentRestaurantName) || other.currentRestaurantName == currentRestaurantName));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),currentRestaurantId,currentRestaurantName);

@override
String toString() {
  return 'CartEntity(items: $items, currentRestaurantId: $currentRestaurantId, currentRestaurantName: $currentRestaurantName)';
}


}

/// @nodoc
abstract mixin class $CartEntityCopyWith<$Res>  {
  factory $CartEntityCopyWith(CartEntity value, $Res Function(CartEntity) _then) = _$CartEntityCopyWithImpl;
@useResult
$Res call({
 List<CartItemEntity> items, num? currentRestaurantId, String? currentRestaurantName
});




}
/// @nodoc
class _$CartEntityCopyWithImpl<$Res>
    implements $CartEntityCopyWith<$Res> {
  _$CartEntityCopyWithImpl(this._self, this._then);

  final CartEntity _self;
  final $Res Function(CartEntity) _then;

/// Create a copy of CartEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? currentRestaurantId = freezed,Object? currentRestaurantName = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemEntity>,currentRestaurantId: freezed == currentRestaurantId ? _self.currentRestaurantId : currentRestaurantId // ignore: cast_nullable_to_non_nullable
as num?,currentRestaurantName: freezed == currentRestaurantName ? _self.currentRestaurantName : currentRestaurantName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartEntity].
extension CartEntityPatterns on CartEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartEntity value)  $default,){
final _that = this;
switch (_that) {
case _CartEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CartEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CartItemEntity> items,  num? currentRestaurantId,  String? currentRestaurantName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartEntity() when $default != null:
return $default(_that.items,_that.currentRestaurantId,_that.currentRestaurantName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CartItemEntity> items,  num? currentRestaurantId,  String? currentRestaurantName)  $default,) {final _that = this;
switch (_that) {
case _CartEntity():
return $default(_that.items,_that.currentRestaurantId,_that.currentRestaurantName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CartItemEntity> items,  num? currentRestaurantId,  String? currentRestaurantName)?  $default,) {final _that = this;
switch (_that) {
case _CartEntity() when $default != null:
return $default(_that.items,_that.currentRestaurantId,_that.currentRestaurantName);case _:
  return null;

}
}

}

/// @nodoc


class _CartEntity extends CartEntity {
  const _CartEntity({required final  List<CartItemEntity> items, required this.currentRestaurantId, required this.currentRestaurantName}): _items = items,super._();
  

 final  List<CartItemEntity> _items;
@override List<CartItemEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  num? currentRestaurantId;
@override final  String? currentRestaurantName;

/// Create a copy of CartEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartEntityCopyWith<_CartEntity> get copyWith => __$CartEntityCopyWithImpl<_CartEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartEntity&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.currentRestaurantId, currentRestaurantId) || other.currentRestaurantId == currentRestaurantId)&&(identical(other.currentRestaurantName, currentRestaurantName) || other.currentRestaurantName == currentRestaurantName));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),currentRestaurantId,currentRestaurantName);

@override
String toString() {
  return 'CartEntity(items: $items, currentRestaurantId: $currentRestaurantId, currentRestaurantName: $currentRestaurantName)';
}


}

/// @nodoc
abstract mixin class _$CartEntityCopyWith<$Res> implements $CartEntityCopyWith<$Res> {
  factory _$CartEntityCopyWith(_CartEntity value, $Res Function(_CartEntity) _then) = __$CartEntityCopyWithImpl;
@override @useResult
$Res call({
 List<CartItemEntity> items, num? currentRestaurantId, String? currentRestaurantName
});




}
/// @nodoc
class __$CartEntityCopyWithImpl<$Res>
    implements _$CartEntityCopyWith<$Res> {
  __$CartEntityCopyWithImpl(this._self, this._then);

  final _CartEntity _self;
  final $Res Function(_CartEntity) _then;

/// Create a copy of CartEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? currentRestaurantId = freezed,Object? currentRestaurantName = freezed,}) {
  return _then(_CartEntity(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemEntity>,currentRestaurantId: freezed == currentRestaurantId ? _self.currentRestaurantId : currentRestaurantId // ignore: cast_nullable_to_non_nullable
as num?,currentRestaurantName: freezed == currentRestaurantName ? _self.currentRestaurantName : currentRestaurantName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
