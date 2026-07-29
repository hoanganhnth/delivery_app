// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageDto<T> {

 List<T> get items; int get page; int get size; int get totalItems; int get totalPages; bool get hasNext;
/// Create a copy of PageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageDtoCopyWith<T, PageDto<T>> get copyWith => _$PageDtoCopyWithImpl<T, PageDto<T>>(this as PageDto<T>, _$identity);

  /// Serializes this PageDto to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageDto<T>&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),page,size,totalItems,totalPages,hasNext);

@override
String toString() {
  return 'PageDto<$T>(items: $items, page: $page, size: $size, totalItems: $totalItems, totalPages: $totalPages, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class $PageDtoCopyWith<T,$Res>  {
  factory $PageDtoCopyWith(PageDto<T> value, $Res Function(PageDto<T>) _then) = _$PageDtoCopyWithImpl;
@useResult
$Res call({
 List<T> items, int page, int size, int totalItems, int totalPages, bool hasNext
});




}
/// @nodoc
class _$PageDtoCopyWithImpl<T,$Res>
    implements $PageDtoCopyWith<T, $Res> {
  _$PageDtoCopyWithImpl(this._self, this._then);

  final PageDto<T> _self;
  final $Res Function(PageDto<T>) _then;

/// Create a copy of PageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? size = null,Object? totalItems = null,Object? totalPages = null,Object? hasNext = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PageDto].
extension PageDtoPatterns<T> on PageDto<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageDto<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageDto<T> value)  $default,){
final _that = this;
switch (_that) {
case _PageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageDto<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> items,  int page,  int size,  int totalItems,  int totalPages,  bool hasNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageDto() when $default != null:
return $default(_that.items,_that.page,_that.size,_that.totalItems,_that.totalPages,_that.hasNext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> items,  int page,  int size,  int totalItems,  int totalPages,  bool hasNext)  $default,) {final _that = this;
switch (_that) {
case _PageDto():
return $default(_that.items,_that.page,_that.size,_that.totalItems,_that.totalPages,_that.hasNext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> items,  int page,  int size,  int totalItems,  int totalPages,  bool hasNext)?  $default,) {final _that = this;
switch (_that) {
case _PageDto() when $default != null:
return $default(_that.items,_that.page,_that.size,_that.totalItems,_that.totalPages,_that.hasNext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _PageDto<T> implements PageDto<T> {
  const _PageDto({required final  List<T> items, required this.page, required this.size, required this.totalItems, required this.totalPages, required this.hasNext}): _items = items;
  factory _PageDto.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$PageDtoFromJson(json,fromJsonT);

 final  List<T> _items;
@override List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int page;
@override final  int size;
@override final  int totalItems;
@override final  int totalPages;
@override final  bool hasNext;

/// Create a copy of PageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageDtoCopyWith<T, _PageDto<T>> get copyWith => __$PageDtoCopyWithImpl<T, _PageDto<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$PageDtoToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageDto<T>&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,size,totalItems,totalPages,hasNext);

@override
String toString() {
  return 'PageDto<$T>(items: $items, page: $page, size: $size, totalItems: $totalItems, totalPages: $totalPages, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class _$PageDtoCopyWith<T,$Res> implements $PageDtoCopyWith<T, $Res> {
  factory _$PageDtoCopyWith(_PageDto<T> value, $Res Function(_PageDto<T>) _then) = __$PageDtoCopyWithImpl;
@override @useResult
$Res call({
 List<T> items, int page, int size, int totalItems, int totalPages, bool hasNext
});




}
/// @nodoc
class __$PageDtoCopyWithImpl<T,$Res>
    implements _$PageDtoCopyWith<T, $Res> {
  __$PageDtoCopyWithImpl(this._self, this._then);

  final _PageDto<T> _self;
  final $Res Function(_PageDto<T>) _then;

/// Create a copy of PageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? size = null,Object? totalItems = null,Object? totalPages = null,Object? hasNext = null,}) {
  return _then(_PageDto<T>(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
