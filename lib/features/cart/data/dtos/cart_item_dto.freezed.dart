// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartItemDto {

@HiveField(0) num get menuItemId;@HiveField(1) String get menuItemName;@HiveField(2) double get price;@HiveField(3) int get quantity;@HiveField(4) num get restaurantId;@HiveField(5) String get restaurantName;@HiveField(6) String? get imageUrl;@HiveField(7) String? get notes;
/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemDtoCopyWith<CartItemDto> get copyWith => _$CartItemDtoCopyWithImpl<CartItemDto>(this as CartItemDto, _$identity);

  /// Serializes this CartItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemDto&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,menuItemName,price,quantity,restaurantId,restaurantName,imageUrl,notes);

@override
String toString() {
  return 'CartItemDto(menuItemId: $menuItemId, menuItemName: $menuItemName, price: $price, quantity: $quantity, restaurantId: $restaurantId, restaurantName: $restaurantName, imageUrl: $imageUrl, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $CartItemDtoCopyWith<$Res>  {
  factory $CartItemDtoCopyWith(CartItemDto value, $Res Function(CartItemDto) _then) = _$CartItemDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) num menuItemId,@HiveField(1) String menuItemName,@HiveField(2) double price,@HiveField(3) int quantity,@HiveField(4) num restaurantId,@HiveField(5) String restaurantName,@HiveField(6) String? imageUrl,@HiveField(7) String? notes
});




}
/// @nodoc
class _$CartItemDtoCopyWithImpl<$Res>
    implements $CartItemDtoCopyWith<$Res> {
  _$CartItemDtoCopyWithImpl(this._self, this._then);

  final CartItemDto _self;
  final $Res Function(CartItemDto) _then;

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? menuItemId = null,Object? menuItemName = null,Object? price = null,Object? quantity = null,Object? restaurantId = null,Object? restaurantName = null,Object? imageUrl = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as num,menuItemName: null == menuItemName ? _self.menuItemName : menuItemName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as num,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartItemDto].
extension CartItemDtoPatterns on CartItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemDto value)  $default,){
final _that = this;
switch (_that) {
case _CartItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  num menuItemId, @HiveField(1)  String menuItemName, @HiveField(2)  double price, @HiveField(3)  int quantity, @HiveField(4)  num restaurantId, @HiveField(5)  String restaurantName, @HiveField(6)  String? imageUrl, @HiveField(7)  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
return $default(_that.menuItemId,_that.menuItemName,_that.price,_that.quantity,_that.restaurantId,_that.restaurantName,_that.imageUrl,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  num menuItemId, @HiveField(1)  String menuItemName, @HiveField(2)  double price, @HiveField(3)  int quantity, @HiveField(4)  num restaurantId, @HiveField(5)  String restaurantName, @HiveField(6)  String? imageUrl, @HiveField(7)  String? notes)  $default,) {final _that = this;
switch (_that) {
case _CartItemDto():
return $default(_that.menuItemId,_that.menuItemName,_that.price,_that.quantity,_that.restaurantId,_that.restaurantName,_that.imageUrl,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  num menuItemId, @HiveField(1)  String menuItemName, @HiveField(2)  double price, @HiveField(3)  int quantity, @HiveField(4)  num restaurantId, @HiveField(5)  String restaurantName, @HiveField(6)  String? imageUrl, @HiveField(7)  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
return $default(_that.menuItemId,_that.menuItemName,_that.price,_that.quantity,_that.restaurantId,_that.restaurantName,_that.imageUrl,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartItemDto implements CartItemDto {
  const _CartItemDto({@HiveField(0) required this.menuItemId, @HiveField(1) required this.menuItemName, @HiveField(2) required this.price, @HiveField(3) required this.quantity, @HiveField(4) required this.restaurantId, @HiveField(5) required this.restaurantName, @HiveField(6) this.imageUrl, @HiveField(7) this.notes});
  factory _CartItemDto.fromJson(Map<String, dynamic> json) => _$CartItemDtoFromJson(json);

@override@HiveField(0) final  num menuItemId;
@override@HiveField(1) final  String menuItemName;
@override@HiveField(2) final  double price;
@override@HiveField(3) final  int quantity;
@override@HiveField(4) final  num restaurantId;
@override@HiveField(5) final  String restaurantName;
@override@HiveField(6) final  String? imageUrl;
@override@HiveField(7) final  String? notes;

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemDtoCopyWith<_CartItemDto> get copyWith => __$CartItemDtoCopyWithImpl<_CartItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemDto&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,menuItemName,price,quantity,restaurantId,restaurantName,imageUrl,notes);

@override
String toString() {
  return 'CartItemDto(menuItemId: $menuItemId, menuItemName: $menuItemName, price: $price, quantity: $quantity, restaurantId: $restaurantId, restaurantName: $restaurantName, imageUrl: $imageUrl, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$CartItemDtoCopyWith<$Res> implements $CartItemDtoCopyWith<$Res> {
  factory _$CartItemDtoCopyWith(_CartItemDto value, $Res Function(_CartItemDto) _then) = __$CartItemDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) num menuItemId,@HiveField(1) String menuItemName,@HiveField(2) double price,@HiveField(3) int quantity,@HiveField(4) num restaurantId,@HiveField(5) String restaurantName,@HiveField(6) String? imageUrl,@HiveField(7) String? notes
});




}
/// @nodoc
class __$CartItemDtoCopyWithImpl<$Res>
    implements _$CartItemDtoCopyWith<$Res> {
  __$CartItemDtoCopyWithImpl(this._self, this._then);

  final _CartItemDto _self;
  final $Res Function(_CartItemDto) _then;

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? menuItemId = null,Object? menuItemName = null,Object? price = null,Object? quantity = null,Object? restaurantId = null,Object? restaurantName = null,Object? imageUrl = freezed,Object? notes = freezed,}) {
  return _then(_CartItemDto(
menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as num,menuItemName: null == menuItemName ? _self.menuItemName : menuItemName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as num,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
