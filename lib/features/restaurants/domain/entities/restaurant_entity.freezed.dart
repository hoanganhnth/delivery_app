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
  String get id;
  String get name;
  String? get description;
  String get address;
  String? get phone;
  String? get image; // required double rating,
// required int reviewCount,
// required double deliveryFee,
// required int deliveryTime, // in minutes
// required bool isOpen,
  DateTime? get closingHour;
  DateTime? get openingHour; // required List<String> categories,
  double? get addressLat;
  double? get addressLng;

  /// Create a copy of RestaurantEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RestaurantEntityCopyWith<RestaurantEntity> get copyWith =>
      _$RestaurantEntityCopyWithImpl<RestaurantEntity>(
          this as RestaurantEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RestaurantEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.closingHour, closingHour) ||
                other.closingHour == closingHour) &&
            (identical(other.openingHour, openingHour) ||
                other.openingHour == openingHour) &&
            (identical(other.addressLat, addressLat) ||
                other.addressLat == addressLat) &&
            (identical(other.addressLng, addressLng) ||
                other.addressLng == addressLng));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, address,
      phone, image, closingHour, openingHour, addressLat, addressLng);

  @override
  String toString() {
    return 'RestaurantEntity(id: $id, name: $name, description: $description, address: $address, phone: $phone, image: $image, closingHour: $closingHour, openingHour: $openingHour, addressLat: $addressLat, addressLng: $addressLng)';
  }
}

/// @nodoc
abstract mixin class $RestaurantEntityCopyWith<$Res> {
  factory $RestaurantEntityCopyWith(
          RestaurantEntity value, $Res Function(RestaurantEntity) _then) =
      _$RestaurantEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String address,
      String? phone,
      String? image,
      DateTime? closingHour,
      DateTime? openingHour,
      double? addressLat,
      double? addressLng});
}

/// @nodoc
class _$RestaurantEntityCopyWithImpl<$Res>
    implements $RestaurantEntityCopyWith<$Res> {
  _$RestaurantEntityCopyWithImpl(this._self, this._then);

  final RestaurantEntity _self;
  final $Res Function(RestaurantEntity) _then;

  /// Create a copy of RestaurantEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? address = null,
    Object? phone = freezed,
    Object? image = freezed,
    Object? closingHour = freezed,
    Object? openingHour = freezed,
    Object? addressLat = freezed,
    Object? addressLng = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      closingHour: freezed == closingHour
          ? _self.closingHour
          : closingHour // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      openingHour: freezed == openingHour
          ? _self.openingHour
          : openingHour // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addressLat: freezed == addressLat
          ? _self.addressLat
          : addressLat // ignore: cast_nullable_to_non_nullable
              as double?,
      addressLng: freezed == addressLng
          ? _self.addressLng
          : addressLng // ignore: cast_nullable_to_non_nullable
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RestaurantEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RestaurantEntity() when $default != null:
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
    TResult Function(_RestaurantEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestaurantEntity():
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
    TResult? Function(_RestaurantEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestaurantEntity() when $default != null:
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
            String id,
            String name,
            String? description,
            String address,
            String? phone,
            String? image,
            DateTime? closingHour,
            DateTime? openingHour,
            double? addressLat,
            double? addressLng)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RestaurantEntity() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.address,
            _that.phone,
            _that.image,
            _that.closingHour,
            _that.openingHour,
            _that.addressLat,
            _that.addressLng);
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
            String id,
            String name,
            String? description,
            String address,
            String? phone,
            String? image,
            DateTime? closingHour,
            DateTime? openingHour,
            double? addressLat,
            double? addressLng)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestaurantEntity():
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.address,
            _that.phone,
            _that.image,
            _that.closingHour,
            _that.openingHour,
            _that.addressLat,
            _that.addressLng);
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
            String id,
            String name,
            String? description,
            String address,
            String? phone,
            String? image,
            DateTime? closingHour,
            DateTime? openingHour,
            double? addressLat,
            double? addressLng)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestaurantEntity() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.address,
            _that.phone,
            _that.image,
            _that.closingHour,
            _that.openingHour,
            _that.addressLat,
            _that.addressLng);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RestaurantEntity implements RestaurantEntity {
  const _RestaurantEntity(
      {required this.id,
      required this.name,
      this.description,
      required this.address,
      this.phone,
      this.image,
      this.closingHour,
      this.openingHour,
      this.addressLat,
      this.addressLng});

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String address;
  @override
  final String? phone;
  @override
  final String? image;
// required double rating,
// required int reviewCount,
// required double deliveryFee,
// required int deliveryTime, // in minutes
// required bool isOpen,
  @override
  final DateTime? closingHour;
  @override
  final DateTime? openingHour;
// required List<String> categories,
  @override
  final double? addressLat;
  @override
  final double? addressLng;

  /// Create a copy of RestaurantEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RestaurantEntityCopyWith<_RestaurantEntity> get copyWith =>
      __$RestaurantEntityCopyWithImpl<_RestaurantEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RestaurantEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.closingHour, closingHour) ||
                other.closingHour == closingHour) &&
            (identical(other.openingHour, openingHour) ||
                other.openingHour == openingHour) &&
            (identical(other.addressLat, addressLat) ||
                other.addressLat == addressLat) &&
            (identical(other.addressLng, addressLng) ||
                other.addressLng == addressLng));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, address,
      phone, image, closingHour, openingHour, addressLat, addressLng);

  @override
  String toString() {
    return 'RestaurantEntity(id: $id, name: $name, description: $description, address: $address, phone: $phone, image: $image, closingHour: $closingHour, openingHour: $openingHour, addressLat: $addressLat, addressLng: $addressLng)';
  }
}

/// @nodoc
abstract mixin class _$RestaurantEntityCopyWith<$Res>
    implements $RestaurantEntityCopyWith<$Res> {
  factory _$RestaurantEntityCopyWith(
          _RestaurantEntity value, $Res Function(_RestaurantEntity) _then) =
      __$RestaurantEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String address,
      String? phone,
      String? image,
      DateTime? closingHour,
      DateTime? openingHour,
      double? addressLat,
      double? addressLng});
}

/// @nodoc
class __$RestaurantEntityCopyWithImpl<$Res>
    implements _$RestaurantEntityCopyWith<$Res> {
  __$RestaurantEntityCopyWithImpl(this._self, this._then);

  final _RestaurantEntity _self;
  final $Res Function(_RestaurantEntity) _then;

  /// Create a copy of RestaurantEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? address = null,
    Object? phone = freezed,
    Object? image = freezed,
    Object? closingHour = freezed,
    Object? openingHour = freezed,
    Object? addressLat = freezed,
    Object? addressLng = freezed,
  }) {
    return _then(_RestaurantEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      closingHour: freezed == closingHour
          ? _self.closingHour
          : closingHour // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      openingHour: freezed == openingHour
          ? _self.openingHour
          : openingHour // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addressLat: freezed == addressLat
          ? _self.addressLat
          : addressLat // ignore: cast_nullable_to_non_nullable
              as double?,
      addressLng: freezed == addressLng
          ? _self.addressLng
          : addressLng // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
