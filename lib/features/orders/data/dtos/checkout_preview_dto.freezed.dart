// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_preview_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckoutPreviewItemRequest {

 int get menuItemId; int get quantity;
/// Create a copy of CheckoutPreviewItemRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutPreviewItemRequestCopyWith<CheckoutPreviewItemRequest> get copyWith => _$CheckoutPreviewItemRequestCopyWithImpl<CheckoutPreviewItemRequest>(this as CheckoutPreviewItemRequest, _$identity);

  /// Serializes this CheckoutPreviewItemRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPreviewItemRequest&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,quantity);

@override
String toString() {
  return 'CheckoutPreviewItemRequest(menuItemId: $menuItemId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $CheckoutPreviewItemRequestCopyWith<$Res>  {
  factory $CheckoutPreviewItemRequestCopyWith(CheckoutPreviewItemRequest value, $Res Function(CheckoutPreviewItemRequest) _then) = _$CheckoutPreviewItemRequestCopyWithImpl;
@useResult
$Res call({
 int menuItemId, int quantity
});




}
/// @nodoc
class _$CheckoutPreviewItemRequestCopyWithImpl<$Res>
    implements $CheckoutPreviewItemRequestCopyWith<$Res> {
  _$CheckoutPreviewItemRequestCopyWithImpl(this._self, this._then);

  final CheckoutPreviewItemRequest _self;
  final $Res Function(CheckoutPreviewItemRequest) _then;

/// Create a copy of CheckoutPreviewItemRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? menuItemId = null,Object? quantity = null,}) {
  return _then(_self.copyWith(
menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutPreviewItemRequest].
extension CheckoutPreviewItemRequestPatterns on CheckoutPreviewItemRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutPreviewItemRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutPreviewItemRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutPreviewItemRequest value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutPreviewItemRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutPreviewItemRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutPreviewItemRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int menuItemId,  int quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutPreviewItemRequest() when $default != null:
return $default(_that.menuItemId,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int menuItemId,  int quantity)  $default,) {final _that = this;
switch (_that) {
case _CheckoutPreviewItemRequest():
return $default(_that.menuItemId,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int menuItemId,  int quantity)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutPreviewItemRequest() when $default != null:
return $default(_that.menuItemId,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutPreviewItemRequest implements CheckoutPreviewItemRequest {
  const _CheckoutPreviewItemRequest({required this.menuItemId, required this.quantity});
  factory _CheckoutPreviewItemRequest.fromJson(Map<String, dynamic> json) => _$CheckoutPreviewItemRequestFromJson(json);

@override final  int menuItemId;
@override final  int quantity;

/// Create a copy of CheckoutPreviewItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutPreviewItemRequestCopyWith<_CheckoutPreviewItemRequest> get copyWith => __$CheckoutPreviewItemRequestCopyWithImpl<_CheckoutPreviewItemRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutPreviewItemRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutPreviewItemRequest&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,quantity);

@override
String toString() {
  return 'CheckoutPreviewItemRequest(menuItemId: $menuItemId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$CheckoutPreviewItemRequestCopyWith<$Res> implements $CheckoutPreviewItemRequestCopyWith<$Res> {
  factory _$CheckoutPreviewItemRequestCopyWith(_CheckoutPreviewItemRequest value, $Res Function(_CheckoutPreviewItemRequest) _then) = __$CheckoutPreviewItemRequestCopyWithImpl;
@override @useResult
$Res call({
 int menuItemId, int quantity
});




}
/// @nodoc
class __$CheckoutPreviewItemRequestCopyWithImpl<$Res>
    implements _$CheckoutPreviewItemRequestCopyWith<$Res> {
  __$CheckoutPreviewItemRequestCopyWithImpl(this._self, this._then);

  final _CheckoutPreviewItemRequest _self;
  final $Res Function(_CheckoutPreviewItemRequest) _then;

/// Create a copy of CheckoutPreviewItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? menuItemId = null,Object? quantity = null,}) {
  return _then(_CheckoutPreviewItemRequest(
menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CheckoutPreviewRequest {

 int get restaurantId; double? get deliveryLat; double? get deliveryLng; String? get couponCode; List<CheckoutPreviewItemRequest> get items;
/// Create a copy of CheckoutPreviewRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutPreviewRequestCopyWith<CheckoutPreviewRequest> get copyWith => _$CheckoutPreviewRequestCopyWithImpl<CheckoutPreviewRequest>(this as CheckoutPreviewRequest, _$identity);

  /// Serializes this CheckoutPreviewRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPreviewRequest&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.deliveryLat, deliveryLat) || other.deliveryLat == deliveryLat)&&(identical(other.deliveryLng, deliveryLng) || other.deliveryLng == deliveryLng)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restaurantId,deliveryLat,deliveryLng,couponCode,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'CheckoutPreviewRequest(restaurantId: $restaurantId, deliveryLat: $deliveryLat, deliveryLng: $deliveryLng, couponCode: $couponCode, items: $items)';
}


}

/// @nodoc
abstract mixin class $CheckoutPreviewRequestCopyWith<$Res>  {
  factory $CheckoutPreviewRequestCopyWith(CheckoutPreviewRequest value, $Res Function(CheckoutPreviewRequest) _then) = _$CheckoutPreviewRequestCopyWithImpl;
@useResult
$Res call({
 int restaurantId, double? deliveryLat, double? deliveryLng, String? couponCode, List<CheckoutPreviewItemRequest> items
});




}
/// @nodoc
class _$CheckoutPreviewRequestCopyWithImpl<$Res>
    implements $CheckoutPreviewRequestCopyWith<$Res> {
  _$CheckoutPreviewRequestCopyWithImpl(this._self, this._then);

  final CheckoutPreviewRequest _self;
  final $Res Function(CheckoutPreviewRequest) _then;

/// Create a copy of CheckoutPreviewRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? restaurantId = null,Object? deliveryLat = freezed,Object? deliveryLng = freezed,Object? couponCode = freezed,Object? items = null,}) {
  return _then(_self.copyWith(
restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int,deliveryLat: freezed == deliveryLat ? _self.deliveryLat : deliveryLat // ignore: cast_nullable_to_non_nullable
as double?,deliveryLng: freezed == deliveryLng ? _self.deliveryLng : deliveryLng // ignore: cast_nullable_to_non_nullable
as double?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CheckoutPreviewItemRequest>,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutPreviewRequest].
extension CheckoutPreviewRequestPatterns on CheckoutPreviewRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutPreviewRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutPreviewRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutPreviewRequest value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutPreviewRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutPreviewRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutPreviewRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int restaurantId,  double? deliveryLat,  double? deliveryLng,  String? couponCode,  List<CheckoutPreviewItemRequest> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutPreviewRequest() when $default != null:
return $default(_that.restaurantId,_that.deliveryLat,_that.deliveryLng,_that.couponCode,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int restaurantId,  double? deliveryLat,  double? deliveryLng,  String? couponCode,  List<CheckoutPreviewItemRequest> items)  $default,) {final _that = this;
switch (_that) {
case _CheckoutPreviewRequest():
return $default(_that.restaurantId,_that.deliveryLat,_that.deliveryLng,_that.couponCode,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int restaurantId,  double? deliveryLat,  double? deliveryLng,  String? couponCode,  List<CheckoutPreviewItemRequest> items)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutPreviewRequest() when $default != null:
return $default(_that.restaurantId,_that.deliveryLat,_that.deliveryLng,_that.couponCode,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutPreviewRequest implements CheckoutPreviewRequest {
  const _CheckoutPreviewRequest({required this.restaurantId, this.deliveryLat, this.deliveryLng, this.couponCode, required final  List<CheckoutPreviewItemRequest> items}): _items = items;
  factory _CheckoutPreviewRequest.fromJson(Map<String, dynamic> json) => _$CheckoutPreviewRequestFromJson(json);

@override final  int restaurantId;
@override final  double? deliveryLat;
@override final  double? deliveryLng;
@override final  String? couponCode;
 final  List<CheckoutPreviewItemRequest> _items;
@override List<CheckoutPreviewItemRequest> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CheckoutPreviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutPreviewRequestCopyWith<_CheckoutPreviewRequest> get copyWith => __$CheckoutPreviewRequestCopyWithImpl<_CheckoutPreviewRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutPreviewRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutPreviewRequest&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.deliveryLat, deliveryLat) || other.deliveryLat == deliveryLat)&&(identical(other.deliveryLng, deliveryLng) || other.deliveryLng == deliveryLng)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restaurantId,deliveryLat,deliveryLng,couponCode,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CheckoutPreviewRequest(restaurantId: $restaurantId, deliveryLat: $deliveryLat, deliveryLng: $deliveryLng, couponCode: $couponCode, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CheckoutPreviewRequestCopyWith<$Res> implements $CheckoutPreviewRequestCopyWith<$Res> {
  factory _$CheckoutPreviewRequestCopyWith(_CheckoutPreviewRequest value, $Res Function(_CheckoutPreviewRequest) _then) = __$CheckoutPreviewRequestCopyWithImpl;
@override @useResult
$Res call({
 int restaurantId, double? deliveryLat, double? deliveryLng, String? couponCode, List<CheckoutPreviewItemRequest> items
});




}
/// @nodoc
class __$CheckoutPreviewRequestCopyWithImpl<$Res>
    implements _$CheckoutPreviewRequestCopyWith<$Res> {
  __$CheckoutPreviewRequestCopyWithImpl(this._self, this._then);

  final _CheckoutPreviewRequest _self;
  final $Res Function(_CheckoutPreviewRequest) _then;

/// Create a copy of CheckoutPreviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? restaurantId = null,Object? deliveryLat = freezed,Object? deliveryLng = freezed,Object? couponCode = freezed,Object? items = null,}) {
  return _then(_CheckoutPreviewRequest(
restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int,deliveryLat: freezed == deliveryLat ? _self.deliveryLat : deliveryLat // ignore: cast_nullable_to_non_nullable
as double?,deliveryLng: freezed == deliveryLng ? _self.deliveryLng : deliveryLng // ignore: cast_nullable_to_non_nullable
as double?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CheckoutPreviewItemRequest>,
  ));
}


}


/// @nodoc
mixin _$PreviewItemDetail {

 int? get menuItemId; String? get menuItemName; String? get imageUrl; double? get unitPrice; int? get quantity; double? get lineTotal;
/// Create a copy of PreviewItemDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreviewItemDetailCopyWith<PreviewItemDetail> get copyWith => _$PreviewItemDetailCopyWithImpl<PreviewItemDetail>(this as PreviewItemDetail, _$identity);

  /// Serializes this PreviewItemDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreviewItemDetail&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,menuItemName,imageUrl,unitPrice,quantity,lineTotal);

@override
String toString() {
  return 'PreviewItemDetail(menuItemId: $menuItemId, menuItemName: $menuItemName, imageUrl: $imageUrl, unitPrice: $unitPrice, quantity: $quantity, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class $PreviewItemDetailCopyWith<$Res>  {
  factory $PreviewItemDetailCopyWith(PreviewItemDetail value, $Res Function(PreviewItemDetail) _then) = _$PreviewItemDetailCopyWithImpl;
@useResult
$Res call({
 int? menuItemId, String? menuItemName, String? imageUrl, double? unitPrice, int? quantity, double? lineTotal
});




}
/// @nodoc
class _$PreviewItemDetailCopyWithImpl<$Res>
    implements $PreviewItemDetailCopyWith<$Res> {
  _$PreviewItemDetailCopyWithImpl(this._self, this._then);

  final PreviewItemDetail _self;
  final $Res Function(PreviewItemDetail) _then;

/// Create a copy of PreviewItemDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? menuItemId = freezed,Object? menuItemName = freezed,Object? imageUrl = freezed,Object? unitPrice = freezed,Object? quantity = freezed,Object? lineTotal = freezed,}) {
  return _then(_self.copyWith(
menuItemId: freezed == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int?,menuItemName: freezed == menuItemName ? _self.menuItemName : menuItemName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,lineTotal: freezed == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PreviewItemDetail].
extension PreviewItemDetailPatterns on PreviewItemDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreviewItemDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreviewItemDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreviewItemDetail value)  $default,){
final _that = this;
switch (_that) {
case _PreviewItemDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreviewItemDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PreviewItemDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? menuItemId,  String? menuItemName,  String? imageUrl,  double? unitPrice,  int? quantity,  double? lineTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreviewItemDetail() when $default != null:
return $default(_that.menuItemId,_that.menuItemName,_that.imageUrl,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? menuItemId,  String? menuItemName,  String? imageUrl,  double? unitPrice,  int? quantity,  double? lineTotal)  $default,) {final _that = this;
switch (_that) {
case _PreviewItemDetail():
return $default(_that.menuItemId,_that.menuItemName,_that.imageUrl,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? menuItemId,  String? menuItemName,  String? imageUrl,  double? unitPrice,  int? quantity,  double? lineTotal)?  $default,) {final _that = this;
switch (_that) {
case _PreviewItemDetail() when $default != null:
return $default(_that.menuItemId,_that.menuItemName,_that.imageUrl,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreviewItemDetail implements PreviewItemDetail {
  const _PreviewItemDetail({this.menuItemId, this.menuItemName, this.imageUrl, this.unitPrice, this.quantity, this.lineTotal});
  factory _PreviewItemDetail.fromJson(Map<String, dynamic> json) => _$PreviewItemDetailFromJson(json);

@override final  int? menuItemId;
@override final  String? menuItemName;
@override final  String? imageUrl;
@override final  double? unitPrice;
@override final  int? quantity;
@override final  double? lineTotal;

/// Create a copy of PreviewItemDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreviewItemDetailCopyWith<_PreviewItemDetail> get copyWith => __$PreviewItemDetailCopyWithImpl<_PreviewItemDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreviewItemDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreviewItemDetail&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,menuItemName,imageUrl,unitPrice,quantity,lineTotal);

@override
String toString() {
  return 'PreviewItemDetail(menuItemId: $menuItemId, menuItemName: $menuItemName, imageUrl: $imageUrl, unitPrice: $unitPrice, quantity: $quantity, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class _$PreviewItemDetailCopyWith<$Res> implements $PreviewItemDetailCopyWith<$Res> {
  factory _$PreviewItemDetailCopyWith(_PreviewItemDetail value, $Res Function(_PreviewItemDetail) _then) = __$PreviewItemDetailCopyWithImpl;
@override @useResult
$Res call({
 int? menuItemId, String? menuItemName, String? imageUrl, double? unitPrice, int? quantity, double? lineTotal
});




}
/// @nodoc
class __$PreviewItemDetailCopyWithImpl<$Res>
    implements _$PreviewItemDetailCopyWith<$Res> {
  __$PreviewItemDetailCopyWithImpl(this._self, this._then);

  final _PreviewItemDetail _self;
  final $Res Function(_PreviewItemDetail) _then;

/// Create a copy of PreviewItemDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? menuItemId = freezed,Object? menuItemName = freezed,Object? imageUrl = freezed,Object? unitPrice = freezed,Object? quantity = freezed,Object? lineTotal = freezed,}) {
  return _then(_PreviewItemDetail(
menuItemId: freezed == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int?,menuItemName: freezed == menuItemName ? _self.menuItemName : menuItemName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,lineTotal: freezed == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$PriceChangeInfo {

 int? get menuItemId; String? get menuItemName; double? get oldPrice; double? get newPrice;
/// Create a copy of PriceChangeInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceChangeInfoCopyWith<PriceChangeInfo> get copyWith => _$PriceChangeInfoCopyWithImpl<PriceChangeInfo>(this as PriceChangeInfo, _$identity);

  /// Serializes this PriceChangeInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceChangeInfo&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.oldPrice, oldPrice) || other.oldPrice == oldPrice)&&(identical(other.newPrice, newPrice) || other.newPrice == newPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,menuItemName,oldPrice,newPrice);

@override
String toString() {
  return 'PriceChangeInfo(menuItemId: $menuItemId, menuItemName: $menuItemName, oldPrice: $oldPrice, newPrice: $newPrice)';
}


}

/// @nodoc
abstract mixin class $PriceChangeInfoCopyWith<$Res>  {
  factory $PriceChangeInfoCopyWith(PriceChangeInfo value, $Res Function(PriceChangeInfo) _then) = _$PriceChangeInfoCopyWithImpl;
@useResult
$Res call({
 int? menuItemId, String? menuItemName, double? oldPrice, double? newPrice
});




}
/// @nodoc
class _$PriceChangeInfoCopyWithImpl<$Res>
    implements $PriceChangeInfoCopyWith<$Res> {
  _$PriceChangeInfoCopyWithImpl(this._self, this._then);

  final PriceChangeInfo _self;
  final $Res Function(PriceChangeInfo) _then;

/// Create a copy of PriceChangeInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? menuItemId = freezed,Object? menuItemName = freezed,Object? oldPrice = freezed,Object? newPrice = freezed,}) {
  return _then(_self.copyWith(
menuItemId: freezed == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int?,menuItemName: freezed == menuItemName ? _self.menuItemName : menuItemName // ignore: cast_nullable_to_non_nullable
as String?,oldPrice: freezed == oldPrice ? _self.oldPrice : oldPrice // ignore: cast_nullable_to_non_nullable
as double?,newPrice: freezed == newPrice ? _self.newPrice : newPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceChangeInfo].
extension PriceChangeInfoPatterns on PriceChangeInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceChangeInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceChangeInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceChangeInfo value)  $default,){
final _that = this;
switch (_that) {
case _PriceChangeInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceChangeInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PriceChangeInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? menuItemId,  String? menuItemName,  double? oldPrice,  double? newPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceChangeInfo() when $default != null:
return $default(_that.menuItemId,_that.menuItemName,_that.oldPrice,_that.newPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? menuItemId,  String? menuItemName,  double? oldPrice,  double? newPrice)  $default,) {final _that = this;
switch (_that) {
case _PriceChangeInfo():
return $default(_that.menuItemId,_that.menuItemName,_that.oldPrice,_that.newPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? menuItemId,  String? menuItemName,  double? oldPrice,  double? newPrice)?  $default,) {final _that = this;
switch (_that) {
case _PriceChangeInfo() when $default != null:
return $default(_that.menuItemId,_that.menuItemName,_that.oldPrice,_that.newPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriceChangeInfo implements PriceChangeInfo {
  const _PriceChangeInfo({this.menuItemId, this.menuItemName, this.oldPrice, this.newPrice});
  factory _PriceChangeInfo.fromJson(Map<String, dynamic> json) => _$PriceChangeInfoFromJson(json);

@override final  int? menuItemId;
@override final  String? menuItemName;
@override final  double? oldPrice;
@override final  double? newPrice;

/// Create a copy of PriceChangeInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceChangeInfoCopyWith<_PriceChangeInfo> get copyWith => __$PriceChangeInfoCopyWithImpl<_PriceChangeInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriceChangeInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceChangeInfo&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.menuItemName, menuItemName) || other.menuItemName == menuItemName)&&(identical(other.oldPrice, oldPrice) || other.oldPrice == oldPrice)&&(identical(other.newPrice, newPrice) || other.newPrice == newPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,menuItemName,oldPrice,newPrice);

@override
String toString() {
  return 'PriceChangeInfo(menuItemId: $menuItemId, menuItemName: $menuItemName, oldPrice: $oldPrice, newPrice: $newPrice)';
}


}

/// @nodoc
abstract mixin class _$PriceChangeInfoCopyWith<$Res> implements $PriceChangeInfoCopyWith<$Res> {
  factory _$PriceChangeInfoCopyWith(_PriceChangeInfo value, $Res Function(_PriceChangeInfo) _then) = __$PriceChangeInfoCopyWithImpl;
@override @useResult
$Res call({
 int? menuItemId, String? menuItemName, double? oldPrice, double? newPrice
});




}
/// @nodoc
class __$PriceChangeInfoCopyWithImpl<$Res>
    implements _$PriceChangeInfoCopyWith<$Res> {
  __$PriceChangeInfoCopyWithImpl(this._self, this._then);

  final _PriceChangeInfo _self;
  final $Res Function(_PriceChangeInfo) _then;

/// Create a copy of PriceChangeInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? menuItemId = freezed,Object? menuItemName = freezed,Object? oldPrice = freezed,Object? newPrice = freezed,}) {
  return _then(_PriceChangeInfo(
menuItemId: freezed == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int?,menuItemName: freezed == menuItemName ? _self.menuItemName : menuItemName // ignore: cast_nullable_to_non_nullable
as String?,oldPrice: freezed == oldPrice ? _self.oldPrice : oldPrice // ignore: cast_nullable_to_non_nullable
as double?,newPrice: freezed == newPrice ? _self.newPrice : newPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$CheckoutPreviewResponse {

 int? get restaurantId; String? get restaurantName; List<PreviewItemDetail>? get items; double? get subtotal; double? get shippingFee; double? get discountAmount; double? get totalPrice; String? get couponCode; String? get couponMessage; List<PriceChangeInfo>? get priceChanges; List<int>? get unavailableItemIds;
/// Create a copy of CheckoutPreviewResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutPreviewResponseCopyWith<CheckoutPreviewResponse> get copyWith => _$CheckoutPreviewResponseCopyWithImpl<CheckoutPreviewResponse>(this as CheckoutPreviewResponse, _$identity);

  /// Serializes this CheckoutPreviewResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPreviewResponse&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.shippingFee, shippingFee) || other.shippingFee == shippingFee)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.couponMessage, couponMessage) || other.couponMessage == couponMessage)&&const DeepCollectionEquality().equals(other.priceChanges, priceChanges)&&const DeepCollectionEquality().equals(other.unavailableItemIds, unavailableItemIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restaurantId,restaurantName,const DeepCollectionEquality().hash(items),subtotal,shippingFee,discountAmount,totalPrice,couponCode,couponMessage,const DeepCollectionEquality().hash(priceChanges),const DeepCollectionEquality().hash(unavailableItemIds));

@override
String toString() {
  return 'CheckoutPreviewResponse(restaurantId: $restaurantId, restaurantName: $restaurantName, items: $items, subtotal: $subtotal, shippingFee: $shippingFee, discountAmount: $discountAmount, totalPrice: $totalPrice, couponCode: $couponCode, couponMessage: $couponMessage, priceChanges: $priceChanges, unavailableItemIds: $unavailableItemIds)';
}


}

/// @nodoc
abstract mixin class $CheckoutPreviewResponseCopyWith<$Res>  {
  factory $CheckoutPreviewResponseCopyWith(CheckoutPreviewResponse value, $Res Function(CheckoutPreviewResponse) _then) = _$CheckoutPreviewResponseCopyWithImpl;
@useResult
$Res call({
 int? restaurantId, String? restaurantName, List<PreviewItemDetail>? items, double? subtotal, double? shippingFee, double? discountAmount, double? totalPrice, String? couponCode, String? couponMessage, List<PriceChangeInfo>? priceChanges, List<int>? unavailableItemIds
});




}
/// @nodoc
class _$CheckoutPreviewResponseCopyWithImpl<$Res>
    implements $CheckoutPreviewResponseCopyWith<$Res> {
  _$CheckoutPreviewResponseCopyWithImpl(this._self, this._then);

  final CheckoutPreviewResponse _self;
  final $Res Function(CheckoutPreviewResponse) _then;

/// Create a copy of CheckoutPreviewResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? restaurantId = freezed,Object? restaurantName = freezed,Object? items = freezed,Object? subtotal = freezed,Object? shippingFee = freezed,Object? discountAmount = freezed,Object? totalPrice = freezed,Object? couponCode = freezed,Object? couponMessage = freezed,Object? priceChanges = freezed,Object? unavailableItemIds = freezed,}) {
  return _then(_self.copyWith(
restaurantId: freezed == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int?,restaurantName: freezed == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PreviewItemDetail>?,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,shippingFee: freezed == shippingFee ? _self.shippingFee : shippingFee // ignore: cast_nullable_to_non_nullable
as double?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,couponMessage: freezed == couponMessage ? _self.couponMessage : couponMessage // ignore: cast_nullable_to_non_nullable
as String?,priceChanges: freezed == priceChanges ? _self.priceChanges : priceChanges // ignore: cast_nullable_to_non_nullable
as List<PriceChangeInfo>?,unavailableItemIds: freezed == unavailableItemIds ? _self.unavailableItemIds : unavailableItemIds // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutPreviewResponse].
extension CheckoutPreviewResponsePatterns on CheckoutPreviewResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutPreviewResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutPreviewResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutPreviewResponse value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutPreviewResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutPreviewResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutPreviewResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? restaurantId,  String? restaurantName,  List<PreviewItemDetail>? items,  double? subtotal,  double? shippingFee,  double? discountAmount,  double? totalPrice,  String? couponCode,  String? couponMessage,  List<PriceChangeInfo>? priceChanges,  List<int>? unavailableItemIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutPreviewResponse() when $default != null:
return $default(_that.restaurantId,_that.restaurantName,_that.items,_that.subtotal,_that.shippingFee,_that.discountAmount,_that.totalPrice,_that.couponCode,_that.couponMessage,_that.priceChanges,_that.unavailableItemIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? restaurantId,  String? restaurantName,  List<PreviewItemDetail>? items,  double? subtotal,  double? shippingFee,  double? discountAmount,  double? totalPrice,  String? couponCode,  String? couponMessage,  List<PriceChangeInfo>? priceChanges,  List<int>? unavailableItemIds)  $default,) {final _that = this;
switch (_that) {
case _CheckoutPreviewResponse():
return $default(_that.restaurantId,_that.restaurantName,_that.items,_that.subtotal,_that.shippingFee,_that.discountAmount,_that.totalPrice,_that.couponCode,_that.couponMessage,_that.priceChanges,_that.unavailableItemIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? restaurantId,  String? restaurantName,  List<PreviewItemDetail>? items,  double? subtotal,  double? shippingFee,  double? discountAmount,  double? totalPrice,  String? couponCode,  String? couponMessage,  List<PriceChangeInfo>? priceChanges,  List<int>? unavailableItemIds)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutPreviewResponse() when $default != null:
return $default(_that.restaurantId,_that.restaurantName,_that.items,_that.subtotal,_that.shippingFee,_that.discountAmount,_that.totalPrice,_that.couponCode,_that.couponMessage,_that.priceChanges,_that.unavailableItemIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutPreviewResponse implements CheckoutPreviewResponse {
  const _CheckoutPreviewResponse({this.restaurantId, this.restaurantName, final  List<PreviewItemDetail>? items, this.subtotal, this.shippingFee, this.discountAmount, this.totalPrice, this.couponCode, this.couponMessage, final  List<PriceChangeInfo>? priceChanges, final  List<int>? unavailableItemIds}): _items = items,_priceChanges = priceChanges,_unavailableItemIds = unavailableItemIds;
  factory _CheckoutPreviewResponse.fromJson(Map<String, dynamic> json) => _$CheckoutPreviewResponseFromJson(json);

@override final  int? restaurantId;
@override final  String? restaurantName;
 final  List<PreviewItemDetail>? _items;
@override List<PreviewItemDetail>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  double? subtotal;
@override final  double? shippingFee;
@override final  double? discountAmount;
@override final  double? totalPrice;
@override final  String? couponCode;
@override final  String? couponMessage;
 final  List<PriceChangeInfo>? _priceChanges;
@override List<PriceChangeInfo>? get priceChanges {
  final value = _priceChanges;
  if (value == null) return null;
  if (_priceChanges is EqualUnmodifiableListView) return _priceChanges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<int>? _unavailableItemIds;
@override List<int>? get unavailableItemIds {
  final value = _unavailableItemIds;
  if (value == null) return null;
  if (_unavailableItemIds is EqualUnmodifiableListView) return _unavailableItemIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CheckoutPreviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutPreviewResponseCopyWith<_CheckoutPreviewResponse> get copyWith => __$CheckoutPreviewResponseCopyWithImpl<_CheckoutPreviewResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutPreviewResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutPreviewResponse&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.shippingFee, shippingFee) || other.shippingFee == shippingFee)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.couponMessage, couponMessage) || other.couponMessage == couponMessage)&&const DeepCollectionEquality().equals(other._priceChanges, _priceChanges)&&const DeepCollectionEquality().equals(other._unavailableItemIds, _unavailableItemIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restaurantId,restaurantName,const DeepCollectionEquality().hash(_items),subtotal,shippingFee,discountAmount,totalPrice,couponCode,couponMessage,const DeepCollectionEquality().hash(_priceChanges),const DeepCollectionEquality().hash(_unavailableItemIds));

@override
String toString() {
  return 'CheckoutPreviewResponse(restaurantId: $restaurantId, restaurantName: $restaurantName, items: $items, subtotal: $subtotal, shippingFee: $shippingFee, discountAmount: $discountAmount, totalPrice: $totalPrice, couponCode: $couponCode, couponMessage: $couponMessage, priceChanges: $priceChanges, unavailableItemIds: $unavailableItemIds)';
}


}

/// @nodoc
abstract mixin class _$CheckoutPreviewResponseCopyWith<$Res> implements $CheckoutPreviewResponseCopyWith<$Res> {
  factory _$CheckoutPreviewResponseCopyWith(_CheckoutPreviewResponse value, $Res Function(_CheckoutPreviewResponse) _then) = __$CheckoutPreviewResponseCopyWithImpl;
@override @useResult
$Res call({
 int? restaurantId, String? restaurantName, List<PreviewItemDetail>? items, double? subtotal, double? shippingFee, double? discountAmount, double? totalPrice, String? couponCode, String? couponMessage, List<PriceChangeInfo>? priceChanges, List<int>? unavailableItemIds
});




}
/// @nodoc
class __$CheckoutPreviewResponseCopyWithImpl<$Res>
    implements _$CheckoutPreviewResponseCopyWith<$Res> {
  __$CheckoutPreviewResponseCopyWithImpl(this._self, this._then);

  final _CheckoutPreviewResponse _self;
  final $Res Function(_CheckoutPreviewResponse) _then;

/// Create a copy of CheckoutPreviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? restaurantId = freezed,Object? restaurantName = freezed,Object? items = freezed,Object? subtotal = freezed,Object? shippingFee = freezed,Object? discountAmount = freezed,Object? totalPrice = freezed,Object? couponCode = freezed,Object? couponMessage = freezed,Object? priceChanges = freezed,Object? unavailableItemIds = freezed,}) {
  return _then(_CheckoutPreviewResponse(
restaurantId: freezed == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int?,restaurantName: freezed == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PreviewItemDetail>?,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,shippingFee: freezed == shippingFee ? _self.shippingFee : shippingFee // ignore: cast_nullable_to_non_nullable
as double?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,couponMessage: freezed == couponMessage ? _self.couponMessage : couponMessage // ignore: cast_nullable_to_non_nullable
as String?,priceChanges: freezed == priceChanges ? _self._priceChanges : priceChanges // ignore: cast_nullable_to_non_nullable
as List<PriceChangeInfo>?,unavailableItemIds: freezed == unavailableItemIds ? _self._unavailableItemIds : unavailableItemIds // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

// dart format on
