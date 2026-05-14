// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flash_sale_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FlashSaleCampaign {

 int get id; String get name; bool get isRecurring; String get startTime; String get endTime;
/// Create a copy of FlashSaleCampaign
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashSaleCampaignCopyWith<FlashSaleCampaign> get copyWith => _$FlashSaleCampaignCopyWithImpl<FlashSaleCampaign>(this as FlashSaleCampaign, _$identity);

  /// Serializes this FlashSaleCampaign to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashSaleCampaign&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isRecurring,startTime,endTime);

@override
String toString() {
  return 'FlashSaleCampaign(id: $id, name: $name, isRecurring: $isRecurring, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $FlashSaleCampaignCopyWith<$Res>  {
  factory $FlashSaleCampaignCopyWith(FlashSaleCampaign value, $Res Function(FlashSaleCampaign) _then) = _$FlashSaleCampaignCopyWithImpl;
@useResult
$Res call({
 int id, String name, bool isRecurring, String startTime, String endTime
});




}
/// @nodoc
class _$FlashSaleCampaignCopyWithImpl<$Res>
    implements $FlashSaleCampaignCopyWith<$Res> {
  _$FlashSaleCampaignCopyWithImpl(this._self, this._then);

  final FlashSaleCampaign _self;
  final $Res Function(FlashSaleCampaign) _then;

/// Create a copy of FlashSaleCampaign
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isRecurring = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashSaleCampaign].
extension FlashSaleCampaignPatterns on FlashSaleCampaign {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashSaleCampaign value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashSaleCampaign() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashSaleCampaign value)  $default,){
final _that = this;
switch (_that) {
case _FlashSaleCampaign():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashSaleCampaign value)?  $default,){
final _that = this;
switch (_that) {
case _FlashSaleCampaign() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  bool isRecurring,  String startTime,  String endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashSaleCampaign() when $default != null:
return $default(_that.id,_that.name,_that.isRecurring,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  bool isRecurring,  String startTime,  String endTime)  $default,) {final _that = this;
switch (_that) {
case _FlashSaleCampaign():
return $default(_that.id,_that.name,_that.isRecurring,_that.startTime,_that.endTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  bool isRecurring,  String startTime,  String endTime)?  $default,) {final _that = this;
switch (_that) {
case _FlashSaleCampaign() when $default != null:
return $default(_that.id,_that.name,_that.isRecurring,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlashSaleCampaign implements FlashSaleCampaign {
  const _FlashSaleCampaign({required this.id, required this.name, required this.isRecurring, required this.startTime, required this.endTime});
  factory _FlashSaleCampaign.fromJson(Map<String, dynamic> json) => _$FlashSaleCampaignFromJson(json);

@override final  int id;
@override final  String name;
@override final  bool isRecurring;
@override final  String startTime;
@override final  String endTime;

/// Create a copy of FlashSaleCampaign
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashSaleCampaignCopyWith<_FlashSaleCampaign> get copyWith => __$FlashSaleCampaignCopyWithImpl<_FlashSaleCampaign>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlashSaleCampaignToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashSaleCampaign&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isRecurring,startTime,endTime);

@override
String toString() {
  return 'FlashSaleCampaign(id: $id, name: $name, isRecurring: $isRecurring, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$FlashSaleCampaignCopyWith<$Res> implements $FlashSaleCampaignCopyWith<$Res> {
  factory _$FlashSaleCampaignCopyWith(_FlashSaleCampaign value, $Res Function(_FlashSaleCampaign) _then) = __$FlashSaleCampaignCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, bool isRecurring, String startTime, String endTime
});




}
/// @nodoc
class __$FlashSaleCampaignCopyWithImpl<$Res>
    implements _$FlashSaleCampaignCopyWith<$Res> {
  __$FlashSaleCampaignCopyWithImpl(this._self, this._then);

  final _FlashSaleCampaign _self;
  final $Res Function(_FlashSaleCampaign) _then;

/// Create a copy of FlashSaleCampaign
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isRecurring = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_FlashSaleCampaign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FlashSaleItem {

 int get id; FlashSaleCampaign get campaign; int get restaurantId; int get menuItemId; String get menuItemName; double get originalPrice; double get flashSalePrice; int get stockQuantity; int get soldQuantity; String get status;
/// Create a copy of FlashSaleItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashSaleItemCopyWith<FlashSaleItem> get copyWith => _$FlashSaleItemCopyWithImpl<FlashSaleItem>(this as FlashSaleItem, _$identity);

  /// Serializes this FlashSaleItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashSaleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.flashSalePrice, flashSalePrice) || other.flashSalePrice == flashSalePrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.soldQuantity, soldQuantity) || other.soldQuantity == soldQuantity)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaign,restaurantId,menuItemId,menuItemName,originalPrice,flashSalePrice,stockQuantity,soldQuantity,status);

@override
String toString() {
  return 'FlashSaleItem(id: $id, campaign: $campaign, restaurantId: $restaurantId, menuItemId: $menuItemId, menuItemName: $menuItemName, originalPrice: $originalPrice, flashSalePrice: $flashSalePrice, stockQuantity: $stockQuantity, soldQuantity: $soldQuantity, status: $status)';
}


}

/// @nodoc
abstract mixin class $FlashSaleItemCopyWith<$Res>  {
  factory $FlashSaleItemCopyWith(FlashSaleItem value, $Res Function(FlashSaleItem) _then) = _$FlashSaleItemCopyWithImpl;
@useResult
$Res call({
 int id, FlashSaleCampaign campaign, int restaurantId, int menuItemId, String menuItemName, double originalPrice, double flashSalePrice, int stockQuantity, int soldQuantity, String status
});


$FlashSaleCampaignCopyWith<$Res> get campaign;

}
/// @nodoc
class _$FlashSaleItemCopyWithImpl<$Res>
    implements $FlashSaleItemCopyWith<$Res> {
  _$FlashSaleItemCopyWithImpl(this._self, this._then);

  final FlashSaleItem _self;
  final $Res Function(FlashSaleItem) _then;

/// Create a copy of FlashSaleItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaign = null,Object? restaurantId = null,Object? menuItemId = null,Object? menuItemName = null,Object? originalPrice = null,Object? flashSalePrice = null,Object? stockQuantity = null,Object? soldQuantity = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,campaign: null == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as FlashSaleCampaign,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
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
/// Create a copy of FlashSaleItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FlashSaleCampaignCopyWith<$Res> get campaign {
  
  return $FlashSaleCampaignCopyWith<$Res>(_self.campaign, (value) {
    return _then(_self.copyWith(campaign: value));
  });
}
}


/// Adds pattern-matching-related methods to [FlashSaleItem].
extension FlashSaleItemPatterns on FlashSaleItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashSaleItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashSaleItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashSaleItem value)  $default,){
final _that = this;
switch (_that) {
case _FlashSaleItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashSaleItem value)?  $default,){
final _that = this;
switch (_that) {
case _FlashSaleItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  FlashSaleCampaign campaign,  int restaurantId,  int menuItemId,  String menuItemName,  double originalPrice,  double flashSalePrice,  int stockQuantity,  int soldQuantity,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashSaleItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  FlashSaleCampaign campaign,  int restaurantId,  int menuItemId,  String menuItemName,  double originalPrice,  double flashSalePrice,  int stockQuantity,  int soldQuantity,  String status)  $default,) {final _that = this;
switch (_that) {
case _FlashSaleItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  FlashSaleCampaign campaign,  int restaurantId,  int menuItemId,  String menuItemName,  double originalPrice,  double flashSalePrice,  int stockQuantity,  int soldQuantity,  String status)?  $default,) {final _that = this;
switch (_that) {
case _FlashSaleItem() when $default != null:
return $default(_that.id,_that.campaign,_that.restaurantId,_that.menuItemId,_that.menuItemName,_that.originalPrice,_that.flashSalePrice,_that.stockQuantity,_that.soldQuantity,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlashSaleItem extends FlashSaleItem {
  const _FlashSaleItem({required this.id, required this.campaign, required this.restaurantId, required this.menuItemId, required this.menuItemName, required this.originalPrice, required this.flashSalePrice, required this.stockQuantity, required this.soldQuantity, required this.status}): super._();
  factory _FlashSaleItem.fromJson(Map<String, dynamic> json) => _$FlashSaleItemFromJson(json);

@override final  int id;
@override final  FlashSaleCampaign campaign;
@override final  int restaurantId;
@override final  int menuItemId;
@override final  String menuItemName;
@override final  double originalPrice;
@override final  double flashSalePrice;
@override final  int stockQuantity;
@override final  int soldQuantity;
@override final  String status;

/// Create a copy of FlashSaleItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashSaleItemCopyWith<_FlashSaleItem> get copyWith => __$FlashSaleItemCopyWithImpl<_FlashSaleItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlashSaleItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashSaleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.flashSalePrice, flashSalePrice) || other.flashSalePrice == flashSalePrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.soldQuantity, soldQuantity) || other.soldQuantity == soldQuantity)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaign,restaurantId,menuItemId,menuItemName,originalPrice,flashSalePrice,stockQuantity,soldQuantity,status);

@override
String toString() {
  return 'FlashSaleItem(id: $id, campaign: $campaign, restaurantId: $restaurantId, menuItemId: $menuItemId, menuItemName: $menuItemName, originalPrice: $originalPrice, flashSalePrice: $flashSalePrice, stockQuantity: $stockQuantity, soldQuantity: $soldQuantity, status: $status)';
}


}

/// @nodoc
abstract mixin class _$FlashSaleItemCopyWith<$Res> implements $FlashSaleItemCopyWith<$Res> {
  factory _$FlashSaleItemCopyWith(_FlashSaleItem value, $Res Function(_FlashSaleItem) _then) = __$FlashSaleItemCopyWithImpl;
@override @useResult
$Res call({
 int id, FlashSaleCampaign campaign, int restaurantId, int menuItemId, String menuItemName, double originalPrice, double flashSalePrice, int stockQuantity, int soldQuantity, String status
});


@override $FlashSaleCampaignCopyWith<$Res> get campaign;

}
/// @nodoc
class __$FlashSaleItemCopyWithImpl<$Res>
    implements _$FlashSaleItemCopyWith<$Res> {
  __$FlashSaleItemCopyWithImpl(this._self, this._then);

  final _FlashSaleItem _self;
  final $Res Function(_FlashSaleItem) _then;

/// Create a copy of FlashSaleItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaign = null,Object? restaurantId = null,Object? menuItemId = null,Object? menuItemName = null,Object? originalPrice = null,Object? flashSalePrice = null,Object? stockQuantity = null,Object? soldQuantity = null,Object? status = null,}) {
  return _then(_FlashSaleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,campaign: null == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as FlashSaleCampaign,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
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

/// Create a copy of FlashSaleItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FlashSaleCampaignCopyWith<$Res> get campaign {
  
  return $FlashSaleCampaignCopyWith<$Res>(_self.campaign, (value) {
    return _then(_self.copyWith(campaign: value));
  });
}
}

// dart format on
