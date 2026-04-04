// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RestaurantEntity {

 num get id; String get name; String? get description; String get address; String? get phone; String? get image; double? get rating; int? get reviewCount; double? get deliveryFee; int? get deliveryTime;// in minutes
 bool? get isOpen; String? get closingHour; String? get openingHour; String? get category; double? get addressLat; double? get addressLng; double? get distance;
/// Create a copy of RestaurantEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantEntityCopyWith<RestaurantEntity> get copyWith => _$RestaurantEntityCopyWithImpl<RestaurantEntity>(this as RestaurantEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.image, image) || other.image == image)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.closingHour, closingHour) || other.closingHour == closingHour)&&(identical(other.openingHour, openingHour) || other.openingHour == openingHour)&&(identical(other.category, category) || other.category == category)&&(identical(other.addressLat, addressLat) || other.addressLat == addressLat)&&(identical(other.addressLng, addressLng) || other.addressLng == addressLng)&&(identical(other.distance, distance) || other.distance == distance));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,phone,image,rating,reviewCount,deliveryFee,deliveryTime,isOpen,closingHour,openingHour,category,addressLat,addressLng,distance);

@override
String toString() {
  return 'RestaurantEntity(id: $id, name: $name, description: $description, address: $address, phone: $phone, image: $image, rating: $rating, reviewCount: $reviewCount, deliveryFee: $deliveryFee, deliveryTime: $deliveryTime, isOpen: $isOpen, closingHour: $closingHour, openingHour: $openingHour, category: $category, addressLat: $addressLat, addressLng: $addressLng, distance: $distance)';
}


}

/// @nodoc
abstract mixin class $RestaurantEntityCopyWith<$Res>  {
  factory $RestaurantEntityCopyWith(RestaurantEntity value, $Res Function(RestaurantEntity) _then) = _$RestaurantEntityCopyWithImpl;
@useResult
$Res call({
 num id, String name, String? description, String address, String? phone, String? image, double? rating, int? reviewCount, double? deliveryFee, int? deliveryTime, bool? isOpen, String? closingHour, String? openingHour, String? category, double? addressLat, double? addressLng, double? distance
});




}
/// @nodoc
class _$RestaurantEntityCopyWithImpl<$Res>
    implements $RestaurantEntityCopyWith<$Res> {
  _$RestaurantEntityCopyWithImpl(this._self, this._then);

  final RestaurantEntity _self;
  final $Res Function(RestaurantEntity) _then;

/// Create a copy of RestaurantEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? address = null,Object? phone = freezed,Object? image = freezed,Object? rating = freezed,Object? reviewCount = freezed,Object? deliveryFee = freezed,Object? deliveryTime = freezed,Object? isOpen = freezed,Object? closingHour = freezed,Object? openingHour = freezed,Object? category = freezed,Object? addressLat = freezed,Object? addressLng = freezed,Object? distance = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,deliveryFee: freezed == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double?,deliveryTime: freezed == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as int?,isOpen: freezed == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool?,closingHour: freezed == closingHour ? _self.closingHour : closingHour // ignore: cast_nullable_to_non_nullable
as String?,openingHour: freezed == openingHour ? _self.openingHour : openingHour // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,addressLat: freezed == addressLat ? _self.addressLat : addressLat // ignore: cast_nullable_to_non_nullable
as double?,addressLng: freezed == addressLng ? _self.addressLng : addressLng // ignore: cast_nullable_to_non_nullable
as double?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantEntity].
extension RestaurantEntityPatterns on RestaurantEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantEntity value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num id,  String name,  String? description,  String address,  String? phone,  String? image,  double? rating,  int? reviewCount,  double? deliveryFee,  int? deliveryTime,  bool? isOpen,  String? closingHour,  String? openingHour,  String? category,  double? addressLat,  double? addressLng,  double? distance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.phone,_that.image,_that.rating,_that.reviewCount,_that.deliveryFee,_that.deliveryTime,_that.isOpen,_that.closingHour,_that.openingHour,_that.category,_that.addressLat,_that.addressLng,_that.distance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num id,  String name,  String? description,  String address,  String? phone,  String? image,  double? rating,  int? reviewCount,  double? deliveryFee,  int? deliveryTime,  bool? isOpen,  String? closingHour,  String? openingHour,  String? category,  double? addressLat,  double? addressLng,  double? distance)  $default,) {final _that = this;
switch (_that) {
case _RestaurantEntity():
return $default(_that.id,_that.name,_that.description,_that.address,_that.phone,_that.image,_that.rating,_that.reviewCount,_that.deliveryFee,_that.deliveryTime,_that.isOpen,_that.closingHour,_that.openingHour,_that.category,_that.addressLat,_that.addressLng,_that.distance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num id,  String name,  String? description,  String address,  String? phone,  String? image,  double? rating,  int? reviewCount,  double? deliveryFee,  int? deliveryTime,  bool? isOpen,  String? closingHour,  String? openingHour,  String? category,  double? addressLat,  double? addressLng,  double? distance)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.phone,_that.image,_that.rating,_that.reviewCount,_that.deliveryFee,_that.deliveryTime,_that.isOpen,_that.closingHour,_that.openingHour,_that.category,_that.addressLat,_that.addressLng,_that.distance);case _:
  return null;

}
}

}

