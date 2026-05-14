// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flash_sale_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlashSaleItemEntity {

 int get id; int get campaignId; String get campaignName; int get restaurantId; int get menuItemId; String get menuItemName; double get originalPrice; double get flashSalePrice; int get stockQuantity; int get soldQuantity; String get status;
/// Create a copy of FlashSaleItemEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashSaleItemEntityCopyWith<FlashSaleItemEntity> get copyWith => _$FlashSaleItemEntityCopyWithImpl<FlashSaleItemEntity>(this as FlashSaleItemEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashSaleItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.flashSalePrice, flashSalePrice) || other.flashSalePrice == flashSalePrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.soldQuantity, soldQuantity) || other.soldQuantity == soldQuantity)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,campaignId,campaignName,restaurantId,menuItemId,menuItemName,originalPrice,flashSalePrice,stockQuantity,soldQuantity,status);

@override
String toString() {
  return 'FlashSaleItemEntity(id: $id, campaignId: $campaignId, campaignName: $campaignName, restaurantId: $restaurantId, menuItemId: $menuItemId, menuItemName: $menuItemName, originalPrice: $originalPrice, flashSalePrice: $flashSalePrice, stockQuantity: $stockQuantity, soldQuantity: $soldQuantity, status: $status)';
}


}

