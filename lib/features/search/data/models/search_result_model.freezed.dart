// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestaurantSearchResult {

 String get id; String get name; String? get description; String? get cuisine; double? get rating; String? get imageUrl;
/// Create a copy of RestaurantSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantSearchResultCopyWith<RestaurantSearchResult> get copyWith => _$RestaurantSearchResultCopyWithImpl<RestaurantSearchResult>(this as RestaurantSearchResult, _$identity);

  /// Serializes this RestaurantSearchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.cuisine, cuisine) || other.cuisine == cuisine)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,cuisine,rating,imageUrl);

@override
String toString() {
  return 'RestaurantSearchResult(id: $id, name: $name, description: $description, cuisine: $cuisine, rating: $rating, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $RestaurantSearchResultCopyWith<$Res>  {
  factory $RestaurantSearchResultCopyWith(RestaurantSearchResult value, $Res Function(RestaurantSearchResult) _then) = _$RestaurantSearchResultCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String? cuisine, double? rating, String? imageUrl
});




}
/// @nodoc
class _$RestaurantSearchResultCopyWithImpl<$Res>
    implements $RestaurantSearchResultCopyWith<$Res> {
  _$RestaurantSearchResultCopyWithImpl(this._self, this._then);

  final RestaurantSearchResult _self;
  final $Res Function(RestaurantSearchResult) _then;

/// Create a copy of RestaurantSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? cuisine = freezed,Object? rating = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,cuisine: freezed == cuisine ? _self.cuisine : cuisine // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantSearchResult].
extension RestaurantSearchResultPatterns on RestaurantSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? cuisine,  double? rating,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantSearchResult() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.cuisine,_that.rating,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? cuisine,  double? rating,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _RestaurantSearchResult():
return $default(_that.id,_that.name,_that.description,_that.cuisine,_that.rating,_that.imageUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String? cuisine,  double? rating,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantSearchResult() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.cuisine,_that.rating,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestaurantSearchResult implements RestaurantSearchResult {
  const _RestaurantSearchResult({required this.id, required this.name, this.description, this.cuisine, this.rating, this.imageUrl});
  factory _RestaurantSearchResult.fromJson(Map<String, dynamic> json) => _$RestaurantSearchResultFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  String? cuisine;
@override final  double? rating;
@override final  String? imageUrl;

/// Create a copy of RestaurantSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantSearchResultCopyWith<_RestaurantSearchResult> get copyWith => __$RestaurantSearchResultCopyWithImpl<_RestaurantSearchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantSearchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.cuisine, cuisine) || other.cuisine == cuisine)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,cuisine,rating,imageUrl);

@override
String toString() {
  return 'RestaurantSearchResult(id: $id, name: $name, description: $description, cuisine: $cuisine, rating: $rating, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$RestaurantSearchResultCopyWith<$Res> implements $RestaurantSearchResultCopyWith<$Res> {
  factory _$RestaurantSearchResultCopyWith(_RestaurantSearchResult value, $Res Function(_RestaurantSearchResult) _then) = __$RestaurantSearchResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String? cuisine, double? rating, String? imageUrl
});




}
/// @nodoc
class __$RestaurantSearchResultCopyWithImpl<$Res>
    implements _$RestaurantSearchResultCopyWith<$Res> {
  __$RestaurantSearchResultCopyWithImpl(this._self, this._then);

  final _RestaurantSearchResult _self;
  final $Res Function(_RestaurantSearchResult) _then;

/// Create a copy of RestaurantSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? cuisine = freezed,Object? rating = freezed,Object? imageUrl = freezed,}) {
  return _then(_RestaurantSearchResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,cuisine: freezed == cuisine ? _self.cuisine : cuisine // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DishSearchResult {

 String get id; String get name; String? get description; double? get price; String? get restaurantId; String? get imageUrl;
/// Create a copy of DishSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DishSearchResultCopyWith<DishSearchResult> get copyWith => _$DishSearchResultCopyWithImpl<DishSearchResult>(this as DishSearchResult, _$identity);

  /// Serializes this DishSearchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DishSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,restaurantId,imageUrl);

@override
String toString() {
  return 'DishSearchResult(id: $id, name: $name, description: $description, price: $price, restaurantId: $restaurantId, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $DishSearchResultCopyWith<$Res>  {
  factory $DishSearchResultCopyWith(DishSearchResult value, $Res Function(DishSearchResult) _then) = _$DishSearchResultCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, double? price, String? restaurantId, String? imageUrl
});




}
/// @nodoc
class _$DishSearchResultCopyWithImpl<$Res>
    implements $DishSearchResultCopyWith<$Res> {
  _$DishSearchResultCopyWithImpl(this._self, this._then);

  final DishSearchResult _self;
  final $Res Function(DishSearchResult) _then;

/// Create a copy of DishSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? price = freezed,Object? restaurantId = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,restaurantId: freezed == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DishSearchResult].
extension DishSearchResultPatterns on DishSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DishSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DishSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DishSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _DishSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DishSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _DishSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  double? price,  String? restaurantId,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DishSearchResult() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.restaurantId,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  double? price,  String? restaurantId,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _DishSearchResult():
return $default(_that.id,_that.name,_that.description,_that.price,_that.restaurantId,_that.imageUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  double? price,  String? restaurantId,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _DishSearchResult() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.restaurantId,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DishSearchResult implements DishSearchResult {
  const _DishSearchResult({required this.id, required this.name, this.description, this.price, this.restaurantId, this.imageUrl});
  factory _DishSearchResult.fromJson(Map<String, dynamic> json) => _$DishSearchResultFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  double? price;
@override final  String? restaurantId;
@override final  String? imageUrl;

/// Create a copy of DishSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DishSearchResultCopyWith<_DishSearchResult> get copyWith => __$DishSearchResultCopyWithImpl<_DishSearchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DishSearchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DishSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,restaurantId,imageUrl);

@override
String toString() {
  return 'DishSearchResult(id: $id, name: $name, description: $description, price: $price, restaurantId: $restaurantId, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$DishSearchResultCopyWith<$Res> implements $DishSearchResultCopyWith<$Res> {
  factory _$DishSearchResultCopyWith(_DishSearchResult value, $Res Function(_DishSearchResult) _then) = __$DishSearchResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, double? price, String? restaurantId, String? imageUrl
});




}
/// @nodoc
class __$DishSearchResultCopyWithImpl<$Res>
    implements _$DishSearchResultCopyWith<$Res> {
  __$DishSearchResultCopyWithImpl(this._self, this._then);

  final _DishSearchResult _self;
  final $Res Function(_DishSearchResult) _then;

/// Create a copy of DishSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? price = freezed,Object? restaurantId = freezed,Object? imageUrl = freezed,}) {
  return _then(_DishSearchResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,restaurantId: freezed == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ShipperSearchResult {

 String get id; String get name; String? get vehicleType; String? get licensePlate; double? get rating; bool? get isOnline;
/// Create a copy of ShipperSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipperSearchResultCopyWith<ShipperSearchResult> get copyWith => _$ShipperSearchResultCopyWithImpl<ShipperSearchResult>(this as ShipperSearchResult, _$identity);

  /// Serializes this ShipperSearchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipperSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,vehicleType,licensePlate,rating,isOnline);

@override
String toString() {
  return 'ShipperSearchResult(id: $id, name: $name, vehicleType: $vehicleType, licensePlate: $licensePlate, rating: $rating, isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class $ShipperSearchResultCopyWith<$Res>  {
  factory $ShipperSearchResultCopyWith(ShipperSearchResult value, $Res Function(ShipperSearchResult) _then) = _$ShipperSearchResultCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? vehicleType, String? licensePlate, double? rating, bool? isOnline
});




}
/// @nodoc
class _$ShipperSearchResultCopyWithImpl<$Res>
    implements $ShipperSearchResultCopyWith<$Res> {
  _$ShipperSearchResultCopyWithImpl(this._self, this._then);

  final ShipperSearchResult _self;
  final $Res Function(ShipperSearchResult) _then;

/// Create a copy of ShipperSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? vehicleType = freezed,Object? licensePlate = freezed,Object? rating = freezed,Object? isOnline = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vehicleType: freezed == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String?,licensePlate: freezed == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipperSearchResult].
extension ShipperSearchResultPatterns on ShipperSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipperSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipperSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipperSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _ShipperSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipperSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _ShipperSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? vehicleType,  String? licensePlate,  double? rating,  bool? isOnline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipperSearchResult() when $default != null:
return $default(_that.id,_that.name,_that.vehicleType,_that.licensePlate,_that.rating,_that.isOnline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? vehicleType,  String? licensePlate,  double? rating,  bool? isOnline)  $default,) {final _that = this;
switch (_that) {
case _ShipperSearchResult():
return $default(_that.id,_that.name,_that.vehicleType,_that.licensePlate,_that.rating,_that.isOnline);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? vehicleType,  String? licensePlate,  double? rating,  bool? isOnline)?  $default,) {final _that = this;
switch (_that) {
case _ShipperSearchResult() when $default != null:
return $default(_that.id,_that.name,_that.vehicleType,_that.licensePlate,_that.rating,_that.isOnline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShipperSearchResult implements ShipperSearchResult {
  const _ShipperSearchResult({required this.id, required this.name, this.vehicleType, this.licensePlate, this.rating, this.isOnline});
  factory _ShipperSearchResult.fromJson(Map<String, dynamic> json) => _$ShipperSearchResultFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? vehicleType;
@override final  String? licensePlate;
@override final  double? rating;
@override final  bool? isOnline;

/// Create a copy of ShipperSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipperSearchResultCopyWith<_ShipperSearchResult> get copyWith => __$ShipperSearchResultCopyWithImpl<_ShipperSearchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShipperSearchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipperSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,vehicleType,licensePlate,rating,isOnline);

@override
String toString() {
  return 'ShipperSearchResult(id: $id, name: $name, vehicleType: $vehicleType, licensePlate: $licensePlate, rating: $rating, isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class _$ShipperSearchResultCopyWith<$Res> implements $ShipperSearchResultCopyWith<$Res> {
  factory _$ShipperSearchResultCopyWith(_ShipperSearchResult value, $Res Function(_ShipperSearchResult) _then) = __$ShipperSearchResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? vehicleType, String? licensePlate, double? rating, bool? isOnline
});




}
/// @nodoc
class __$ShipperSearchResultCopyWithImpl<$Res>
    implements _$ShipperSearchResultCopyWith<$Res> {
  __$ShipperSearchResultCopyWithImpl(this._self, this._then);

  final _ShipperSearchResult _self;
  final $Res Function(_ShipperSearchResult) _then;

/// Create a copy of ShipperSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? vehicleType = freezed,Object? licensePlate = freezed,Object? rating = freezed,Object? isOnline = freezed,}) {
  return _then(_ShipperSearchResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vehicleType: freezed == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String?,licensePlate: freezed == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,isOnline: freezed == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
