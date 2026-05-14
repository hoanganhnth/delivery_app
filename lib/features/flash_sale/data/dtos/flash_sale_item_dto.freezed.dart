// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flash_sale_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FlashSaleItemDto {

 int get id; FlashSaleCampaignDto get campaign; int get restaurantId; int get menuItemId; String get menuItemName; double get originalPrice; double get flashSalePrice; int get stockQuantity; int get soldQuantity; String get status;
/// Create a copy of FlashSaleItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashSaleItemDtoCopyWith<FlashSaleItemDto> get copyWith => _$FlashSaleItemDtoCopyWithImpl<FlashSaleItemDto>(this as FlashSaleItemDto, _$identity);

  /// Serializes this FlashSaleItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashSaleItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.flashSalePrice, flashSalePrice) || other.flashSalePrice == flashSalePrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.soldQuantity, soldQuantity) || other.soldQuantity == soldQuantity)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaign,restaurantId,menuItemId,menuItemName,originalPrice,flashSalePrice,stockQuantity,soldQuantity,status);

@override
String toString() {
  return 'FlashSaleItemDto(id: $id, campaign: $campaign, restaurantId: $restaurantId, menuItemId: $menuItemId, menuItemName: $menuItemName, originalPrice: $originalPrice, flashSalePrice: $flashSalePrice, stockQuantity: $stockQuantity, soldQuantity: $soldQuantity, status: $status)';
}


}

/// @nodoc
abstract mixin class $FlashSaleItemDtoCopyWith<$Res>  {
  factory $FlashSaleItemDtoCopyWith(FlashSaleItemDto value, $Res Function(FlashSaleItemDto) _then) = _$FlashSaleItemDtoCopyWithImpl;
@useResult
$Res call({
 int id, FlashSaleCampaignDto campaign, int restaurantId, int menuItemId, String menuItemName, double originalPrice, double flashSalePrice, int stockQuantity, int soldQuantity, String status
});


$FlashSaleCampaignDtoCopyWith<$Res> get campaign;

}
/// @nodoc
class _$FlashSaleItemDtoCopyWithImpl<$Res>
    implements $FlashSaleItemDtoCopyWith<$Res> {
  _$FlashSaleItemDtoCopyWithImpl(this._self, this._then);

  final FlashSaleItemDto _self;
  final $Res Function(FlashSaleItemDto) _then;

/// Create a copy of FlashSaleItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaign = null,Object? restaurantId = null,Object? menuItemId = null,Object? menuItemName = null,Object? originalPrice = null,Object? flashSalePrice = null,Object? stockQuantity = null,Object? soldQuantity = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,campaign: null == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as FlashSaleCampaignDto,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
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
/// Create a copy of FlashSaleItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FlashSaleCampaignDtoCopyWith<$Res> get campaign {
  
  return $FlashSaleCampaignDtoCopyWith<$Res>(_self.campaign, (value) {
    return _then(_self.copyWith(campaign: value));
  });
}
}


