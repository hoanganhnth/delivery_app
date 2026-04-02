// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumable_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConsumableDto {

 String get productId; String get title; String get description; String get price; String get currencyCode; double get rawPrice; String get consumableType; double get value; String? get code; DateTime? get expiryDate; bool get isAvailable;
/// Create a copy of ConsumableDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsumableDtoCopyWith<ConsumableDto> get copyWith => _$ConsumableDtoCopyWithImpl<ConsumableDto>(this as ConsumableDto, _$identity);

  /// Serializes this ConsumableDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsumableDto&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.rawPrice, rawPrice) || other.rawPrice == rawPrice)&&(identical(other.consumableType, consumableType) || other.consumableType == consumableType)&&(identical(other.value, value) || other.value == value)&&(identical(other.code, code) || other.code == code)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,title,description,price,currencyCode,rawPrice,consumableType,value,code,expiryDate,isAvailable);

@override
String toString() {
  return 'ConsumableDto(productId: $productId, title: $title, description: $description, price: $price, currencyCode: $currencyCode, rawPrice: $rawPrice, consumableType: $consumableType, value: $value, code: $code, expiryDate: $expiryDate, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $ConsumableDtoCopyWith<$Res>  {
  factory $ConsumableDtoCopyWith(ConsumableDto value, $Res Function(ConsumableDto) _then) = _$ConsumableDtoCopyWithImpl;
@useResult
$Res call({
 String productId, String title, String description, String price, String currencyCode, double rawPrice, String consumableType, double value, String? code, DateTime? expiryDate, bool isAvailable
});




}
/// @nodoc
class _$ConsumableDtoCopyWithImpl<$Res>
    implements $ConsumableDtoCopyWith<$Res> {
  _$ConsumableDtoCopyWithImpl(this._self, this._then);

  final ConsumableDto _self;
  final $Res Function(ConsumableDto) _then;

/// Create a copy of ConsumableDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? title = null,Object? description = null,Object? price = null,Object? currencyCode = null,Object? rawPrice = null,Object? consumableType = null,Object? value = null,Object? code = freezed,Object? expiryDate = freezed,Object? isAvailable = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,rawPrice: null == rawPrice ? _self.rawPrice : rawPrice // ignore: cast_nullable_to_non_nullable
as double,consumableType: null == consumableType ? _self.consumableType : consumableType // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ConsumableDto].
extension ConsumableDtoPatterns on ConsumableDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsumableDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsumableDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsumableDto value)  $default,){
final _that = this;
switch (_that) {
case _ConsumableDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsumableDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConsumableDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  String title,  String description,  String price,  String currencyCode,  double rawPrice,  String consumableType,  double value,  String? code,  DateTime? expiryDate,  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsumableDto() when $default != null:
return $default(_that.productId,_that.title,_that.description,_that.price,_that.currencyCode,_that.rawPrice,_that.consumableType,_that.value,_that.code,_that.expiryDate,_that.isAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  String title,  String description,  String price,  String currencyCode,  double rawPrice,  String consumableType,  double value,  String? code,  DateTime? expiryDate,  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _ConsumableDto():
return $default(_that.productId,_that.title,_that.description,_that.price,_that.currencyCode,_that.rawPrice,_that.consumableType,_that.value,_that.code,_that.expiryDate,_that.isAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  String title,  String description,  String price,  String currencyCode,  double rawPrice,  String consumableType,  double value,  String? code,  DateTime? expiryDate,  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _ConsumableDto() when $default != null:
return $default(_that.productId,_that.title,_that.description,_that.price,_that.currencyCode,_that.rawPrice,_that.consumableType,_that.value,_that.code,_that.expiryDate,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConsumableDto extends ConsumableDto {
  const _ConsumableDto({required this.productId, required this.title, required this.description, required this.price, required this.currencyCode, required this.rawPrice, required this.consumableType, required this.value, this.code, this.expiryDate, this.isAvailable = true}): super._();
  factory _ConsumableDto.fromJson(Map<String, dynamic> json) => _$ConsumableDtoFromJson(json);

@override final  String productId;
@override final  String title;
@override final  String description;
@override final  String price;
@override final  String currencyCode;
@override final  double rawPrice;
@override final  String consumableType;
@override final  double value;
@override final  String? code;
@override final  DateTime? expiryDate;
@override@JsonKey() final  bool isAvailable;

/// Create a copy of ConsumableDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsumableDtoCopyWith<_ConsumableDto> get copyWith => __$ConsumableDtoCopyWithImpl<_ConsumableDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConsumableDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsumableDto&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.rawPrice, rawPrice) || other.rawPrice == rawPrice)&&(identical(other.consumableType, consumableType) || other.consumableType == consumableType)&&(identical(other.value, value) || other.value == value)&&(identical(other.code, code) || other.code == code)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,title,description,price,currencyCode,rawPrice,consumableType,value,code,expiryDate,isAvailable);

@override
String toString() {
  return 'ConsumableDto(productId: $productId, title: $title, description: $description, price: $price, currencyCode: $currencyCode, rawPrice: $rawPrice, consumableType: $consumableType, value: $value, code: $code, expiryDate: $expiryDate, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$ConsumableDtoCopyWith<$Res> implements $ConsumableDtoCopyWith<$Res> {
  factory _$ConsumableDtoCopyWith(_ConsumableDto value, $Res Function(_ConsumableDto) _then) = __$ConsumableDtoCopyWithImpl;
@override @useResult
$Res call({
 String productId, String title, String description, String price, String currencyCode, double rawPrice, String consumableType, double value, String? code, DateTime? expiryDate, bool isAvailable
});




}
/// @nodoc
class __$ConsumableDtoCopyWithImpl<$Res>
    implements _$ConsumableDtoCopyWith<$Res> {
  __$ConsumableDtoCopyWithImpl(this._self, this._then);

  final _ConsumableDto _self;
  final $Res Function(_ConsumableDto) _then;

/// Create a copy of ConsumableDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? title = null,Object? description = null,Object? price = null,Object? currencyCode = null,Object? rawPrice = null,Object? consumableType = null,Object? value = null,Object? code = freezed,Object? expiryDate = freezed,Object? isAvailable = null,}) {
  return _then(_ConsumableDto(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,rawPrice: null == rawPrice ? _self.rawPrice : rawPrice // ignore: cast_nullable_to_non_nullable
as double,consumableType: null == consumableType ? _self.consumableType : consumableType // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UserCreditsDto {

 int get balance; DateTime get lastUpdated; List<CreditTransactionDto> get recentTransactions;
/// Create a copy of UserCreditsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCreditsDtoCopyWith<UserCreditsDto> get copyWith => _$UserCreditsDtoCopyWithImpl<UserCreditsDto>(this as UserCreditsDto, _$identity);

  /// Serializes this UserCreditsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserCreditsDto&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other.recentTransactions, recentTransactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,lastUpdated,const DeepCollectionEquality().hash(recentTransactions));

@override
String toString() {
  return 'UserCreditsDto(balance: $balance, lastUpdated: $lastUpdated, recentTransactions: $recentTransactions)';
}


}

/// @nodoc
abstract mixin class $UserCreditsDtoCopyWith<$Res>  {
  factory $UserCreditsDtoCopyWith(UserCreditsDto value, $Res Function(UserCreditsDto) _then) = _$UserCreditsDtoCopyWithImpl;
@useResult
$Res call({
 int balance, DateTime lastUpdated, List<CreditTransactionDto> recentTransactions
});




}
/// @nodoc
class _$UserCreditsDtoCopyWithImpl<$Res>
    implements $UserCreditsDtoCopyWith<$Res> {
  _$UserCreditsDtoCopyWithImpl(this._self, this._then);

  final UserCreditsDto _self;
  final $Res Function(UserCreditsDto) _then;

/// Create a copy of UserCreditsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,Object? lastUpdated = null,Object? recentTransactions = null,}) {
  return _then(_self.copyWith(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,recentTransactions: null == recentTransactions ? _self.recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<CreditTransactionDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserCreditsDto].
extension UserCreditsDtoPatterns on UserCreditsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserCreditsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserCreditsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserCreditsDto value)  $default,){
final _that = this;
switch (_that) {
case _UserCreditsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserCreditsDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserCreditsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int balance,  DateTime lastUpdated,  List<CreditTransactionDto> recentTransactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserCreditsDto() when $default != null:
return $default(_that.balance,_that.lastUpdated,_that.recentTransactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int balance,  DateTime lastUpdated,  List<CreditTransactionDto> recentTransactions)  $default,) {final _that = this;
switch (_that) {
case _UserCreditsDto():
return $default(_that.balance,_that.lastUpdated,_that.recentTransactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int balance,  DateTime lastUpdated,  List<CreditTransactionDto> recentTransactions)?  $default,) {final _that = this;
switch (_that) {
case _UserCreditsDto() when $default != null:
return $default(_that.balance,_that.lastUpdated,_that.recentTransactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserCreditsDto implements UserCreditsDto {
  const _UserCreditsDto({required this.balance, required this.lastUpdated, final  List<CreditTransactionDto> recentTransactions = const []}): _recentTransactions = recentTransactions;
  factory _UserCreditsDto.fromJson(Map<String, dynamic> json) => _$UserCreditsDtoFromJson(json);

@override final  int balance;
@override final  DateTime lastUpdated;
 final  List<CreditTransactionDto> _recentTransactions;
@override@JsonKey() List<CreditTransactionDto> get recentTransactions {
  if (_recentTransactions is EqualUnmodifiableListView) return _recentTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentTransactions);
}


/// Create a copy of UserCreditsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCreditsDtoCopyWith<_UserCreditsDto> get copyWith => __$UserCreditsDtoCopyWithImpl<_UserCreditsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserCreditsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCreditsDto&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other._recentTransactions, _recentTransactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,lastUpdated,const DeepCollectionEquality().hash(_recentTransactions));

@override
String toString() {
  return 'UserCreditsDto(balance: $balance, lastUpdated: $lastUpdated, recentTransactions: $recentTransactions)';
}


}

/// @nodoc
abstract mixin class _$UserCreditsDtoCopyWith<$Res> implements $UserCreditsDtoCopyWith<$Res> {
  factory _$UserCreditsDtoCopyWith(_UserCreditsDto value, $Res Function(_UserCreditsDto) _then) = __$UserCreditsDtoCopyWithImpl;
@override @useResult
$Res call({
 int balance, DateTime lastUpdated, List<CreditTransactionDto> recentTransactions
});




}
/// @nodoc
class __$UserCreditsDtoCopyWithImpl<$Res>
    implements _$UserCreditsDtoCopyWith<$Res> {
  __$UserCreditsDtoCopyWithImpl(this._self, this._then);

  final _UserCreditsDto _self;
  final $Res Function(_UserCreditsDto) _then;

/// Create a copy of UserCreditsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? lastUpdated = null,Object? recentTransactions = null,}) {
  return _then(_UserCreditsDto(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,recentTransactions: null == recentTransactions ? _self._recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<CreditTransactionDto>,
  ));
}


}


/// @nodoc
mixin _$CreditTransactionDto {

 String get id; int get amount; String get type;// 'purchase', 'spend', 'refund', 'bonus'
 DateTime get timestamp; String? get description; String? get orderId;
/// Create a copy of CreditTransactionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditTransactionDtoCopyWith<CreditTransactionDto> get copyWith => _$CreditTransactionDtoCopyWithImpl<CreditTransactionDto>(this as CreditTransactionDto, _$identity);

  /// Serializes this CreditTransactionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditTransactionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.description, description) || other.description == description)&&(identical(other.orderId, orderId) || other.orderId == orderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,type,timestamp,description,orderId);

@override
String toString() {
  return 'CreditTransactionDto(id: $id, amount: $amount, type: $type, timestamp: $timestamp, description: $description, orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $CreditTransactionDtoCopyWith<$Res>  {
  factory $CreditTransactionDtoCopyWith(CreditTransactionDto value, $Res Function(CreditTransactionDto) _then) = _$CreditTransactionDtoCopyWithImpl;
@useResult
$Res call({
 String id, int amount, String type, DateTime timestamp, String? description, String? orderId
});




}
/// @nodoc
class _$CreditTransactionDtoCopyWithImpl<$Res>
    implements $CreditTransactionDtoCopyWith<$Res> {
  _$CreditTransactionDtoCopyWithImpl(this._self, this._then);

  final CreditTransactionDto _self;
  final $Res Function(CreditTransactionDto) _then;

/// Create a copy of CreditTransactionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? type = null,Object? timestamp = null,Object? description = freezed,Object? orderId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditTransactionDto].
extension CreditTransactionDtoPatterns on CreditTransactionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditTransactionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditTransactionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditTransactionDto value)  $default,){
final _that = this;
switch (_that) {
case _CreditTransactionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditTransactionDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreditTransactionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int amount,  String type,  DateTime timestamp,  String? description,  String? orderId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditTransactionDto() when $default != null:
return $default(_that.id,_that.amount,_that.type,_that.timestamp,_that.description,_that.orderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int amount,  String type,  DateTime timestamp,  String? description,  String? orderId)  $default,) {final _that = this;
switch (_that) {
case _CreditTransactionDto():
return $default(_that.id,_that.amount,_that.type,_that.timestamp,_that.description,_that.orderId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int amount,  String type,  DateTime timestamp,  String? description,  String? orderId)?  $default,) {final _that = this;
switch (_that) {
case _CreditTransactionDto() when $default != null:
return $default(_that.id,_that.amount,_that.type,_that.timestamp,_that.description,_that.orderId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreditTransactionDto implements CreditTransactionDto {
  const _CreditTransactionDto({required this.id, required this.amount, required this.type, required this.timestamp, this.description, this.orderId});
  factory _CreditTransactionDto.fromJson(Map<String, dynamic> json) => _$CreditTransactionDtoFromJson(json);

@override final  String id;
@override final  int amount;
@override final  String type;
// 'purchase', 'spend', 'refund', 'bonus'
@override final  DateTime timestamp;
@override final  String? description;
@override final  String? orderId;

/// Create a copy of CreditTransactionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditTransactionDtoCopyWith<_CreditTransactionDto> get copyWith => __$CreditTransactionDtoCopyWithImpl<_CreditTransactionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreditTransactionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditTransactionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.description, description) || other.description == description)&&(identical(other.orderId, orderId) || other.orderId == orderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,type,timestamp,description,orderId);

@override
String toString() {
  return 'CreditTransactionDto(id: $id, amount: $amount, type: $type, timestamp: $timestamp, description: $description, orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class _$CreditTransactionDtoCopyWith<$Res> implements $CreditTransactionDtoCopyWith<$Res> {
  factory _$CreditTransactionDtoCopyWith(_CreditTransactionDto value, $Res Function(_CreditTransactionDto) _then) = __$CreditTransactionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int amount, String type, DateTime timestamp, String? description, String? orderId
});




}
/// @nodoc
class __$CreditTransactionDtoCopyWithImpl<$Res>
    implements _$CreditTransactionDtoCopyWith<$Res> {
  __$CreditTransactionDtoCopyWithImpl(this._self, this._then);

  final _CreditTransactionDto _self;
  final $Res Function(_CreditTransactionDto) _then;

/// Create a copy of CreditTransactionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? type = null,Object? timestamp = null,Object? description = freezed,Object? orderId = freezed,}) {
  return _then(_CreditTransactionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
