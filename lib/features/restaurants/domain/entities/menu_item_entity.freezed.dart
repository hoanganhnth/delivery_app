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

 String get id; String get restaurantId; String get name; String get description; double get price; String get imageUrl; String get category; bool get isAvailable; List<String> get allergens; int get preparationTime;// in minutes
 double? get discount; int? get calories; Map<String, dynamic>? get nutrition;
/// Create a copy of MenuItemEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuItemEntityCopyWith<MenuItemEntity> get copyWith => _$MenuItemEntityCopyWithImpl<MenuItemEntity>(this as MenuItemEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&const DeepCollectionEquality().equals(other.allergens, allergens)&&(identical(other.preparationTime, preparationTime) || other.preparationTime == preparationTime)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.calories, calories) || other.calories == calories)&&const DeepCollectionEquality().equals(other.nutrition, nutrition));
}


@override
int get hashCode => Object.hash(runtimeType,id,restaurantId,name,description,price,imageUrl,category,isAvailable,const DeepCollectionEquality().hash(allergens),preparationTime,discount,calories,const DeepCollectionEquality().hash(nutrition));

@override
String toString() {
  return 'MenuItemEntity(id: $id, restaurantId: $restaurantId, name: $name, description: $description, price: $price, imageUrl: $imageUrl, category: $category, isAvailable: $isAvailable, allergens: $allergens, preparationTime: $preparationTime, discount: $discount, calories: $calories, nutrition: $nutrition)';
}


}

/// @nodoc
abstract mixin class $MenuItemEntityCopyWith<$Res>  {
  factory $MenuItemEntityCopyWith(MenuItemEntity value, $Res Function(MenuItemEntity) _then) = _$MenuItemEntityCopyWithImpl;
@useResult
$Res call({
 String id, String restaurantId, String name, String description, double price, String imageUrl, String category, bool isAvailable, List<String> allergens, int preparationTime, double? discount, int? calories, Map<String, dynamic>? nutrition
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? restaurantId = null,Object? name = null,Object? description = null,Object? price = null,Object? imageUrl = null,Object? category = null,Object? isAvailable = null,Object? allergens = null,Object? preparationTime = null,Object? discount = freezed,Object? calories = freezed,Object? nutrition = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,allergens: null == allergens ? _self.allergens : allergens // ignore: cast_nullable_to_non_nullable
as List<String>,preparationTime: null == preparationTime ? _self.preparationTime : preparationTime // ignore: cast_nullable_to_non_nullable
as int,discount: freezed == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double?,calories: freezed == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as int?,nutrition: freezed == nutrition ? _self.nutrition : nutrition // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String restaurantId,  String name,  String description,  double price,  String imageUrl,  String category,  bool isAvailable,  List<String> allergens,  int preparationTime,  double? discount,  int? calories,  Map<String, dynamic>? nutrition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuItemEntity() when $default != null:
return $default(_that.id,_that.restaurantId,_that.name,_that.description,_that.price,_that.imageUrl,_that.category,_that.isAvailable,_that.allergens,_that.preparationTime,_that.discount,_that.calories,_that.nutrition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String restaurantId,  String name,  String description,  double price,  String imageUrl,  String category,  bool isAvailable,  List<String> allergens,  int preparationTime,  double? discount,  int? calories,  Map<String, dynamic>? nutrition)  $default,) {final _that = this;
switch (_that) {
case _MenuItemEntity():
return $default(_that.id,_that.restaurantId,_that.name,_that.description,_that.price,_that.imageUrl,_that.category,_that.isAvailable,_that.allergens,_that.preparationTime,_that.discount,_that.calories,_that.nutrition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String restaurantId,  String name,  String description,  double price,  String imageUrl,  String category,  bool isAvailable,  List<String> allergens,  int preparationTime,  double? discount,  int? calories,  Map<String, dynamic>? nutrition)?  $default,) {final _that = this;
switch (_that) {
case _MenuItemEntity() when $default != null:
return $default(_that.id,_that.restaurantId,_that.name,_that.description,_that.price,_that.imageUrl,_that.category,_that.isAvailable,_that.allergens,_that.preparationTime,_that.discount,_that.calories,_that.nutrition);case _:
  return null;

}
}

}

/// @nodoc


class _MenuItemEntity implements MenuItemEntity {
  const _MenuItemEntity({required this.id, required this.restaurantId, required this.name, required this.description, required this.price, required this.imageUrl, required this.category, required this.isAvailable, required final  List<String> allergens, required this.preparationTime, this.discount, this.calories, final  Map<String, dynamic>? nutrition}): _allergens = allergens,_nutrition = nutrition;
  

@override final  String id;
@override final  String restaurantId;
@override final  String name;
@override final  String description;
@override final  double price;
@override final  String imageUrl;
@override final  String category;
@override final  bool isAvailable;
 final  List<String> _allergens;
@override List<String> get allergens {
  if (_allergens is EqualUnmodifiableListView) return _allergens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allergens);
}

@override final  int preparationTime;
// in minutes
@override final  double? discount;
@override final  int? calories;
 final  Map<String, dynamic>? _nutrition;
@override Map<String, dynamic>? get nutrition {
  final value = _nutrition;
  if (value == null) return null;
  if (_nutrition is EqualUnmodifiableMapView) return _nutrition;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of MenuItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuItemEntityCopyWith<_MenuItemEntity> get copyWith => __$MenuItemEntityCopyWithImpl<_MenuItemEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&const DeepCollectionEquality().equals(other._allergens, _allergens)&&(identical(other.preparationTime, preparationTime) || other.preparationTime == preparationTime)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.calories, calories) || other.calories == calories)&&const DeepCollectionEquality().equals(other._nutrition, _nutrition));
}


@override
int get hashCode => Object.hash(runtimeType,id,restaurantId,name,description,price,imageUrl,category,isAvailable,const DeepCollectionEquality().hash(_allergens),preparationTime,discount,calories,const DeepCollectionEquality().hash(_nutrition));

@override
String toString() {
  return 'MenuItemEntity(id: $id, restaurantId: $restaurantId, name: $name, description: $description, price: $price, imageUrl: $imageUrl, category: $category, isAvailable: $isAvailable, allergens: $allergens, preparationTime: $preparationTime, discount: $discount, calories: $calories, nutrition: $nutrition)';
}


}

/// @nodoc
abstract mixin class _$MenuItemEntityCopyWith<$Res> implements $MenuItemEntityCopyWith<$Res> {
  factory _$MenuItemEntityCopyWith(_MenuItemEntity value, $Res Function(_MenuItemEntity) _then) = __$MenuItemEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String restaurantId, String name, String description, double price, String imageUrl, String category, bool isAvailable, List<String> allergens, int preparationTime, double? discount, int? calories, Map<String, dynamic>? nutrition
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? restaurantId = null,Object? name = null,Object? description = null,Object? price = null,Object? imageUrl = null,Object? category = null,Object? isAvailable = null,Object? allergens = null,Object? preparationTime = null,Object? discount = freezed,Object? calories = freezed,Object? nutrition = freezed,}) {
  return _then(_MenuItemEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,allergens: null == allergens ? _self._allergens : allergens // ignore: cast_nullable_to_non_nullable
as List<String>,preparationTime: null == preparationTime ? _self.preparationTime : preparationTime // ignore: cast_nullable_to_non_nullable
as int,discount: freezed == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double?,calories: freezed == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as int?,nutrition: freezed == nutrition ? _self._nutrition : nutrition // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
