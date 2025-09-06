// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MenuItemDto {
  String? get id;
  String? get restaurantId;
  String get name;
  String get description;
  double get price;
  String? get image;
  MenuItemStatus get status;

  /// Create a copy of MenuItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MenuItemDtoCopyWith<MenuItemDto> get copyWith =>
      _$MenuItemDtoCopyWithImpl<MenuItemDto>(this as MenuItemDto, _$identity);

  /// Serializes this MenuItemDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MenuItemDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, restaurantId, name, description, price, image, status);

  @override
  String toString() {
    return 'MenuItemDto(id: $id, restaurantId: $restaurantId, name: $name, description: $description, price: $price, image: $image, status: $status)';
  }
}

/// @nodoc
abstract mixin class $MenuItemDtoCopyWith<$Res> {
  factory $MenuItemDtoCopyWith(
          MenuItemDto value, $Res Function(MenuItemDto) _then) =
      _$MenuItemDtoCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String? restaurantId,
      String name,
      String description,
      double price,
      String? image,
      MenuItemStatus status});
}

/// @nodoc
class _$MenuItemDtoCopyWithImpl<$Res> implements $MenuItemDtoCopyWith<$Res> {
  _$MenuItemDtoCopyWithImpl(this._self, this._then);

  final MenuItemDto _self;
  final $Res Function(MenuItemDto) _then;

  /// Create a copy of MenuItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? restaurantId = freezed,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? image = freezed,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      restaurantId: freezed == restaurantId
          ? _self.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as MenuItemStatus,
    ));
  }
}

/// Adds pattern-matching-related methods to [MenuItemDto].
extension MenuItemDtoPatterns on MenuItemDto {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MenuItemDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MenuItemDto() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MenuItemDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MenuItemDto():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MenuItemDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MenuItemDto() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String? id,
            String? restaurantId,
            String name,
            String description,
            double price,
            String? image,
            MenuItemStatus status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MenuItemDto() when $default != null:
        return $default(_that.id, _that.restaurantId, _that.name,
            _that.description, _that.price, _that.image, _that.status);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String? id,
            String? restaurantId,
            String name,
            String description,
            double price,
            String? image,
            MenuItemStatus status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MenuItemDto():
        return $default(_that.id, _that.restaurantId, _that.name,
            _that.description, _that.price, _that.image, _that.status);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String? id,
            String? restaurantId,
            String name,
            String description,
            double price,
            String? image,
            MenuItemStatus status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MenuItemDto() when $default != null:
        return $default(_that.id, _that.restaurantId, _that.name,
            _that.description, _that.price, _that.image, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MenuItemDto implements MenuItemDto {
  const _MenuItemDto(
      {this.id,
      this.restaurantId,
      required this.name,
      required this.description,
      required this.price,
      this.image,
      required this.status});
  factory _MenuItemDto.fromJson(Map<String, dynamic> json) =>
      _$MenuItemDtoFromJson(json);

  @override
  final String? id;
  @override
  final String? restaurantId;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final String? image;
  @override
  final MenuItemStatus status;

  /// Create a copy of MenuItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MenuItemDtoCopyWith<_MenuItemDto> get copyWith =>
      __$MenuItemDtoCopyWithImpl<_MenuItemDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MenuItemDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MenuItemDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, restaurantId, name, description, price, image, status);

  @override
  String toString() {
    return 'MenuItemDto(id: $id, restaurantId: $restaurantId, name: $name, description: $description, price: $price, image: $image, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$MenuItemDtoCopyWith<$Res>
    implements $MenuItemDtoCopyWith<$Res> {
  factory _$MenuItemDtoCopyWith(
          _MenuItemDto value, $Res Function(_MenuItemDto) _then) =
      __$MenuItemDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? restaurantId,
      String name,
      String description,
      double price,
      String? image,
      MenuItemStatus status});
}

/// @nodoc
class __$MenuItemDtoCopyWithImpl<$Res> implements _$MenuItemDtoCopyWith<$Res> {
  __$MenuItemDtoCopyWithImpl(this._self, this._then);

  final _MenuItemDto _self;
  final $Res Function(_MenuItemDto) _then;

  /// Create a copy of MenuItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? restaurantId = freezed,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? image = freezed,
    Object? status = null,
  }) {
    return _then(_MenuItemDto(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      restaurantId: freezed == restaurantId
          ? _self.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as MenuItemStatus,
    ));
  }
}

// dart format on
