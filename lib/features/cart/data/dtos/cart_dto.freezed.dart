// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartDto {

@HiveField(0) List<CartItemDto> get items;@HiveField(1) num? get currentRestaurantId;@HiveField(2) String? get currentRestaurantName;
/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartDtoCopyWith<CartDto> get copyWith => _$CartDtoCopyWithImpl<CartDto>(this as CartDto, _$identity);

  /// Serializes this CartDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartDto&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.currentRestaurantId, currentRestaurantId) || other.currentRestaurantId == currentRestaurantId)&&(identical(other.currentRestaurantName, currentRestaurantName) || other.currentRestaurantName == currentRestaurantName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),currentRestaurantId,currentRestaurantName);

@override
String toString() {
  return 'CartDto(items: $items, currentRestaurantId: $currentRestaurantId, currentRestaurantName: $currentRestaurantName)';
}


}

/// @nodoc
abstract mixin class $CartDtoCopyWith<$Res>  {
  factory $CartDtoCopyWith(CartDto value, $Res Function(CartDto) _then) = _$CartDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) List<CartItemDto> items,@HiveField(1) num? currentRestaurantId,@HiveField(2) String? currentRestaurantName
});




}
/// @nodoc
class _$CartDtoCopyWithImpl<$Res>
    implements $CartDtoCopyWith<$Res> {
  _$CartDtoCopyWithImpl(this._self, this._then);

  final CartDto _self;
  final $Res Function(CartDto) _then;

/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? currentRestaurantId = freezed,Object? currentRestaurantName = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemDto>,currentRestaurantId: freezed == currentRestaurantId ? _self.currentRestaurantId : currentRestaurantId // ignore: cast_nullable_to_non_nullable
as num?,currentRestaurantName: freezed == currentRestaurantName ? _self.currentRestaurantName : currentRestaurantName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartDto].
extension CartDtoPatterns on CartDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartDto value)  $default,){
final _that = this;
switch (_that) {
case _CartDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartDto value)?  $default,){
final _that = this;
switch (_that) {
case _CartDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  List<CartItemDto> items, @HiveField(1)  num? currentRestaurantId, @HiveField(2)  String? currentRestaurantName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  List<CartItemDto> items, @HiveField(1)  num? currentRestaurantId, @HiveField(2)  String? currentRestaurantName)  $default,) {final _that = this;
switch (_that) {
case _CartDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  List<CartItemDto> items, @HiveField(1)  num? currentRestaurantId, @HiveField(2)  String? currentRestaurantName)?  $default,) {final _that = this;
switch (_that) {
case _CartDto() when $default != null:
return $default(_that.items,_that.currentRestaurantId,_that.currentRestaurantName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartDto implements CartDto {
  const _CartDto({@HiveField(0) required final  List<CartItemDto> items, @HiveField(1) this.currentRestaurantId, @HiveField(2) this.currentRestaurantName}): _items = items;
  factory _CartDto.fromJson(Map<String, dynamic> json) => _$CartDtoFromJson(json);

 final  List<CartItemDto> _items;
@override@HiveField(0) List<CartItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@HiveField(1) final  num? currentRestaurantId;
@override@HiveField(2) final  String? currentRestaurantName;

/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartDtoCopyWith<_CartDto> get copyWith => __$CartDtoCopyWithImpl<_CartDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartDto&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.currentRestaurantId, currentRestaurantId) || other.currentRestaurantId == currentRestaurantId)&&(identical(other.currentRestaurantName, currentRestaurantName) || other.currentRestaurantName == currentRestaurantName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),currentRestaurantId,currentRestaurantName);

@override
String toString() {
  return 'CartDto(items: $items, currentRestaurantId: $currentRestaurantId, currentRestaurantName: $currentRestaurantName)';
}


}

/// @nodoc
abstract mixin class _$CartDtoCopyWith<$Res> implements $CartDtoCopyWith<$Res> {
  factory _$CartDtoCopyWith(_CartDto value, $Res Function(_CartDto) _then) = __$CartDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) List<CartItemDto> items,@HiveField(1) num? currentRestaurantId,@HiveField(2) String? currentRestaurantName
});




}
/// @nodoc
class __$CartDtoCopyWithImpl<$Res>
    implements _$CartDtoCopyWith<$Res> {
  __$CartDtoCopyWithImpl(this._self, this._then);

  final _CartDto _self;
  final $Res Function(_CartDto) _then;

/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? currentRestaurantId = freezed,Object? currentRestaurantName = freezed,}) {
  return _then(_CartDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemDto>,currentRestaurantId: freezed == currentRestaurantId ? _self.currentRestaurantId : currentRestaurantId // ignore: cast_nullable_to_non_nullable
as num?,currentRestaurantName: freezed == currentRestaurantName ? _self.currentRestaurantName : currentRestaurantName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
