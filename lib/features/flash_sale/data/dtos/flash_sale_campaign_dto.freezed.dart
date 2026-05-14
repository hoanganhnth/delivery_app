// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flash_sale_campaign_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FlashSaleCampaignDto {

 int get id; String get name; bool get isRecurring; String get startTime; String get endTime;
/// Create a copy of FlashSaleCampaignDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashSaleCampaignDtoCopyWith<FlashSaleCampaignDto> get copyWith => _$FlashSaleCampaignDtoCopyWithImpl<FlashSaleCampaignDto>(this as FlashSaleCampaignDto, _$identity);

  /// Serializes this FlashSaleCampaignDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashSaleCampaignDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isRecurring,startTime,endTime);

@override
String toString() {
  return 'FlashSaleCampaignDto(id: $id, name: $name, isRecurring: $isRecurring, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $FlashSaleCampaignDtoCopyWith<$Res>  {
  factory $FlashSaleCampaignDtoCopyWith(FlashSaleCampaignDto value, $Res Function(FlashSaleCampaignDto) _then) = _$FlashSaleCampaignDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, bool isRecurring, String startTime, String endTime
});




}
/// @nodoc
class _$FlashSaleCampaignDtoCopyWithImpl<$Res>
    implements $FlashSaleCampaignDtoCopyWith<$Res> {
  _$FlashSaleCampaignDtoCopyWithImpl(this._self, this._then);

  final FlashSaleCampaignDto _self;
  final $Res Function(FlashSaleCampaignDto) _then;

/// Create a copy of FlashSaleCampaignDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isRecurring = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashSaleCampaignDto].
extension FlashSaleCampaignDtoPatterns on FlashSaleCampaignDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashSaleCampaignDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashSaleCampaignDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashSaleCampaignDto value)  $default,){
final _that = this;
switch (_that) {
case _FlashSaleCampaignDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashSaleCampaignDto value)?  $default,){
final _that = this;
switch (_that) {
case _FlashSaleCampaignDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  bool isRecurring,  String startTime,  String endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashSaleCampaignDto() when $default != null:
return $default(_that.id,_that.name,_that.isRecurring,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  bool isRecurring,  String startTime,  String endTime)  $default,) {final _that = this;
switch (_that) {
case _FlashSaleCampaignDto():
return $default(_that.id,_that.name,_that.isRecurring,_that.startTime,_that.endTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  bool isRecurring,  String startTime,  String endTime)?  $default,) {final _that = this;
switch (_that) {
case _FlashSaleCampaignDto() when $default != null:
return $default(_that.id,_that.name,_that.isRecurring,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlashSaleCampaignDto implements FlashSaleCampaignDto {
  const _FlashSaleCampaignDto({required this.id, required this.name, required this.isRecurring, required this.startTime, required this.endTime});
  factory _FlashSaleCampaignDto.fromJson(Map<String, dynamic> json) => _$FlashSaleCampaignDtoFromJson(json);

@override final  int id;
@override final  String name;
@override final  bool isRecurring;
@override final  String startTime;
@override final  String endTime;

/// Create a copy of FlashSaleCampaignDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashSaleCampaignDtoCopyWith<_FlashSaleCampaignDto> get copyWith => __$FlashSaleCampaignDtoCopyWithImpl<_FlashSaleCampaignDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlashSaleCampaignDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashSaleCampaignDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isRecurring,startTime,endTime);

@override
String toString() {
  return 'FlashSaleCampaignDto(id: $id, name: $name, isRecurring: $isRecurring, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$FlashSaleCampaignDtoCopyWith<$Res> implements $FlashSaleCampaignDtoCopyWith<$Res> {
  factory _$FlashSaleCampaignDtoCopyWith(_FlashSaleCampaignDto value, $Res Function(_FlashSaleCampaignDto) _then) = __$FlashSaleCampaignDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, bool isRecurring, String startTime, String endTime
});




}
/// @nodoc
class __$FlashSaleCampaignDtoCopyWithImpl<$Res>
    implements _$FlashSaleCampaignDtoCopyWith<$Res> {
  __$FlashSaleCampaignDtoCopyWithImpl(this._self, this._then);

  final _FlashSaleCampaignDto _self;
  final $Res Function(_FlashSaleCampaignDto) _then;

/// Create a copy of FlashSaleCampaignDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isRecurring = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_FlashSaleCampaignDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
