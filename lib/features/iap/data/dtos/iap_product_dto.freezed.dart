// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iap_product_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IapProductDto {

 String get id; String get title; String get description; String get price; String get currencyCode; double get rawPrice; String get productType;
/// Create a copy of IapProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IapProductDtoCopyWith<IapProductDto> get copyWith => _$IapProductDtoCopyWithImpl<IapProductDto>(this as IapProductDto, _$identity);

  /// Serializes this IapProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IapProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.rawPrice, rawPrice) || other.rawPrice == rawPrice)&&(identical(other.productType, productType) || other.productType == productType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,price,currencyCode,rawPrice,productType);

@override
String toString() {
  return 'IapProductDto(id: $id, title: $title, description: $description, price: $price, currencyCode: $currencyCode, rawPrice: $rawPrice, productType: $productType)';
}


}

/// @nodoc
abstract mixin class $IapProductDtoCopyWith<$Res>  {
  factory $IapProductDtoCopyWith(IapProductDto value, $Res Function(IapProductDto) _then) = _$IapProductDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String price, String currencyCode, double rawPrice, String productType
});




}
/// @nodoc
class _$IapProductDtoCopyWithImpl<$Res>
    implements $IapProductDtoCopyWith<$Res> {
  _$IapProductDtoCopyWithImpl(this._self, this._then);

  final IapProductDto _self;
  final $Res Function(IapProductDto) _then;

/// Create a copy of IapProductDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? price = null,Object? currencyCode = null,Object? rawPrice = null,Object? productType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,rawPrice: null == rawPrice ? _self.rawPrice : rawPrice // ignore: cast_nullable_to_non_nullable
as double,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IapProductDto].
extension IapProductDtoPatterns on IapProductDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IapProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IapProductDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IapProductDto value)  $default,){
final _that = this;
switch (_that) {
case _IapProductDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IapProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _IapProductDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String price,  String currencyCode,  double rawPrice,  String productType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IapProductDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.price,_that.currencyCode,_that.rawPrice,_that.productType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String price,  String currencyCode,  double rawPrice,  String productType)  $default,) {final _that = this;
switch (_that) {
case _IapProductDto():
return $default(_that.id,_that.title,_that.description,_that.price,_that.currencyCode,_that.rawPrice,_that.productType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String price,  String currencyCode,  double rawPrice,  String productType)?  $default,) {final _that = this;
switch (_that) {
case _IapProductDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.price,_that.currencyCode,_that.rawPrice,_that.productType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IapProductDto extends IapProductDto {
  const _IapProductDto({required this.id, required this.title, required this.description, required this.price, required this.currencyCode, required this.rawPrice, required this.productType}): super._();
  factory _IapProductDto.fromJson(Map<String, dynamic> json) => _$IapProductDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String price;
@override final  String currencyCode;
@override final  double rawPrice;
@override final  String productType;

/// Create a copy of IapProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IapProductDtoCopyWith<_IapProductDto> get copyWith => __$IapProductDtoCopyWithImpl<_IapProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IapProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IapProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.rawPrice, rawPrice) || other.rawPrice == rawPrice)&&(identical(other.productType, productType) || other.productType == productType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,price,currencyCode,rawPrice,productType);

@override
String toString() {
  return 'IapProductDto(id: $id, title: $title, description: $description, price: $price, currencyCode: $currencyCode, rawPrice: $rawPrice, productType: $productType)';
}


}

/// @nodoc
abstract mixin class _$IapProductDtoCopyWith<$Res> implements $IapProductDtoCopyWith<$Res> {
  factory _$IapProductDtoCopyWith(_IapProductDto value, $Res Function(_IapProductDto) _then) = __$IapProductDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String price, String currencyCode, double rawPrice, String productType
});




}
/// @nodoc
class __$IapProductDtoCopyWithImpl<$Res>
    implements _$IapProductDtoCopyWith<$Res> {
  __$IapProductDtoCopyWithImpl(this._self, this._then);

  final _IapProductDto _self;
  final $Res Function(_IapProductDto) _then;

/// Create a copy of IapProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? price = null,Object? currencyCode = null,Object? rawPrice = null,Object? productType = null,}) {
  return _then(_IapProductDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,rawPrice: null == rawPrice ? _self.rawPrice : rawPrice // ignore: cast_nullable_to_non_nullable
as double,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