/// @nodoc


class _RestaurantEntity implements RestaurantEntity {
  const _RestaurantEntity({required this.id, required this.name, this.description, required this.address, this.phone, this.image, this.rating, this.reviewCount, this.deliveryFee, this.deliveryTime, this.isOpen, this.closingHour, this.openingHour, this.category, this.addressLat, this.addressLng, this.distance});
  

@override final  num id;
@override final  String name;
@override final  String? description;
@override final  String address;
@override final  String? phone;
@override final  String? image;
@override final  double? rating;
@override final  int? reviewCount;
@override final  double? deliveryFee;
@override final  int? deliveryTime;
// in minutes
@override final  bool? isOpen;
@override final  String? closingHour;
@override final  String? openingHour;
@override final  String? category;
@override final  double? addressLat;
@override final  double? addressLng;
@override final  double? distance;

/// Create a copy of RestaurantEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantEntityCopyWith<_RestaurantEntity> get copyWith => __$RestaurantEntityCopyWithImpl<_RestaurantEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.image, image) || other.image == image)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.closingHour, closingHour) || other.closingHour == closingHour)&&(identical(other.openingHour, openingHour) || other.openingHour == openingHour)&&(identical(other.category, category) || other.category == category)&&(identical(other.addressLat, addressLat) || other.addressLat == addressLat)&&(identical(other.addressLng, addressLng) || other.addressLng == addressLng)&&(identical(other.distance, distance) || other.distance == distance));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,phone,image,rating,reviewCount,deliveryFee,deliveryTime,isOpen,closingHour,openingHour,category,addressLat,addressLng,distance);

@override
String toString() {
  return 'RestaurantEntity(id: $id, name: $name, description: $description, address: $address, phone: $phone, image: $image, rating: $rating, reviewCount: $reviewCount, deliveryFee: $deliveryFee, deliveryTime: $deliveryTime, isOpen: $isOpen, closingHour: $closingHour, openingHour: $openingHour, category: $category, addressLat: $addressLat, addressLng: $addressLng, distance: $distance)';
}


}

/// @nodoc
abstract mixin class _$RestaurantEntityCopyWith<$Res> implements $RestaurantEntityCopyWith<$Res> {
  factory _$RestaurantEntityCopyWith(_RestaurantEntity value, $Res Function(_RestaurantEntity) _then) = __$RestaurantEntityCopyWithImpl;
@override @useResult
$Res call({
 num id, String name, String? description, String address, String? phone, String? image, double? rating, int? reviewCount, double? deliveryFee, int? deliveryTime, bool? isOpen, String? closingHour, String? openingHour, String? category, double? addressLat, double? addressLng, double? distance
});




}
/// @nodoc
class __$RestaurantEntityCopyWithImpl<$Res>
    implements _$RestaurantEntityCopyWith<$Res> {
  __$RestaurantEntityCopyWithImpl(this._self, this._then);

  final _RestaurantEntity _self;
  final $Res Function(_RestaurantEntity) _then;

/// Create a copy of RestaurantEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? address = null,Object? phone = freezed,Object? image = freezed,Object? rating = freezed,Object? reviewCount = freezed,Object? deliveryFee = freezed,Object? deliveryTime = freezed,Object? isOpen = freezed,Object? closingHour = freezed,Object? openingHour = freezed,Object? category = freezed,Object? addressLat = freezed,Object? addressLng = freezed,Object? distance = freezed,}) {
  return _then(_RestaurantEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,deliveryFee: freezed == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double?,deliveryTime: freezed == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as int?,isOpen: freezed == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool?,closingHour: freezed == closingHour ? _self.closingHour : closingHour // ignore: cast_nullable_to_non_nullable
as String?,openingHour: freezed == openingHour ? _self.openingHour : openingHour // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,addressLat: freezed == addressLat ? _self.addressLat : addressLat // ignore: cast_nullable_to_non_nullable
as double?,addressLng: freezed == addressLng ? _self.addressLng : addressLng // ignore: cast_nullable_to_non_nullable
as double?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
