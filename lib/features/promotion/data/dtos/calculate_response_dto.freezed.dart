// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculate_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalculateResponseDto {

 List<VoucherInfoDto> get availableVouchers; List<UnavailableVoucherInfoDto> get unavailableVouchers; double get finalSubTotal; double get finalShippingFee; double get totalDiscount; double get totalAmount;
/// Create a copy of CalculateResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculateResponseDtoCopyWith<CalculateResponseDto> get copyWith => _$CalculateResponseDtoCopyWithImpl<CalculateResponseDto>(this as CalculateResponseDto, _$identity);

  /// Serializes this CalculateResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculateResponseDto&&const DeepCollectionEquality().equals(other.availableVouchers, availableVouchers)&&const DeepCollectionEquality().equals(other.unavailableVouchers, unavailableVouchers)&&(identical(other.finalSubTotal, finalSubTotal) || other.finalSubTotal == finalSubTotal)&&(identical(other.finalShippingFee, finalShippingFee) || other.finalShippingFee == finalShippingFee)&&(identical(other.totalDiscount, totalDiscount) || other.totalDiscount == totalDiscount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(availableVouchers),const DeepCollectionEquality().hash(unavailableVouchers),finalSubTotal,finalShippingFee,totalDiscount,totalAmount);

@override
String toString() {
  return 'CalculateResponseDto(availableVouchers: $availableVouchers, unavailableVouchers: $unavailableVouchers, finalSubTotal: $finalSubTotal, finalShippingFee: $finalShippingFee, totalDiscount: $totalDiscount, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class $CalculateResponseDtoCopyWith<$Res>  {
  factory $CalculateResponseDtoCopyWith(CalculateResponseDto value, $Res Function(CalculateResponseDto) _then) = _$CalculateResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<VoucherInfoDto> availableVouchers, List<UnavailableVoucherInfoDto> unavailableVouchers, double finalSubTotal, double finalShippingFee, double totalDiscount, double totalAmount
});




}
/// @nodoc
class _$CalculateResponseDtoCopyWithImpl<$Res>
    implements $CalculateResponseDtoCopyWith<$Res> {
  _$CalculateResponseDtoCopyWithImpl(this._self, this._then);

  final CalculateResponseDto _self;
  final $Res Function(CalculateResponseDto) _then;

/// Create a copy of CalculateResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availableVouchers = null,Object? unavailableVouchers = null,Object? finalSubTotal = null,Object? finalShippingFee = null,Object? totalDiscount = null,Object? totalAmount = null,}) {
  return _then(_self.copyWith(
availableVouchers: null == availableVouchers ? _self.availableVouchers : availableVouchers // ignore: cast_nullable_to_non_nullable
as List<VoucherInfoDto>,unavailableVouchers: null == unavailableVouchers ? _self.unavailableVouchers : unavailableVouchers // ignore: cast_nullable_to_non_nullable
as List<UnavailableVoucherInfoDto>,finalSubTotal: null == finalSubTotal ? _self.finalSubTotal : finalSubTotal // ignore: cast_nullable_to_non_nullable
as double,finalShippingFee: null == finalShippingFee ? _self.finalShippingFee : finalShippingFee // ignore: cast_nullable_to_non_nullable
as double,totalDiscount: null == totalDiscount ? _self.totalDiscount : totalDiscount // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CalculateResponseDto].
extension CalculateResponseDtoPatterns on CalculateResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculateResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculateResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculateResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CalculateResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculateResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CalculateResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VoucherInfoDto> availableVouchers,  List<UnavailableVoucherInfoDto> unavailableVouchers,  double finalSubTotal,  double finalShippingFee,  double totalDiscount,  double totalAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculateResponseDto() when $default != null:
return $default(_that.availableVouchers,_that.unavailableVouchers,_that.finalSubTotal,_that.finalShippingFee,_that.totalDiscount,_that.totalAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VoucherInfoDto> availableVouchers,  List<UnavailableVoucherInfoDto> unavailableVouchers,  double finalSubTotal,  double finalShippingFee,  double totalDiscount,  double totalAmount)  $default,) {final _that = this;
switch (_that) {
case _CalculateResponseDto():
return $default(_that.availableVouchers,_that.unavailableVouchers,_that.finalSubTotal,_that.finalShippingFee,_that.totalDiscount,_that.totalAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VoucherInfoDto> availableVouchers,  List<UnavailableVoucherInfoDto> unavailableVouchers,  double finalSubTotal,  double finalShippingFee,  double totalDiscount,  double totalAmount)?  $default,) {final _that = this;
switch (_that) {
case _CalculateResponseDto() when $default != null:
return $default(_that.availableVouchers,_that.unavailableVouchers,_that.finalSubTotal,_that.finalShippingFee,_that.totalDiscount,_that.totalAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalculateResponseDto implements CalculateResponseDto {
  const _CalculateResponseDto({final  List<VoucherInfoDto> availableVouchers = const [], final  List<UnavailableVoucherInfoDto> unavailableVouchers = const [], required this.finalSubTotal, required this.finalShippingFee, required this.totalDiscount, required this.totalAmount}): _availableVouchers = availableVouchers,_unavailableVouchers = unavailableVouchers;
  factory _CalculateResponseDto.fromJson(Map<String, dynamic> json) => _$CalculateResponseDtoFromJson(json);

 final  List<VoucherInfoDto> _availableVouchers;
@override@JsonKey() List<VoucherInfoDto> get availableVouchers {
  if (_availableVouchers is EqualUnmodifiableListView) return _availableVouchers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableVouchers);
}

 final  List<UnavailableVoucherInfoDto> _unavailableVouchers;
@override@JsonKey() List<UnavailableVoucherInfoDto> get unavailableVouchers {
  if (_unavailableVouchers is EqualUnmodifiableListView) return _unavailableVouchers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unavailableVouchers);
}

@override final  double finalSubTotal;
@override final  double finalShippingFee;
@override final  double totalDiscount;
@override final  double totalAmount;

/// Create a copy of CalculateResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculateResponseDtoCopyWith<_CalculateResponseDto> get copyWith => __$CalculateResponseDtoCopyWithImpl<_CalculateResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalculateResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculateResponseDto&&const DeepCollectionEquality().equals(other._availableVouchers, _availableVouchers)&&const DeepCollectionEquality().equals(other._unavailableVouchers, _unavailableVouchers)&&(identical(other.finalSubTotal, finalSubTotal) || other.finalSubTotal == finalSubTotal)&&(identical(other.finalShippingFee, finalShippingFee) || other.finalShippingFee == finalShippingFee)&&(identical(other.totalDiscount, totalDiscount) || other.totalDiscount == totalDiscount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availableVouchers),const DeepCollectionEquality().hash(_unavailableVouchers),finalSubTotal,finalShippingFee,totalDiscount,totalAmount);

@override
String toString() {
  return 'CalculateResponseDto(availableVouchers: $availableVouchers, unavailableVouchers: $unavailableVouchers, finalSubTotal: $finalSubTotal, finalShippingFee: $finalShippingFee, totalDiscount: $totalDiscount, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class _$CalculateResponseDtoCopyWith<$Res> implements $CalculateResponseDtoCopyWith<$Res> {
  factory _$CalculateResponseDtoCopyWith(_CalculateResponseDto value, $Res Function(_CalculateResponseDto) _then) = __$CalculateResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<VoucherInfoDto> availableVouchers, List<UnavailableVoucherInfoDto> unavailableVouchers, double finalSubTotal, double finalShippingFee, double totalDiscount, double totalAmount
});




}
/// @nodoc
class __$CalculateResponseDtoCopyWithImpl<$Res>
    implements _$CalculateResponseDtoCopyWith<$Res> {
  __$CalculateResponseDtoCopyWithImpl(this._self, this._then);

  final _CalculateResponseDto _self;
  final $Res Function(_CalculateResponseDto) _then;

/// Create a copy of CalculateResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availableVouchers = null,Object? unavailableVouchers = null,Object? finalSubTotal = null,Object? finalShippingFee = null,Object? totalDiscount = null,Object? totalAmount = null,}) {
  return _then(_CalculateResponseDto(
availableVouchers: null == availableVouchers ? _self._availableVouchers : availableVouchers // ignore: cast_nullable_to_non_nullable
as List<VoucherInfoDto>,unavailableVouchers: null == unavailableVouchers ? _self._unavailableVouchers : unavailableVouchers // ignore: cast_nullable_to_non_nullable
as List<UnavailableVoucherInfoDto>,finalSubTotal: null == finalSubTotal ? _self.finalSubTotal : finalSubTotal // ignore: cast_nullable_to_non_nullable
as double,finalShippingFee: null == finalShippingFee ? _self.finalShippingFee : finalShippingFee // ignore: cast_nullable_to_non_nullable
as double,totalDiscount: null == totalDiscount ? _self.totalDiscount : totalDiscount // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$VoucherInfoDto {

 int get id; String get code; String get name; String get rewardType; double get discountValue; int? get voucherGroupId;
/// Create a copy of VoucherInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoucherInfoDtoCopyWith<VoucherInfoDto> get copyWith => _$VoucherInfoDtoCopyWithImpl<VoucherInfoDto>(this as VoucherInfoDto, _$identity);

  /// Serializes this VoucherInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoucherInfoDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.voucherGroupId, voucherGroupId) || other.voucherGroupId == voucherGroupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,rewardType,discountValue,voucherGroupId);

@override
String toString() {
  return 'VoucherInfoDto(id: $id, code: $code, name: $name, rewardType: $rewardType, discountValue: $discountValue, voucherGroupId: $voucherGroupId)';
}


}

/// @nodoc
abstract mixin class $VoucherInfoDtoCopyWith<$Res>  {
  factory $VoucherInfoDtoCopyWith(VoucherInfoDto value, $Res Function(VoucherInfoDto) _then) = _$VoucherInfoDtoCopyWithImpl;
@useResult
$Res call({
 int id, String code, String name, String rewardType, double discountValue, int? voucherGroupId
});




}
/// @nodoc
class _$VoucherInfoDtoCopyWithImpl<$Res>
    implements $VoucherInfoDtoCopyWith<$Res> {
  _$VoucherInfoDtoCopyWithImpl(this._self, this._then);

  final VoucherInfoDto _self;
  final $Res Function(VoucherInfoDto) _then;

/// Create a copy of VoucherInfoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? rewardType = null,Object? discountValue = null,Object? voucherGroupId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rewardType: null == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,voucherGroupId: freezed == voucherGroupId ? _self.voucherGroupId : voucherGroupId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoucherInfoDto].
extension VoucherInfoDtoPatterns on VoucherInfoDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoucherInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoucherInfoDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoucherInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _VoucherInfoDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoucherInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _VoucherInfoDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String name,  String rewardType,  double discountValue,  int? voucherGroupId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoucherInfoDto() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.rewardType,_that.discountValue,_that.voucherGroupId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String name,  String rewardType,  double discountValue,  int? voucherGroupId)  $default,) {final _that = this;
switch (_that) {
case _VoucherInfoDto():
return $default(_that.id,_that.code,_that.name,_that.rewardType,_that.discountValue,_that.voucherGroupId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String name,  String rewardType,  double discountValue,  int? voucherGroupId)?  $default,) {final _that = this;
switch (_that) {
case _VoucherInfoDto() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.rewardType,_that.discountValue,_that.voucherGroupId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoucherInfoDto implements VoucherInfoDto {
  const _VoucherInfoDto({required this.id, required this.code, required this.name, required this.rewardType, required this.discountValue, this.voucherGroupId});
  factory _VoucherInfoDto.fromJson(Map<String, dynamic> json) => _$VoucherInfoDtoFromJson(json);

@override final  int id;
@override final  String code;
@override final  String name;
@override final  String rewardType;
@override final  double discountValue;
@override final  int? voucherGroupId;

/// Create a copy of VoucherInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoucherInfoDtoCopyWith<_VoucherInfoDto> get copyWith => __$VoucherInfoDtoCopyWithImpl<_VoucherInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoucherInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoucherInfoDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.voucherGroupId, voucherGroupId) || other.voucherGroupId == voucherGroupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,rewardType,discountValue,voucherGroupId);

@override
String toString() {
  return 'VoucherInfoDto(id: $id, code: $code, name: $name, rewardType: $rewardType, discountValue: $discountValue, voucherGroupId: $voucherGroupId)';
}


}

/// @nodoc
abstract mixin class _$VoucherInfoDtoCopyWith<$Res> implements $VoucherInfoDtoCopyWith<$Res> {
  factory _$VoucherInfoDtoCopyWith(_VoucherInfoDto value, $Res Function(_VoucherInfoDto) _then) = __$VoucherInfoDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String name, String rewardType, double discountValue, int? voucherGroupId
});




}
/// @nodoc
class __$VoucherInfoDtoCopyWithImpl<$Res>
    implements _$VoucherInfoDtoCopyWith<$Res> {
  __$VoucherInfoDtoCopyWithImpl(this._self, this._then);

  final _VoucherInfoDto _self;
  final $Res Function(_VoucherInfoDto) _then;

/// Create a copy of VoucherInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? rewardType = null,Object? discountValue = null,Object? voucherGroupId = freezed,}) {
  return _then(_VoucherInfoDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rewardType: null == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,voucherGroupId: freezed == voucherGroupId ? _self.voucherGroupId : voucherGroupId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$UnavailableVoucherInfoDto {

 int get id; String get code; String get name; String get reason;
/// Create a copy of UnavailableVoucherInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnavailableVoucherInfoDtoCopyWith<UnavailableVoucherInfoDto> get copyWith => _$UnavailableVoucherInfoDtoCopyWithImpl<UnavailableVoucherInfoDto>(this as UnavailableVoucherInfoDto, _$identity);

  /// Serializes this UnavailableVoucherInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnavailableVoucherInfoDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,reason);

@override
String toString() {
  return 'UnavailableVoucherInfoDto(id: $id, code: $code, name: $name, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $UnavailableVoucherInfoDtoCopyWith<$Res>  {
  factory $UnavailableVoucherInfoDtoCopyWith(UnavailableVoucherInfoDto value, $Res Function(UnavailableVoucherInfoDto) _then) = _$UnavailableVoucherInfoDtoCopyWithImpl;
@useResult
$Res call({
 int id, String code, String name, String reason
});




}
/// @nodoc
class _$UnavailableVoucherInfoDtoCopyWithImpl<$Res>
    implements $UnavailableVoucherInfoDtoCopyWith<$Res> {
  _$UnavailableVoucherInfoDtoCopyWithImpl(this._self, this._then);

  final UnavailableVoucherInfoDto _self;
  final $Res Function(UnavailableVoucherInfoDto) _then;

/// Create a copy of UnavailableVoucherInfoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? reason = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UnavailableVoucherInfoDto].
extension UnavailableVoucherInfoDtoPatterns on UnavailableVoucherInfoDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnavailableVoucherInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnavailableVoucherInfoDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnavailableVoucherInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _UnavailableVoucherInfoDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnavailableVoucherInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _UnavailableVoucherInfoDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String name,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnavailableVoucherInfoDto() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String name,  String reason)  $default,) {final _that = this;
switch (_that) {
case _UnavailableVoucherInfoDto():
return $default(_that.id,_that.code,_that.name,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String name,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _UnavailableVoucherInfoDto() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnavailableVoucherInfoDto implements UnavailableVoucherInfoDto {
  const _UnavailableVoucherInfoDto({required this.id, required this.code, required this.name, required this.reason});
  factory _UnavailableVoucherInfoDto.fromJson(Map<String, dynamic> json) => _$UnavailableVoucherInfoDtoFromJson(json);

@override final  int id;
@override final  String code;
@override final  String name;
@override final  String reason;

/// Create a copy of UnavailableVoucherInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnavailableVoucherInfoDtoCopyWith<_UnavailableVoucherInfoDto> get copyWith => __$UnavailableVoucherInfoDtoCopyWithImpl<_UnavailableVoucherInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnavailableVoucherInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnavailableVoucherInfoDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,reason);

@override
String toString() {
  return 'UnavailableVoucherInfoDto(id: $id, code: $code, name: $name, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$UnavailableVoucherInfoDtoCopyWith<$Res> implements $UnavailableVoucherInfoDtoCopyWith<$Res> {
  factory _$UnavailableVoucherInfoDtoCopyWith(_UnavailableVoucherInfoDto value, $Res Function(_UnavailableVoucherInfoDto) _then) = __$UnavailableVoucherInfoDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String name, String reason
});




}
/// @nodoc
class __$UnavailableVoucherInfoDtoCopyWithImpl<$Res>
    implements _$UnavailableVoucherInfoDtoCopyWith<$Res> {
  __$UnavailableVoucherInfoDtoCopyWithImpl(this._self, this._then);

  final _UnavailableVoucherInfoDto _self;
  final $Res Function(_UnavailableVoucherInfoDto) _then;

/// Create a copy of UnavailableVoucherInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? reason = null,}) {
  return _then(_UnavailableVoucherInfoDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
