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

 String get id; String get name; String get description; String get address; String get phone; String get imageUrl; double get rating; int get reviewCount; double get deliveryFee; int get deliveryTime;// in minutes
 bool get isOpen; List<String> get categories; double get latitude; double get longitude; DateTime? get openTime; DateTime? get closeTime;
/// Create a copy of RestaurantEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantEntityCopyWith<RestaurantEntity> get copyWith => _$RestaurantEntityCopyWithImpl<RestaurantEntity>(this as RestaurantEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.closeTime, closeTime) || other.closeTime == closeTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,phone,imageUrl,rating,reviewCount,deliveryFee,deliveryTime,isOpen,const DeepCollectionEquality().hash(categories),latitude,longitude,openTime,closeTime);

@override
String toString() {
  return 'RestaurantEntity(id: $id, name: $name, description: $description, address: $address, phone: $phone, imageUrl: $imageUrl, rating: $rating, reviewCount: $reviewCount, deliveryFee: $deliveryFee, deliveryTime: $deliveryTime, isOpen: $isOpen, categories: $categories, latitude: $latitude, longitude: $longitude, openTime: $openTime, closeTime: $closeTime)';
}


}

/// @nodoc
abstract mixin class $RestaurantEntityCopyWith<$Res>  {
  factory $RestaurantEntityCopyWith(RestaurantEntity value, $Res Function(RestaurantEntity) _then) = _$RestaurantEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String address, String phone, String imageUrl, double rating, int reviewCount, double deliveryFee, int deliveryTime, bool isOpen, List<String> categories, double latitude, double longitude, DateTime? openTime, DateTime? closeTime
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? address = null,Object? phone = null,Object? imageUrl = null,Object? rating = null,Object? reviewCount = null,Object? deliveryFee = null,Object? deliveryTime = null,Object? isOpen = null,Object? categories = null,Object? latitude = null,Object? longitude = null,Object? openTime = freezed,Object? closeTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as int,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,openTime: freezed == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as DateTime?,closeTime: freezed == closeTime ? _self.closeTime : closeTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String address,  String phone,  String imageUrl,  double rating,  int reviewCount,  double deliveryFee,  int deliveryTime,  bool isOpen,  List<String> categories,  double latitude,  double longitude,  DateTime? openTime,  DateTime? closeTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.phone,_that.imageUrl,_that.rating,_that.reviewCount,_that.deliveryFee,_that.deliveryTime,_that.isOpen,_that.categories,_that.latitude,_that.longitude,_that.openTime,_that.closeTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String address,  String phone,  String imageUrl,  double rating,  int reviewCount,  double deliveryFee,  int deliveryTime,  bool isOpen,  List<String> categories,  double latitude,  double longitude,  DateTime? openTime,  DateTime? closeTime)  $default,) {final _that = this;
switch (_that) {
case _RestaurantEntity():
return $default(_that.id,_that.name,_that.description,_that.address,_that.phone,_that.imageUrl,_that.rating,_that.reviewCount,_that.deliveryFee,_that.deliveryTime,_that.isOpen,_that.categories,_that.latitude,_that.longitude,_that.openTime,_that.closeTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String address,  String phone,  String imageUrl,  double rating,  int reviewCount,  double deliveryFee,  int deliveryTime,  bool isOpen,  List<String> categories,  double latitude,  double longitude,  DateTime? openTime,  DateTime? closeTime)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.phone,_that.imageUrl,_that.rating,_that.reviewCount,_that.deliveryFee,_that.deliveryTime,_that.isOpen,_that.categories,_that.latitude,_that.longitude,_that.openTime,_that.closeTime);case _:
  return null;

}
}

}

/// @nodoc


class _RestaurantEntity implements RestaurantEntity {
  const _RestaurantEntity({required this.id, required this.name, required this.description, required this.address, required this.phone, required this.imageUrl, required this.rating, required this.reviewCount, required this.deliveryFee, required this.deliveryTime, required this.isOpen, required final  List<String> categories, required this.latitude, required this.longitude, this.openTime, this.closeTime}): _categories = categories;
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String address;
@override final  String phone;
@override final  String imageUrl;
@override final  double rating;
@override final  int reviewCount;
@override final  double deliveryFee;
@override final  int deliveryTime;
// in minutes
@override final  bool isOpen;
 final  List<String> _categories;
@override List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  double latitude;
@override final  double longitude;
@override final  DateTime? openTime;
@override final  DateTime? closeTime;

/// Create a copy of RestaurantEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantEntityCopyWith<_RestaurantEntity> get copyWith => __$RestaurantEntityCopyWithImpl<_RestaurantEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.openTime, openTime) || other.openTime == openTime)&&(identical(other.closeTime, closeTime) || other.closeTime == closeTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,phone,imageUrl,rating,reviewCount,deliveryFee,deliveryTime,isOpen,const DeepCollectionEquality().hash(_categories),latitude,longitude,openTime,closeTime);

@override
String toString() {
  return 'RestaurantEntity(id: $id, name: $name, description: $description, address: $address, phone: $phone, imageUrl: $imageUrl, rating: $rating, reviewCount: $reviewCount, deliveryFee: $deliveryFee, deliveryTime: $deliveryTime, isOpen: $isOpen, categories: $categories, latitude: $latitude, longitude: $longitude, openTime: $openTime, closeTime: $closeTime)';
}


}

/// @nodoc
abstract mixin class _$RestaurantEntityCopyWith<$Res> implements $RestaurantEntityCopyWith<$Res> {
  factory _$RestaurantEntityCopyWith(_RestaurantEntity value, $Res Function(_RestaurantEntity) _then) = __$RestaurantEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String address, String phone, String imageUrl, double rating, int reviewCount, double deliveryFee, int deliveryTime, bool isOpen, List<String> categories, double latitude, double longitude, DateTime? openTime, DateTime? closeTime
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? address = null,Object? phone = null,Object? imageUrl = null,Object? rating = null,Object? reviewCount = null,Object? deliveryFee = null,Object? deliveryTime = null,Object? isOpen = null,Object? categories = null,Object? latitude = null,Object? longitude = null,Object? openTime = freezed,Object? closeTime = freezed,}) {
  return _then(_RestaurantEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as int,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,openTime: freezed == openTime ? _self.openTime : openTime // ignore: cast_nullable_to_non_nullable
as DateTime?,closeTime: freezed == closeTime ? _self.closeTime : closeTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
