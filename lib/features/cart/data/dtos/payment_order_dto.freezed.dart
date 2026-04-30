// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_order_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatePaymentDto {

 int get entityId; String get entityType; double get amount; String get provider; String get purpose; String? get returnUrl; String? get ipAddress;
/// Create a copy of CreatePaymentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePaymentDtoCopyWith<CreatePaymentDto> get copyWith => _$CreatePaymentDtoCopyWithImpl<CreatePaymentDto>(this as CreatePaymentDto, _$identity);

  /// Serializes this CreatePaymentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePaymentDto&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.returnUrl, returnUrl) || other.returnUrl == returnUrl)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entityId,entityType,amount,provider,purpose,returnUrl,ipAddress);

@override
String toString() {
  return 'CreatePaymentDto(entityId: $entityId, entityType: $entityType, amount: $amount, provider: $provider, purpose: $purpose, returnUrl: $returnUrl, ipAddress: $ipAddress)';
}


}

/// @nodoc
abstract mixin class $CreatePaymentDtoCopyWith<$Res>  {
  factory $CreatePaymentDtoCopyWith(CreatePaymentDto value, $Res Function(CreatePaymentDto) _then) = _$CreatePaymentDtoCopyWithImpl;
@useResult
$Res call({
 int entityId, String entityType, double amount, String provider, String purpose, String? returnUrl, String? ipAddress
});




}
/// @nodoc
class _$CreatePaymentDtoCopyWithImpl<$Res>
    implements $CreatePaymentDtoCopyWith<$Res> {
  _$CreatePaymentDtoCopyWithImpl(this._self, this._then);

  final CreatePaymentDto _self;
  final $Res Function(CreatePaymentDto) _then;

/// Create a copy of CreatePaymentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entityId = null,Object? entityType = null,Object? amount = null,Object? provider = null,Object? purpose = null,Object? returnUrl = freezed,Object? ipAddress = freezed,}) {
  return _then(_self.copyWith(
entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as int,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePaymentDto].
extension CreatePaymentDtoPatterns on CreatePaymentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePaymentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePaymentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePaymentDto value)  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePaymentDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int entityId,  String entityType,  double amount,  String provider,  String purpose,  String? returnUrl,  String? ipAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePaymentDto() when $default != null:
return $default(_that.entityId,_that.entityType,_that.amount,_that.provider,_that.purpose,_that.returnUrl,_that.ipAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int entityId,  String entityType,  double amount,  String provider,  String purpose,  String? returnUrl,  String? ipAddress)  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentDto():
return $default(_that.entityId,_that.entityType,_that.amount,_that.provider,_that.purpose,_that.returnUrl,_that.ipAddress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int entityId,  String entityType,  double amount,  String provider,  String purpose,  String? returnUrl,  String? ipAddress)?  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentDto() when $default != null:
return $default(_that.entityId,_that.entityType,_that.amount,_that.provider,_that.purpose,_that.returnUrl,_that.ipAddress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePaymentDto implements CreatePaymentDto {
  const _CreatePaymentDto({required this.entityId, this.entityType = 'CUSTOMER', required this.amount, this.provider = 'FAKE', this.purpose = 'ORDER_PAYMENT', this.returnUrl, this.ipAddress});
  factory _CreatePaymentDto.fromJson(Map<String, dynamic> json) => _$CreatePaymentDtoFromJson(json);

@override final  int entityId;
@override@JsonKey() final  String entityType;
@override final  double amount;
@override@JsonKey() final  String provider;
@override@JsonKey() final  String purpose;
@override final  String? returnUrl;
@override final  String? ipAddress;

/// Create a copy of CreatePaymentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePaymentDtoCopyWith<_CreatePaymentDto> get copyWith => __$CreatePaymentDtoCopyWithImpl<_CreatePaymentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePaymentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePaymentDto&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.returnUrl, returnUrl) || other.returnUrl == returnUrl)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entityId,entityType,amount,provider,purpose,returnUrl,ipAddress);

@override
String toString() {
  return 'CreatePaymentDto(entityId: $entityId, entityType: $entityType, amount: $amount, provider: $provider, purpose: $purpose, returnUrl: $returnUrl, ipAddress: $ipAddress)';
}


}

/// @nodoc
abstract mixin class _$CreatePaymentDtoCopyWith<$Res> implements $CreatePaymentDtoCopyWith<$Res> {
  factory _$CreatePaymentDtoCopyWith(_CreatePaymentDto value, $Res Function(_CreatePaymentDto) _then) = __$CreatePaymentDtoCopyWithImpl;
@override @useResult
$Res call({
 int entityId, String entityType, double amount, String provider, String purpose, String? returnUrl, String? ipAddress
});




}
/// @nodoc
class __$CreatePaymentDtoCopyWithImpl<$Res>
    implements _$CreatePaymentDtoCopyWith<$Res> {
  __$CreatePaymentDtoCopyWithImpl(this._self, this._then);

  final _CreatePaymentDto _self;
  final $Res Function(_CreatePaymentDto) _then;

/// Create a copy of CreatePaymentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entityId = null,Object? entityType = null,Object? amount = null,Object? provider = null,Object? purpose = null,Object? returnUrl = freezed,Object? ipAddress = freezed,}) {
  return _then(_CreatePaymentDto(
entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as int,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PaymentOrderDto {

 int get id; String get paymentRef; int get entityId; String get entityType; String get provider; double get amount; String get currency; String get purpose; String get status; String? get paymentUrl; String? get providerTransactionId; int? get settlementTransactionId; String? get createdAt; String? get expiredAt;
/// Create a copy of PaymentOrderDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentOrderDtoCopyWith<PaymentOrderDto> get copyWith => _$PaymentOrderDtoCopyWithImpl<PaymentOrderDto>(this as PaymentOrderDto, _$identity);

  /// Serializes this PaymentOrderDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentOrderDto&&(identical(other.id, id) || other.id == id)&&(identical(other.paymentRef, paymentRef) || other.paymentRef == paymentRef)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentUrl, paymentUrl) || other.paymentUrl == paymentUrl)&&(identical(other.providerTransactionId, providerTransactionId) || other.providerTransactionId == providerTransactionId)&&(identical(other.settlementTransactionId, settlementTransactionId) || other.settlementTransactionId == settlementTransactionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,paymentRef,entityId,entityType,provider,amount,currency,purpose,status,paymentUrl,providerTransactionId,settlementTransactionId,createdAt,expiredAt);

@override
String toString() {
  return 'PaymentOrderDto(id: $id, paymentRef: $paymentRef, entityId: $entityId, entityType: $entityType, provider: $provider, amount: $amount, currency: $currency, purpose: $purpose, status: $status, paymentUrl: $paymentUrl, providerTransactionId: $providerTransactionId, settlementTransactionId: $settlementTransactionId, createdAt: $createdAt, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class $PaymentOrderDtoCopyWith<$Res>  {
  factory $PaymentOrderDtoCopyWith(PaymentOrderDto value, $Res Function(PaymentOrderDto) _then) = _$PaymentOrderDtoCopyWithImpl;
@useResult
$Res call({
 int id, String paymentRef, int entityId, String entityType, String provider, double amount, String currency, String purpose, String status, String? paymentUrl, String? providerTransactionId, int? settlementTransactionId, String? createdAt, String? expiredAt
});




}
/// @nodoc
class _$PaymentOrderDtoCopyWithImpl<$Res>
    implements $PaymentOrderDtoCopyWith<$Res> {
  _$PaymentOrderDtoCopyWithImpl(this._self, this._then);

  final PaymentOrderDto _self;
  final $Res Function(PaymentOrderDto) _then;

/// Create a copy of PaymentOrderDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? paymentRef = null,Object? entityId = null,Object? entityType = null,Object? provider = null,Object? amount = null,Object? currency = null,Object? purpose = null,Object? status = null,Object? paymentUrl = freezed,Object? providerTransactionId = freezed,Object? settlementTransactionId = freezed,Object? createdAt = freezed,Object? expiredAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,paymentRef: null == paymentRef ? _self.paymentRef : paymentRef // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as int,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,paymentUrl: freezed == paymentUrl ? _self.paymentUrl : paymentUrl // ignore: cast_nullable_to_non_nullable
as String?,providerTransactionId: freezed == providerTransactionId ? _self.providerTransactionId : providerTransactionId // ignore: cast_nullable_to_non_nullable
as String?,settlementTransactionId: freezed == settlementTransactionId ? _self.settlementTransactionId : settlementTransactionId // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentOrderDto].
extension PaymentOrderDtoPatterns on PaymentOrderDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentOrderDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentOrderDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentOrderDto value)  $default,){
final _that = this;
switch (_that) {
case _PaymentOrderDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentOrderDto value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentOrderDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String paymentRef,  int entityId,  String entityType,  String provider,  double amount,  String currency,  String purpose,  String status,  String? paymentUrl,  String? providerTransactionId,  int? settlementTransactionId,  String? createdAt,  String? expiredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentOrderDto() when $default != null:
return $default(_that.id,_that.paymentRef,_that.entityId,_that.entityType,_that.provider,_that.amount,_that.currency,_that.purpose,_that.status,_that.paymentUrl,_that.providerTransactionId,_that.settlementTransactionId,_that.createdAt,_that.expiredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String paymentRef,  int entityId,  String entityType,  String provider,  double amount,  String currency,  String purpose,  String status,  String? paymentUrl,  String? providerTransactionId,  int? settlementTransactionId,  String? createdAt,  String? expiredAt)  $default,) {final _that = this;
switch (_that) {
case _PaymentOrderDto():
return $default(_that.id,_that.paymentRef,_that.entityId,_that.entityType,_that.provider,_that.amount,_that.currency,_that.purpose,_that.status,_that.paymentUrl,_that.providerTransactionId,_that.settlementTransactionId,_that.createdAt,_that.expiredAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String paymentRef,  int entityId,  String entityType,  String provider,  double amount,  String currency,  String purpose,  String status,  String? paymentUrl,  String? providerTransactionId,  int? settlementTransactionId,  String? createdAt,  String? expiredAt)?  $default,) {final _that = this;
switch (_that) {
case _PaymentOrderDto() when $default != null:
return $default(_that.id,_that.paymentRef,_that.entityId,_that.entityType,_that.provider,_that.amount,_that.currency,_that.purpose,_that.status,_that.paymentUrl,_that.providerTransactionId,_that.settlementTransactionId,_that.createdAt,_that.expiredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentOrderDto implements PaymentOrderDto {
  const _PaymentOrderDto({required this.id, required this.paymentRef, required this.entityId, required this.entityType, required this.provider, required this.amount, required this.currency, required this.purpose, required this.status, this.paymentUrl, this.providerTransactionId, this.settlementTransactionId, this.createdAt, this.expiredAt});
  factory _PaymentOrderDto.fromJson(Map<String, dynamic> json) => _$PaymentOrderDtoFromJson(json);

@override final  int id;
@override final  String paymentRef;
@override final  int entityId;
@override final  String entityType;
@override final  String provider;
@override final  double amount;
@override final  String currency;
@override final  String purpose;
@override final  String status;
@override final  String? paymentUrl;
@override final  String? providerTransactionId;
@override final  int? settlementTransactionId;
@override final  String? createdAt;
@override final  String? expiredAt;

/// Create a copy of PaymentOrderDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentOrderDtoCopyWith<_PaymentOrderDto> get copyWith => __$PaymentOrderDtoCopyWithImpl<_PaymentOrderDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentOrderDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentOrderDto&&(identical(other.id, id) || other.id == id)&&(identical(other.paymentRef, paymentRef) || other.paymentRef == paymentRef)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentUrl, paymentUrl) || other.paymentUrl == paymentUrl)&&(identical(other.providerTransactionId, providerTransactionId) || other.providerTransactionId == providerTransactionId)&&(identical(other.settlementTransactionId, settlementTransactionId) || other.settlementTransactionId == settlementTransactionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,paymentRef,entityId,entityType,provider,amount,currency,purpose,status,paymentUrl,providerTransactionId,settlementTransactionId,createdAt,expiredAt);

@override
String toString() {
  return 'PaymentOrderDto(id: $id, paymentRef: $paymentRef, entityId: $entityId, entityType: $entityType, provider: $provider, amount: $amount, currency: $currency, purpose: $purpose, status: $status, paymentUrl: $paymentUrl, providerTransactionId: $providerTransactionId, settlementTransactionId: $settlementTransactionId, createdAt: $createdAt, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class _$PaymentOrderDtoCopyWith<$Res> implements $PaymentOrderDtoCopyWith<$Res> {
  factory _$PaymentOrderDtoCopyWith(_PaymentOrderDto value, $Res Function(_PaymentOrderDto) _then) = __$PaymentOrderDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String paymentRef, int entityId, String entityType, String provider, double amount, String currency, String purpose, String status, String? paymentUrl, String? providerTransactionId, int? settlementTransactionId, String? createdAt, String? expiredAt
});




}
/// @nodoc
class __$PaymentOrderDtoCopyWithImpl<$Res>
    implements _$PaymentOrderDtoCopyWith<$Res> {
  __$PaymentOrderDtoCopyWithImpl(this._self, this._then);

  final _PaymentOrderDto _self;
  final $Res Function(_PaymentOrderDto) _then;

/// Create a copy of PaymentOrderDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? paymentRef = null,Object? entityId = null,Object? entityType = null,Object? provider = null,Object? amount = null,Object? currency = null,Object? purpose = null,Object? status = null,Object? paymentUrl = freezed,Object? providerTransactionId = freezed,Object? settlementTransactionId = freezed,Object? createdAt = freezed,Object? expiredAt = freezed,}) {
  return _then(_PaymentOrderDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,paymentRef: null == paymentRef ? _self.paymentRef : paymentRef // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as int,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,paymentUrl: freezed == paymentUrl ? _self.paymentUrl : paymentUrl // ignore: cast_nullable_to_non_nullable
as String?,providerTransactionId: freezed == providerTransactionId ? _self.providerTransactionId : providerTransactionId // ignore: cast_nullable_to_non_nullable
as String?,settlementTransactionId: freezed == settlementTransactionId ? _self.settlementTransactionId : settlementTransactionId // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
