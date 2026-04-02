// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PurchaseDto {

 String get purchaseId; String get productId; String get transactionDate; String get status; String? get verificationData; bool get pendingCompletePurchase;
/// Create a copy of PurchaseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseDtoCopyWith<PurchaseDto> get copyWith => _$PurchaseDtoCopyWithImpl<PurchaseDto>(this as PurchaseDto, _$identity);

  /// Serializes this PurchaseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseDto&&(identical(other.purchaseId, purchaseId) || other.purchaseId == purchaseId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.verificationData, verificationData) || other.verificationData == verificationData)&&(identical(other.pendingCompletePurchase, pendingCompletePurchase) || other.pendingCompletePurchase == pendingCompletePurchase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purchaseId,productId,transactionDate,status,verificationData,pendingCompletePurchase);

@override
String toString() {
  return 'PurchaseDto(purchaseId: $purchaseId, productId: $productId, transactionDate: $transactionDate, status: $status, verificationData: $verificationData, pendingCompletePurchase: $pendingCompletePurchase)';
}


}

/// @nodoc
abstract mixin class $PurchaseDtoCopyWith<$Res>  {
  factory $PurchaseDtoCopyWith(PurchaseDto value, $Res Function(PurchaseDto) _then) = _$PurchaseDtoCopyWithImpl;
@useResult
$Res call({
 String purchaseId, String productId, String transactionDate, String status, String? verificationData, bool pendingCompletePurchase
});




}
/// @nodoc
class _$PurchaseDtoCopyWithImpl<$Res>
    implements $PurchaseDtoCopyWith<$Res> {
  _$PurchaseDtoCopyWithImpl(this._self, this._then);

  final PurchaseDto _self;
  final $Res Function(PurchaseDto) _then;

/// Create a copy of PurchaseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? purchaseId = null,Object? productId = null,Object? transactionDate = null,Object? status = null,Object? verificationData = freezed,Object? pendingCompletePurchase = null,}) {
  return _then(_self.copyWith(
purchaseId: null == purchaseId ? _self.purchaseId : purchaseId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,verificationData: freezed == verificationData ? _self.verificationData : verificationData // ignore: cast_nullable_to_non_nullable
as String?,pendingCompletePurchase: null == pendingCompletePurchase ? _self.pendingCompletePurchase : pendingCompletePurchase // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseDto].
extension PurchaseDtoPatterns on PurchaseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseDto value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseDto value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String purchaseId,  String productId,  String transactionDate,  String status,  String? verificationData,  bool pendingCompletePurchase)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseDto() when $default != null:
return $default(_that.purchaseId,_that.productId,_that.transactionDate,_that.status,_that.verificationData,_that.pendingCompletePurchase);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String purchaseId,  String productId,  String transactionDate,  String status,  String? verificationData,  bool pendingCompletePurchase)  $default,) {final _that = this;
switch (_that) {
case _PurchaseDto():
return $default(_that.purchaseId,_that.productId,_that.transactionDate,_that.status,_that.verificationData,_that.pendingCompletePurchase);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String purchaseId,  String productId,  String transactionDate,  String status,  String? verificationData,  bool pendingCompletePurchase)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseDto() when $default != null:
return $default(_that.purchaseId,_that.productId,_that.transactionDate,_that.status,_that.verificationData,_that.pendingCompletePurchase);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseDto extends PurchaseDto {
  const _PurchaseDto({required this.purchaseId, required this.productId, required this.transactionDate, required this.status, this.verificationData, this.pendingCompletePurchase = false}): super._();
  factory _PurchaseDto.fromJson(Map<String, dynamic> json) => _$PurchaseDtoFromJson(json);

@override final  String purchaseId;
@override final  String productId;
@override final  String transactionDate;
@override final  String status;
@override final  String? verificationData;
@override@JsonKey() final  bool pendingCompletePurchase;

/// Create a copy of PurchaseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseDtoCopyWith<_PurchaseDto> get copyWith => __$PurchaseDtoCopyWithImpl<_PurchaseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseDto&&(identical(other.purchaseId, purchaseId) || other.purchaseId == purchaseId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.verificationData, verificationData) || other.verificationData == verificationData)&&(identical(other.pendingCompletePurchase, pendingCompletePurchase) || other.pendingCompletePurchase == pendingCompletePurchase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purchaseId,productId,transactionDate,status,verificationData,pendingCompletePurchase);

@override
String toString() {
  return 'PurchaseDto(purchaseId: $purchaseId, productId: $productId, transactionDate: $transactionDate, status: $status, verificationData: $verificationData, pendingCompletePurchase: $pendingCompletePurchase)';
}


}

/// @nodoc
abstract mixin class _$PurchaseDtoCopyWith<$Res> implements $PurchaseDtoCopyWith<$Res> {
  factory _$PurchaseDtoCopyWith(_PurchaseDto value, $Res Function(_PurchaseDto) _then) = __$PurchaseDtoCopyWithImpl;
@override @useResult
$Res call({
 String purchaseId, String productId, String transactionDate, String status, String? verificationData, bool pendingCompletePurchase
});




}
/// @nodoc
class __$PurchaseDtoCopyWithImpl<$Res>
    implements _$PurchaseDtoCopyWith<$Res> {
  __$PurchaseDtoCopyWithImpl(this._self, this._then);

  final _PurchaseDto _self;
  final $Res Function(_PurchaseDto) _then;

/// Create a copy of PurchaseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? purchaseId = null,Object? productId = null,Object? transactionDate = null,Object? status = null,Object? verificationData = freezed,Object? pendingCompletePurchase = null,}) {
  return _then(_PurchaseDto(
purchaseId: null == purchaseId ? _self.purchaseId : purchaseId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,verificationData: freezed == verificationData ? _self.verificationData : verificationData // ignore: cast_nullable_to_non_nullable
as String?,pendingCompletePurchase: null == pendingCompletePurchase ? _self.pendingCompletePurchase : pendingCompletePurchase // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
