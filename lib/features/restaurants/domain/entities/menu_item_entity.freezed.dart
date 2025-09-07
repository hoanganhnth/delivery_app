// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MenuItemEntity {

 num? get id; num? get restaurantId; String get name; String get description; double get price; String? get image;@MenuItemStatusConverter() MenuItemStatus get status;
/// Create a copy of MenuItemEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuItemEntityCopyWith<MenuItemEntity> get copyWith => _$MenuItemEntityCopyWithImpl<MenuItemEntity>(this as MenuItemEntity, _$identity);

  /// Serializes this MenuItemEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.image, image) || other.image == image)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,restaurantId,name,description,price,image,status);

@override
String toString() {
  return 'MenuItemEntity(id: $id, restaurantId: $restaurantId, name: $name, description: $description, price: $price, image: $image, status: $status)';
}


}

/// @nodoc
abstract mixin class $MenuItemEntityCopyWith<$Res>  {
  factory $MenuItemEntityCopyWith(MenuItemEntity value, $Res Function(MenuItemEntity) _then) = _$MenuItemEntityCopyWithImpl;
@useResult
$Res call({
 num? id, num? restaurantId, String name, String description, double price, String? image,@MenuItemStatusConverter() MenuItemStatus status
});




}
/// @nodoc
class _$MenuItemEntityCopyWithImpl<$Res>
    implements $MenuItemEntityCopyWith<$Res> {
  _$MenuItemEntityCopyWithImpl(this._self, this._then);

  final MenuItemEntity _self;
  final $Res Function(MenuItemEntity) _then;

/// Create a copy of MenuItemEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? restaurantId = freezed,Object? name = null,Object? description = null,Object? price = null,Object? image = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num?,restaurantId: freezed == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as num?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MenuItemStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuItemEntity].
extension MenuItemEntityPatterns on MenuItemEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuItemEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuItemEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuItemEntity value)  $default,){
final _that = this;
switch (_that) {
case _MenuItemEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuItemEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MenuItemEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num? id,  num? restaurantId,  String name,  String description,  double price,  String? image, @MenuItemStatusConverter()  MenuItemStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuItemEntity() when $default != null:
return $default(_that.id,_that.restaurantId,_that.name,_that.description,_that.price,_that.image,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num? id,  num? restaurantId,  String name,  String description,  double price,  String? image, @MenuItemStatusConverter()  MenuItemStatus status)  $default,) {final _that = this;
switch (_that) {
case _MenuItemEntity():
return $default(_that.id,_that.restaurantId,_that.name,_that.description,_that.price,_that.image,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num? id,  num? restaurantId,  String name,  String description,  double price,  String? image, @MenuItemStatusConverter()  MenuItemStatus status)?  $default,) {final _that = this;
switch (_that) {
case _MenuItemEntity() when $default != null:
return $default(_that.id,_that.restaurantId,_that.name,_that.description,_that.price,_that.image,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MenuItemEntity implements MenuItemEntity {
  const _MenuItemEntity({this.id, this.restaurantId, required this.name, required this.description, required this.price, this.image, @MenuItemStatusConverter() required this.status});
  factory _MenuItemEntity.fromJson(Map<String, dynamic> json) => _$MenuItemEntityFromJson(json);

@override final  num? id;
@override final  num? restaurantId;
@override final  String name;
@override final  String description;
@override final  double price;
@override final  String? image;
@override@MenuItemStatusConverter() final  MenuItemStatus status;

/// Create a copy of MenuItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuItemEntityCopyWith<_MenuItemEntity> get copyWith => __$MenuItemEntityCopyWithImpl<_MenuItemEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuItemEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.image, image) || other.image == image)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,restaurantId,name,description,price,image,status);

@override
String toString() {
  return 'MenuItemEntity(id: $id, restaurantId: $restaurantId, name: $name, description: $description, price: $price, image: $image, status: $status)';
}


}

/// @nodoc
abstract mixin class _$MenuItemEntityCopyWith<$Res> implements $MenuItemEntityCopyWith<$Res> {
  factory _$MenuItemEntityCopyWith(_MenuItemEntity value, $Res Function(_MenuItemEntity) _then) = __$MenuItemEntityCopyWithImpl;
@override @useResult
$Res call({
 num? id, num? restaurantId, String name, String description, double price, String? image,@MenuItemStatusConverter() MenuItemStatus status
});




}
/// @nodoc
class __$MenuItemEntityCopyWithImpl<$Res>
    implements _$MenuItemEntityCopyWith<$Res> {
  __$MenuItemEntityCopyWithImpl(this._self, this._then);

  final _MenuItemEntity _self;
  final $Res Function(_MenuItemEntity) _then;

/// Create a copy of MenuItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? restaurantId = freezed,Object? name = null,Object? description = null,Object? price = null,Object? image = freezed,Object? status = null,}) {
  return _then(_MenuItemEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num?,restaurantId: freezed == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as num?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MenuItemStatus,
  ));
}


}

// dart format on