/// @nodoc
abstract mixin class $FlashSaleItemEntityCopyWith<$Res>  {
  factory $FlashSaleItemEntityCopyWith(FlashSaleItemEntity value, $Res Function(FlashSaleItemEntity) _then) = _$FlashSaleItemEntityCopyWithImpl;
@useResult
$Res call({
 int id, int campaignId, String campaignName, int restaurantId, int menuItemId, String menuItemName, double originalPrice, double flashSalePrice, int stockQuantity, int soldQuantity, String status
});




}
/// @nodoc
class _$FlashSaleItemEntityCopyWithImpl<$Res>
    implements $FlashSaleItemEntityCopyWith<$Res> {
  _$FlashSaleItemEntityCopyWithImpl(this._self, this._then);

  final FlashSaleItemEntity _self;
  final $Res Function(FlashSaleItemEntity) _then;

/// Create a copy of FlashSaleItemEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? campaignName = null,Object? restaurantId = null,Object? menuItemId = null,Object? menuItemName = null,Object? originalPrice = null,Object? flashSalePrice = null,Object? stockQuantity = null,Object? soldQuantity = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as int,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int,menuItemName: null == menuItemName ? _self.menuItemName : menuItemName // ignore: cast_nullable_to_non_nullable
as String,originalPrice: null == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as double,flashSalePrice: null == flashSalePrice ? _self.flashSalePrice : flashSalePrice // ignore: cast_nullable_to_non_nullable
as double,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,soldQuantity: null == soldQuantity ? _self.soldQuantity : soldQuantity // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashSaleItemEntity].
extension FlashSaleItemEntityPatterns on FlashSaleItemEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashSaleItemEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashSaleItemEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashSaleItemEntity value)  $default,){
final _that = this;
switch (_that) {
case _FlashSaleItemEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashSaleItemEntity value)?  $default,){
final _that = this;
switch (_that) {
case _FlashSaleItemEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int campaignId,  String campaignName,  int restaurantId,  int menuItemId,  String menuItemName,  double originalPrice,  double flashSalePrice,  int stockQuantity,  int soldQuantity,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashSaleItemEntity() when $default != null:
return $default(_that.id,_that.campaignId,_that.campaignName,_that.restaurantId,_that.menuItemId,_that.menuItemName,_that.originalPrice,_that.flashSalePrice,_that.stockQuantity,_that.soldQuantity,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int campaignId,  String campaignName,  int restaurantId,  int menuItemId,  String menuItemName,  double originalPrice,  double flashSalePrice,  int stockQuantity,  int soldQuantity,  String status)  $default,) {final _that = this;
switch (_that) {
case _FlashSaleItemEntity():
return $default(_that.id,_that.campaignId,_that.campaignName,_that.restaurantId,_that.menuItemId,_that.menuItemName,_that.originalPrice,_that.flashSalePrice,_that.stockQuantity,_that.soldQuantity,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int campaignId,  String campaignName,  int restaurantId,  int menuItemId,  String menuItemName,  double originalPrice,  double flashSalePrice,  int stockQuantity,  int soldQuantity,  String status)?  $default,) {final _that = this;
switch (_that) {
case _FlashSaleItemEntity() when $default != null:
return $default(_that.id,_that.campaignId,_that.campaignName,_that.restaurantId,_that.menuItemId,_that.menuItemName,_that.originalPrice,_that.flashSalePrice,_that.stockQuantity,_that.soldQuantity,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _FlashSaleItemEntity extends FlashSaleItemEntity {
  const _FlashSaleItemEntity({required this.id, required this.campaignId, required this.campaignName, required this.restaurantId, required this.menuItemId, required this.menuItemName, required this.originalPrice, required this.flashSalePrice, required this.stockQuantity, required this.soldQuantity, required this.status}): super._();
  

@override final  int id;
@override final  int campaignId;
@override final  String campaignName;
@override final  int restaurantId;
@override final  int menuItemId;
@override final  String menuItemName;
@override final  double originalPrice;
@override final  double flashSalePrice;
@override final  int stockQuantity;
@override final  int soldQuantity;
@override final  String status;

/// Create a copy of FlashSaleItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashSaleItemEntityCopyWith<_FlashSaleItemEntity> get copyWith => __$FlashSaleItemEntityCopyWithImpl<_FlashSaleItemEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashSaleItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.campaignName, campaignName) || other.campaignName == campaignName)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.flashSalePrice, flashSalePrice) || other.flashSalePrice == flashSalePrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.soldQuantity, soldQuantity) || other.soldQuantity == soldQuantity)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,campaignId,campaignName,restaurantId,menuItemId,menuItemName,originalPrice,flashSalePrice,stockQuantity,soldQuantity,status);

@override
String toString() {
  return 'FlashSaleItemEntity(id: $id, campaignId: $campaignId, campaignName: $campaignName, restaurantId: $restaurantId, menuItemId: $menuItemId, menuItemName: $menuItemName, originalPrice: $originalPrice, flashSalePrice: $flashSalePrice, stockQuantity: $stockQuantity, soldQuantity: $soldQuantity, status: $status)';
}


}

/// @nodoc
abstract mixin class _$FlashSaleItemEntityCopyWith<$Res> implements $FlashSaleItemEntityCopyWith<$Res> {
  factory _$FlashSaleItemEntityCopyWith(_FlashSaleItemEntity value, $Res Function(_FlashSaleItemEntity) _then) = __$FlashSaleItemEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int campaignId, String campaignName, int restaurantId, int menuItemId, String menuItemName, double originalPrice, double flashSalePrice, int stockQuantity, int soldQuantity, String status
});




}
/// @nodoc
class __$FlashSaleItemEntityCopyWithImpl<$Res>
    implements _$FlashSaleItemEntityCopyWith<$Res> {
  __$FlashSaleItemEntityCopyWithImpl(this._self, this._then);

  final _FlashSaleItemEntity _self;
  final $Res Function(_FlashSaleItemEntity) _then;

/// Create a copy of FlashSaleItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? campaignName = null,Object? restaurantId = null,Object? menuItemId = null,Object? menuItemName = null,Object? originalPrice = null,Object? flashSalePrice = null,Object? stockQuantity = null,Object? soldQuantity = null,Object? status = null,}) {
  return _then(_FlashSaleItemEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as int,campaignName: null == campaignName ? _self.campaignName : campaignName // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int,menuItemName: null == menuItemName ? _self.menuItemName : menuItemName // ignore: cast_nullable_to_non_nullable
as String,originalPrice: null == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as double,flashSalePrice: null == flashSalePrice ? _self.flashSalePrice : flashSalePrice // ignore: cast_nullable_to_non_nullable
as double,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,soldQuantity: null == soldQuantity ? _self.soldQuantity : soldQuantity // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
