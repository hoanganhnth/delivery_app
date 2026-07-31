// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_order_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderItemRequest {

 int get menuItemId; int get quantity; String? get notes; int? get flashSaleItemId;
/// Create a copy of OrderItemRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemRequestCopyWith<OrderItemRequest> get copyWith => _$OrderItemRequestCopyWithImpl<OrderItemRequest>(this as OrderItemRequest, _$identity);

  /// Serializes this OrderItemRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItemRequest&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.flashSaleItemId, flashSaleItemId) || other.flashSaleItemId == flashSaleItemId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,quantity,notes,flashSaleItemId);

@override
String toString() {
  return 'OrderItemRequest(menuItemId: $menuItemId, quantity: $quantity, notes: $notes, flashSaleItemId: $flashSaleItemId)';
}


}

/// @nodoc
abstract mixin class $OrderItemRequestCopyWith<$Res>  {
  factory $OrderItemRequestCopyWith(OrderItemRequest value, $Res Function(OrderItemRequest) _then) = _$OrderItemRequestCopyWithImpl;
@useResult
$Res call({
 int menuItemId, int quantity, String? notes, int? flashSaleItemId
});




}
/// @nodoc
class _$OrderItemRequestCopyWithImpl<$Res>
    implements $OrderItemRequestCopyWith<$Res> {
  _$OrderItemRequestCopyWithImpl(this._self, this._then);

  final OrderItemRequest _self;
  final $Res Function(OrderItemRequest) _then;

/// Create a copy of OrderItemRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? menuItemId = null,Object? quantity = null,Object? notes = freezed,Object? flashSaleItemId = freezed,}) {
  return _then(_self.copyWith(
menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,flashSaleItemId: freezed == flashSaleItemId ? _self.flashSaleItemId : flashSaleItemId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderItemRequest].
extension OrderItemRequestPatterns on OrderItemRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItemRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItemRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItemRequest value)  $default,){
final _that = this;
switch (_that) {
case _OrderItemRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItemRequest value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItemRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int menuItemId,  int quantity,  String? notes,  int? flashSaleItemId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItemRequest() when $default != null:
return $default(_that.menuItemId,_that.quantity,_that.notes,_that.flashSaleItemId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int menuItemId,  int quantity,  String? notes,  int? flashSaleItemId)  $default,) {final _that = this;
switch (_that) {
case _OrderItemRequest():
return $default(_that.menuItemId,_that.quantity,_that.notes,_that.flashSaleItemId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int menuItemId,  int quantity,  String? notes,  int? flashSaleItemId)?  $default,) {final _that = this;
switch (_that) {
case _OrderItemRequest() when $default != null:
return $default(_that.menuItemId,_that.quantity,_that.notes,_that.flashSaleItemId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderItemRequest implements OrderItemRequest {
  const _OrderItemRequest({required this.menuItemId, required this.quantity, this.notes, this.flashSaleItemId});
  factory _OrderItemRequest.fromJson(Map<String, dynamic> json) => _$OrderItemRequestFromJson(json);

@override final  int menuItemId;
@override final  int quantity;
@override final  String? notes;
@override final  int? flashSaleItemId;

/// Create a copy of OrderItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemRequestCopyWith<_OrderItemRequest> get copyWith => __$OrderItemRequestCopyWithImpl<_OrderItemRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderItemRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItemRequest&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.flashSaleItemId, flashSaleItemId) || other.flashSaleItemId == flashSaleItemId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,menuItemId,quantity,notes,flashSaleItemId);

@override
String toString() {
  return 'OrderItemRequest(menuItemId: $menuItemId, quantity: $quantity, notes: $notes, flashSaleItemId: $flashSaleItemId)';
}


}

/// @nodoc
abstract mixin class _$OrderItemRequestCopyWith<$Res> implements $OrderItemRequestCopyWith<$Res> {
  factory _$OrderItemRequestCopyWith(_OrderItemRequest value, $Res Function(_OrderItemRequest) _then) = __$OrderItemRequestCopyWithImpl;
@override @useResult
$Res call({
 int menuItemId, int quantity, String? notes, int? flashSaleItemId
});




}
/// @nodoc
class __$OrderItemRequestCopyWithImpl<$Res>
    implements _$OrderItemRequestCopyWith<$Res> {
  __$OrderItemRequestCopyWithImpl(this._self, this._then);

  final _OrderItemRequest _self;
  final $Res Function(_OrderItemRequest) _then;

/// Create a copy of OrderItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? menuItemId = null,Object? quantity = null,Object? notes = freezed,Object? flashSaleItemId = freezed,}) {
  return _then(_OrderItemRequest(
menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,flashSaleItemId: freezed == flashSaleItemId ? _self.flashSaleItemId : flashSaleItemId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CreateOrderRequestDto {

 int get restaurantId; String get deliveryAddress; double get deliveryLat; double get deliveryLng; String get customerName; String get customerPhone; String get paymentMethod;// COD-only in the current MVP
 String? get notes; List<int>? get voucherIds; List<OrderItemRequest> get items;
/// Create a copy of CreateOrderRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOrderRequestDtoCopyWith<CreateOrderRequestDto> get copyWith => _$CreateOrderRequestDtoCopyWithImpl<CreateOrderRequestDto>(this as CreateOrderRequestDto, _$identity);

  /// Serializes this CreateOrderRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOrderRequestDto&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.deliveryLat, deliveryLat) || other.deliveryLat == deliveryLat)&&(identical(other.deliveryLng, deliveryLng) || other.deliveryLng == deliveryLng)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.voucherIds, voucherIds)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restaurantId,deliveryAddress,deliveryLat,deliveryLng,customerName,customerPhone,paymentMethod,notes,const DeepCollectionEquality().hash(voucherIds),const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'CreateOrderRequestDto(restaurantId: $restaurantId, deliveryAddress: $deliveryAddress, deliveryLat: $deliveryLat, deliveryLng: $deliveryLng, customerName: $customerName, customerPhone: $customerPhone, paymentMethod: $paymentMethod, notes: $notes, voucherIds: $voucherIds, items: $items)';
}


}

/// @nodoc
abstract mixin class $CreateOrderRequestDtoCopyWith<$Res>  {
  factory $CreateOrderRequestDtoCopyWith(CreateOrderRequestDto value, $Res Function(CreateOrderRequestDto) _then) = _$CreateOrderRequestDtoCopyWithImpl;
@useResult
$Res call({
 int restaurantId, String deliveryAddress, double deliveryLat, double deliveryLng, String customerName, String customerPhone, String paymentMethod, String? notes, List<int>? voucherIds, List<OrderItemRequest> items
});




}
/// @nodoc
class _$CreateOrderRequestDtoCopyWithImpl<$Res>
    implements $CreateOrderRequestDtoCopyWith<$Res> {
  _$CreateOrderRequestDtoCopyWithImpl(this._self, this._then);

  final CreateOrderRequestDto _self;
  final $Res Function(CreateOrderRequestDto) _then;

/// Create a copy of CreateOrderRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? restaurantId = null,Object? deliveryAddress = null,Object? deliveryLat = null,Object? deliveryLng = null,Object? customerName = null,Object? customerPhone = null,Object? paymentMethod = null,Object? notes = freezed,Object? voucherIds = freezed,Object? items = null,}) {
  return _then(_self.copyWith(
restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,deliveryLat: null == deliveryLat ? _self.deliveryLat : deliveryLat // ignore: cast_nullable_to_non_nullable
as double,deliveryLng: null == deliveryLng ? _self.deliveryLng : deliveryLng // ignore: cast_nullable_to_non_nullable
as double,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,voucherIds: freezed == voucherIds ? _self.voucherIds : voucherIds // ignore: cast_nullable_to_non_nullable
as List<int>?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItemRequest>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateOrderRequestDto].
extension CreateOrderRequestDtoPatterns on CreateOrderRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateOrderRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateOrderRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateOrderRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateOrderRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateOrderRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateOrderRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int restaurantId,  String deliveryAddress,  double deliveryLat,  double deliveryLng,  String customerName,  String customerPhone,  String paymentMethod,  String? notes,  List<int>? voucherIds,  List<OrderItemRequest> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateOrderRequestDto() when $default != null:
return $default(_that.restaurantId,_that.deliveryAddress,_that.deliveryLat,_that.deliveryLng,_that.customerName,_that.customerPhone,_that.paymentMethod,_that.notes,_that.voucherIds,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int restaurantId,  String deliveryAddress,  double deliveryLat,  double deliveryLng,  String customerName,  String customerPhone,  String paymentMethod,  String? notes,  List<int>? voucherIds,  List<OrderItemRequest> items)  $default,) {final _that = this;
switch (_that) {
case _CreateOrderRequestDto():
return $default(_that.restaurantId,_that.deliveryAddress,_that.deliveryLat,_that.deliveryLng,_that.customerName,_that.customerPhone,_that.paymentMethod,_that.notes,_that.voucherIds,_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int restaurantId,  String deliveryAddress,  double deliveryLat,  double deliveryLng,  String customerName,  String customerPhone,  String paymentMethod,  String? notes,  List<int>? voucherIds,  List<OrderItemRequest> items)?  $default,) {final _that = this;
switch (_that) {
case _CreateOrderRequestDto() when $default != null:
return $default(_that.restaurantId,_that.deliveryAddress,_that.deliveryLat,_that.deliveryLng,_that.customerName,_that.customerPhone,_that.paymentMethod,_that.notes,_that.voucherIds,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateOrderRequestDto implements CreateOrderRequestDto {
  const _CreateOrderRequestDto({required this.restaurantId, required this.deliveryAddress, required this.deliveryLat, required this.deliveryLng, required this.customerName, required this.customerPhone, required this.paymentMethod, this.notes, final  List<int>? voucherIds, required final  List<OrderItemRequest> items}): _voucherIds = voucherIds,_items = items;
  factory _CreateOrderRequestDto.fromJson(Map<String, dynamic> json) => _$CreateOrderRequestDtoFromJson(json);

@override final  int restaurantId;
@override final  String deliveryAddress;
@override final  double deliveryLat;
@override final  double deliveryLng;
@override final  String customerName;
@override final  String customerPhone;
@override final  String paymentMethod;
// COD-only in the current MVP
@override final  String? notes;
 final  List<int>? _voucherIds;
@override List<int>? get voucherIds {
  final value = _voucherIds;
  if (value == null) return null;
  if (_voucherIds is EqualUnmodifiableListView) return _voucherIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<OrderItemRequest> _items;
@override List<OrderItemRequest> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CreateOrderRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateOrderRequestDtoCopyWith<_CreateOrderRequestDto> get copyWith => __$CreateOrderRequestDtoCopyWithImpl<_CreateOrderRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateOrderRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateOrderRequestDto&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.deliveryLat, deliveryLat) || other.deliveryLat == deliveryLat)&&(identical(other.deliveryLng, deliveryLng) || other.deliveryLng == deliveryLng)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._voucherIds, _voucherIds)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,restaurantId,deliveryAddress,deliveryLat,deliveryLng,customerName,customerPhone,paymentMethod,notes,const DeepCollectionEquality().hash(_voucherIds),const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CreateOrderRequestDto(restaurantId: $restaurantId, deliveryAddress: $deliveryAddress, deliveryLat: $deliveryLat, deliveryLng: $deliveryLng, customerName: $customerName, customerPhone: $customerPhone, paymentMethod: $paymentMethod, notes: $notes, voucherIds: $voucherIds, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CreateOrderRequestDtoCopyWith<$Res> implements $CreateOrderRequestDtoCopyWith<$Res> {
  factory _$CreateOrderRequestDtoCopyWith(_CreateOrderRequestDto value, $Res Function(_CreateOrderRequestDto) _then) = __$CreateOrderRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 int restaurantId, String deliveryAddress, double deliveryLat, double deliveryLng, String customerName, String customerPhone, String paymentMethod, String? notes, List<int>? voucherIds, List<OrderItemRequest> items
});




}
/// @nodoc
class __$CreateOrderRequestDtoCopyWithImpl<$Res>
    implements _$CreateOrderRequestDtoCopyWith<$Res> {
  __$CreateOrderRequestDtoCopyWithImpl(this._self, this._then);

  final _CreateOrderRequestDto _self;
  final $Res Function(_CreateOrderRequestDto) _then;

/// Create a copy of CreateOrderRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? restaurantId = null,Object? deliveryAddress = null,Object? deliveryLat = null,Object? deliveryLng = null,Object? customerName = null,Object? customerPhone = null,Object? paymentMethod = null,Object? notes = freezed,Object? voucherIds = freezed,Object? items = null,}) {
  return _then(_CreateOrderRequestDto(
restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,deliveryLat: null == deliveryLat ? _self.deliveryLat : deliveryLat // ignore: cast_nullable_to_non_nullable
as double,deliveryLng: null == deliveryLng ? _self.deliveryLng : deliveryLng // ignore: cast_nullable_to_non_nullable
as double,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,voucherIds: freezed == voucherIds ? _self._voucherIds : voucherIds // ignore: cast_nullable_to_non_nullable
as List<int>?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItemRequest>,
  ));
}


}

// dart format on
