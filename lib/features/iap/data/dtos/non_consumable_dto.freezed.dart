// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'non_consumable_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NonConsumableDto {

 String get productId; String get title; String get description; String get price; String get currencyCode; double get rawPrice; String get featureType; bool get isUnlocked; DateTime? get purchaseDate;
/// Create a copy of NonConsumableDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NonConsumableDtoCopyWith<NonConsumableDto> get copyWith => _$NonConsumableDtoCopyWithImpl<NonConsumableDto>(this as NonConsumableDto, _$identity);

  /// Serializes this NonConsumableDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NonConsumableDto&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.rawPrice, rawPrice) || other.rawPrice == rawPrice)&&(identical(other.featureType, featureType) || other.featureType == featureType)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,title,description,price,currencyCode,rawPrice,featureType,isUnlocked,purchaseDate);

@override
String toString() {
  return 'NonConsumableDto(productId: $productId, title: $title, description: $description, price: $price, currencyCode: $currencyCode, rawPrice: $rawPrice, featureType: $featureType, isUnlocked: $isUnlocked, purchaseDate: $purchaseDate)';
}


}

/// @nodoc
abstract mixin class $NonConsumableDtoCopyWith<$Res>  {
  factory $NonConsumableDtoCopyWith(NonConsumableDto value, $Res Function(NonConsumableDto) _then) = _$NonConsumableDtoCopyWithImpl;
@useResult
$Res call({
 String productId, String title, String description, String price, String currencyCode, double rawPrice, String featureType, bool isUnlocked, DateTime? purchaseDate
});




}
/// @nodoc
class _$NonConsumableDtoCopyWithImpl<$Res>
    implements $NonConsumableDtoCopyWith<$Res> {
  _$NonConsumableDtoCopyWithImpl(this._self, this._then);

  final NonConsumableDto _self;
  final $Res Function(NonConsumableDto) _then;

/// Create a copy of NonConsumableDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? title = null,Object? description = null,Object? price = null,Object? currencyCode = null,Object? rawPrice = null,Object? featureType = null,Object? isUnlocked = null,Object? purchaseDate = freezed,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,rawPrice: null == rawPrice ? _self.rawPrice : rawPrice // ignore: cast_nullable_to_non_nullable
as double,featureType: null == featureType ? _self.featureType : featureType // ignore: cast_nullable_to_non_nullable
as String,isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,purchaseDate: freezed == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [NonConsumableDto].
extension NonConsumableDtoPatterns on NonConsumableDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NonConsumableDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NonConsumableDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NonConsumableDto value)  $default,){
final _that = this;
switch (_that) {
case _NonConsumableDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NonConsumableDto value)?  $default,){
final _that = this;
switch (_that) {
case _NonConsumableDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  String title,  String description,  String price,  String currencyCode,  double rawPrice,  String featureType,  bool isUnlocked,  DateTime? purchaseDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NonConsumableDto() when $default != null:
return $default(_that.productId,_that.title,_that.description,_that.price,_that.currencyCode,_that.rawPrice,_that.featureType,_that.isUnlocked,_that.purchaseDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  String title,  String description,  String price,  String currencyCode,  double rawPrice,  String featureType,  bool isUnlocked,  DateTime? purchaseDate)  $default,) {final _that = this;
switch (_that) {
case _NonConsumableDto():
return $default(_that.productId,_that.title,_that.description,_that.price,_that.currencyCode,_that.rawPrice,_that.featureType,_that.isUnlocked,_that.purchaseDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  String title,  String description,  String price,  String currencyCode,  double rawPrice,  String featureType,  bool isUnlocked,  DateTime? purchaseDate)?  $default,) {final _that = this;
switch (_that) {
case _NonConsumableDto() when $default != null:
return $default(_that.productId,_that.title,_that.description,_that.price,_that.currencyCode,_that.rawPrice,_that.featureType,_that.isUnlocked,_that.purchaseDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NonConsumableDto extends NonConsumableDto {
  const _NonConsumableDto({required this.productId, required this.title, required this.description, required this.price, required this.currencyCode, required this.rawPrice, required this.featureType, this.isUnlocked = false, this.purchaseDate}): super._();
  factory _NonConsumableDto.fromJson(Map<String, dynamic> json) => _$NonConsumableDtoFromJson(json);

@override final  String productId;
@override final  String title;
@override final  String description;
@override final  String price;
@override final  String currencyCode;
@override final  double rawPrice;
@override final  String featureType;
@override@JsonKey() final  bool isUnlocked;
@override final  DateTime? purchaseDate;

/// Create a copy of NonConsumableDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NonConsumableDtoCopyWith<_NonConsumableDto> get copyWith => __$NonConsumableDtoCopyWithImpl<_NonConsumableDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NonConsumableDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NonConsumableDto&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.rawPrice, rawPrice) || other.rawPrice == rawPrice)&&(identical(other.featureType, featureType) || other.featureType == featureType)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,title,description,price,currencyCode,rawPrice,featureType,isUnlocked,purchaseDate);

@override
String toString() {
  return 'NonConsumableDto(productId: $productId, title: $title, description: $description, price: $price, currencyCode: $currencyCode, rawPrice: $rawPrice, featureType: $featureType, isUnlocked: $isUnlocked, purchaseDate: $purchaseDate)';
}


}

/// @nodoc
abstract mixin class _$NonConsumableDtoCopyWith<$Res> implements $NonConsumableDtoCopyWith<$Res> {
  factory _$NonConsumableDtoCopyWith(_NonConsumableDto value, $Res Function(_NonConsumableDto) _then) = __$NonConsumableDtoCopyWithImpl;
@override @useResult
$Res call({
 String productId, String title, String description, String price, String currencyCode, double rawPrice, String featureType, bool isUnlocked, DateTime? purchaseDate
});




}
/// @nodoc
class __$NonConsumableDtoCopyWithImpl<$Res>
    implements _$NonConsumableDtoCopyWith<$Res> {
  __$NonConsumableDtoCopyWithImpl(this._self, this._then);

  final _NonConsumableDto _self;
  final $Res Function(_NonConsumableDto) _then;

/// Create a copy of NonConsumableDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? title = null,Object? description = null,Object? price = null,Object? currencyCode = null,Object? rawPrice = null,Object? featureType = null,Object? isUnlocked = null,Object? purchaseDate = freezed,}) {
  return _then(_NonConsumableDto(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,rawPrice: null == rawPrice ? _self.rawPrice : rawPrice // ignore: cast_nullable_to_non_nullable
as double,featureType: null == featureType ? _self.featureType : featureType // ignore: cast_nullable_to_non_nullable
as String,isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,purchaseDate: freezed == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$UnlockedFeaturesDto {

 List<String> get featureIds; DateTime get lastUpdated;
/// Create a copy of UnlockedFeaturesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnlockedFeaturesDtoCopyWith<UnlockedFeaturesDto> get copyWith => _$UnlockedFeaturesDtoCopyWithImpl<UnlockedFeaturesDto>(this as UnlockedFeaturesDto, _$identity);

  /// Serializes this UnlockedFeaturesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockedFeaturesDto&&const DeepCollectionEquality().equals(other.featureIds, featureIds)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(featureIds),lastUpdated);

@override
String toString() {
  return 'UnlockedFeaturesDto(featureIds: $featureIds, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $UnlockedFeaturesDtoCopyWith<$Res>  {
  factory $UnlockedFeaturesDtoCopyWith(UnlockedFeaturesDto value, $Res Function(UnlockedFeaturesDto) _then) = _$UnlockedFeaturesDtoCopyWithImpl;
@useResult
$Res call({
 List<String> featureIds, DateTime lastUpdated
});




}
/// @nodoc
class _$UnlockedFeaturesDtoCopyWithImpl<$Res>
    implements $UnlockedFeaturesDtoCopyWith<$Res> {
  _$UnlockedFeaturesDtoCopyWithImpl(this._self, this._then);

  final UnlockedFeaturesDto _self;
  final $Res Function(UnlockedFeaturesDto) _then;

/// Create a copy of UnlockedFeaturesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? featureIds = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
featureIds: null == featureIds ? _self.featureIds : featureIds // ignore: cast_nullable_to_non_nullable
as List<String>,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UnlockedFeaturesDto].
extension UnlockedFeaturesDtoPatterns on UnlockedFeaturesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnlockedFeaturesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnlockedFeaturesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnlockedFeaturesDto value)  $default,){
final _that = this;
switch (_that) {
case _UnlockedFeaturesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnlockedFeaturesDto value)?  $default,){
final _that = this;
switch (_that) {
case _UnlockedFeaturesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> featureIds,  DateTime lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnlockedFeaturesDto() when $default != null:
return $default(_that.featureIds,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> featureIds,  DateTime lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _UnlockedFeaturesDto():
return $default(_that.featureIds,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> featureIds,  DateTime lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _UnlockedFeaturesDto() when $default != null:
return $default(_that.featureIds,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnlockedFeaturesDto extends UnlockedFeaturesDto {
  const _UnlockedFeaturesDto({required final  List<String> featureIds, required this.lastUpdated}): _featureIds = featureIds,super._();
  factory _UnlockedFeaturesDto.fromJson(Map<String, dynamic> json) => _$UnlockedFeaturesDtoFromJson(json);

 final  List<String> _featureIds;
@override List<String> get featureIds {
  if (_featureIds is EqualUnmodifiableListView) return _featureIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featureIds);
}

@override final  DateTime lastUpdated;

/// Create a copy of UnlockedFeaturesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnlockedFeaturesDtoCopyWith<_UnlockedFeaturesDto> get copyWith => __$UnlockedFeaturesDtoCopyWithImpl<_UnlockedFeaturesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnlockedFeaturesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnlockedFeaturesDto&&const DeepCollectionEquality().equals(other._featureIds, _featureIds)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_featureIds),lastUpdated);

@override
String toString() {
  return 'UnlockedFeaturesDto(featureIds: $featureIds, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$UnlockedFeaturesDtoCopyWith<$Res> implements $UnlockedFeaturesDtoCopyWith<$Res> {
  factory _$UnlockedFeaturesDtoCopyWith(_UnlockedFeaturesDto value, $Res Function(_UnlockedFeaturesDto) _then) = __$UnlockedFeaturesDtoCopyWithImpl;
@override @useResult
$Res call({
 List<String> featureIds, DateTime lastUpdated
});




}
/// @nodoc
class __$UnlockedFeaturesDtoCopyWithImpl<$Res>
    implements _$UnlockedFeaturesDtoCopyWith<$Res> {
  __$UnlockedFeaturesDtoCopyWithImpl(this._self, this._then);

  final _UnlockedFeaturesDto _self;
  final $Res Function(_UnlockedFeaturesDto) _then;

/// Create a copy of UnlockedFeaturesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? featureIds = null,Object? lastUpdated = null,}) {
  return _then(_UnlockedFeaturesDto(
featureIds: null == featureIds ? _self._featureIds : featureIds // ignore: cast_nullable_to_non_nullable
as List<String>,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