/// Adds pattern-matching-related methods to [FlashSaleItemDto].
extension FlashSaleItemDtoPatterns on FlashSaleItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashSaleItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashSaleItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashSaleItemDto value)  $default,){
final _that = this;
switch (_that) {
case _FlashSaleItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashSaleItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _FlashSaleItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  FlashSaleCampaignDto campaign,  int restaurantId,  int menuItemId,  String menuItemName,  double originalPrice,  double flashSalePrice,  int stockQuantity,  int soldQuantity,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashSaleItemDto() when $default != null:
return $default(_that.id,_that.campaign,_that.restaurantId,_that.menuItemId,_that.menuItemName,_that.originalPrice,_that.flashSalePrice,_that.stockQuantity,_that.soldQuantity,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  FlashSaleCampaignDto campaign,  int restaurantId,  int menuItemId,  String menuItemName,  double originalPrice,  double flashSalePrice,  int stockQuantity,  int soldQuantity,  String status)  $default,) {final _that = this;
switch (_that) {
case _FlashSaleItemDto():
return $default(_that.id,_that.campaign,_that.restaurantId,_that.menuItemId,_that.menuItemName,_that.originalPrice,_that.flashSalePrice,_that.stockQuantity,_that.soldQuantity,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  FlashSaleCampaignDto campaign,  int restaurantId,  int menuItemId,  String menuItemName,  double originalPrice,  double flashSalePrice,  int stockQuantity,  int soldQuantity,  String status)?  $default,) {final _that = this;
switch (_that) {
case _FlashSaleItemDto() when $default != null:
return $default(_that.id,_that.campaign,_that.restaurantId,_that.menuItemId,_that.menuItemName,_that.originalPrice,_that.flashSalePrice,_that.stockQuantity,_that.soldQuantity,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlashSaleItemDto implements FlashSaleItemDto {
  const _FlashSaleItemDto({required this.id, required this.campaign, required this.restaurantId, required this.menuItemId, required this.menuItemName, required this.originalPrice, required this.flashSalePrice, required this.stockQuantity, required this.soldQuantity, required this.status});
  factory _FlashSaleItemDto.fromJson(Map<String, dynamic> json) => _$FlashSaleItemDtoFromJson(json);

@override final  int id;
@override final  FlashSaleCampaignDto campaign;
@override final  int restaurantId;
@override final  int menuItemId;
@override final  String menuItemName;
@override final  double originalPrice;
@override final  double flashSalePrice;
@override final  int stockQuantity;
@override final  int soldQuantity;
@override final  String status;

/// Create a copy of FlashSaleItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashSaleItemDtoCopyWith<_FlashSaleItemDto> get copyWith => __$FlashSaleItemDtoCopyWithImpl<_FlashSaleItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlashSaleItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashSaleItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.flashSalePrice, flashSalePrice) || other.flashSalePrice == flashSalePrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.soldQuantity, soldQuantity) || other.soldQuantity == soldQuantity)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaign,restaurantId,menuItemId,menuItemName,originalPrice,flashSalePrice,stockQuantity,soldQuantity,status);

@override
String toString() {
  return 'FlashSaleItemDto(id: $id, campaign: $campaign, restaurantId: $restaurantId, menuItemId: $menuItemId, menuItemName: $menuItemName, originalPrice: $originalPrice, flashSalePrice: $flashSalePrice, stockQuantity: $stockQuantity, soldQuantity: $soldQuantity, status: $status)';
}


}

/// @nodoc
abstract mixin class _$FlashSaleItemDtoCopyWith<$Res> implements $FlashSaleItemDtoCopyWith<$Res> {
  factory _$FlashSaleItemDtoCopyWith(_FlashSaleItemDto value, $Res Function(_FlashSaleItemDto) _then) = __$FlashSaleItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, FlashSaleCampaignDto campaign, int restaurantId, int menuItemId, String menuItemName, double originalPrice, double flashSalePrice, int stockQuantity, int soldQuantity, String status
});


@override $FlashSaleCampaignDtoCopyWith<$Res> get campaign;

}
/// @nodoc
class __$FlashSaleItemDtoCopyWithImpl<$Res>
    implements _$FlashSaleItemDtoCopyWith<$Res> {
  __$FlashSaleItemDtoCopyWithImpl(this._self, this._then);

  final _FlashSaleItemDto _self;
  final $Res Function(_FlashSaleItemDto) _then;

/// Create a copy of FlashSaleItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaign = null,Object? restaurantId = null,Object? menuItemId = null,Object? menuItemName = null,Object? originalPrice = null,Object? flashSalePrice = null,Object? stockQuantity = null,Object? soldQuantity = null,Object? status = null,}) {
  return _then(_FlashSaleItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,campaign: null == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as FlashSaleCampaignDto,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
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

/// Create a copy of FlashSaleItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FlashSaleCampaignDtoCopyWith<$Res> get campaign {
  
  return $FlashSaleCampaignDtoCopyWith<$Res>(_self.campaign, (value) {
    return _then(_self.copyWith(campaign: value));
  });
}
}

// dart format on
