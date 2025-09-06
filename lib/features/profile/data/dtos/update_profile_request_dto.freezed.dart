// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_profile_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateProfileRequestDto {
  String? get fullName;
  String? get phone;
  String? get dob;
  String? get address;

  /// Create a copy of UpdateProfileRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateProfileRequestDtoCopyWith<UpdateProfileRequestDto> get copyWith =>
      _$UpdateProfileRequestDtoCopyWithImpl<UpdateProfileRequestDto>(
          this as UpdateProfileRequestDto, _$identity);

  /// Serializes this UpdateProfileRequestDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateProfileRequestDto &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullName, phone, dob, address);

  @override
  String toString() {
    return 'UpdateProfileRequestDto(fullName: $fullName, phone: $phone, dob: $dob, address: $address)';
  }
}

/// @nodoc
abstract mixin class $UpdateProfileRequestDtoCopyWith<$Res> {
  factory $UpdateProfileRequestDtoCopyWith(UpdateProfileRequestDto value,
          $Res Function(UpdateProfileRequestDto) _then) =
      _$UpdateProfileRequestDtoCopyWithImpl;
  @useResult
  $Res call({String? fullName, String? phone, String? dob, String? address});
}

/// @nodoc
class _$UpdateProfileRequestDtoCopyWithImpl<$Res>
    implements $UpdateProfileRequestDtoCopyWith<$Res> {
  _$UpdateProfileRequestDtoCopyWithImpl(this._self, this._then);

  final UpdateProfileRequestDto _self;
  final $Res Function(UpdateProfileRequestDto) _then;

  /// Create a copy of UpdateProfileRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = freezed,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? address = freezed,
  }) {
    return _then(_self.copyWith(
      fullName: freezed == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _self.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UpdateProfileRequestDto].
extension UpdateProfileRequestDtoPatterns on UpdateProfileRequestDto {
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
    TResult Function(_UpdateProfileRequestDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateProfileRequestDto() when $default != null:
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
    TResult Function(_UpdateProfileRequestDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateProfileRequestDto():
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
    TResult? Function(_UpdateProfileRequestDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateProfileRequestDto() when $default != null:
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
            String? fullName, String? phone, String? dob, String? address)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateProfileRequestDto() when $default != null:
        return $default(_that.fullName, _that.phone, _that.dob, _that.address);
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
            String? fullName, String? phone, String? dob, String? address)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateProfileRequestDto():
        return $default(_that.fullName, _that.phone, _that.dob, _that.address);
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
            String? fullName, String? phone, String? dob, String? address)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateProfileRequestDto() when $default != null:
        return $default(_that.fullName, _that.phone, _that.dob, _that.address);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UpdateProfileRequestDto implements UpdateProfileRequestDto {
  const _UpdateProfileRequestDto(
      {this.fullName, this.phone, this.dob, this.address});
  factory _UpdateProfileRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestDtoFromJson(json);

  @override
  final String? fullName;
  @override
  final String? phone;
  @override
  final String? dob;
  @override
  final String? address;

  /// Create a copy of UpdateProfileRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateProfileRequestDtoCopyWith<_UpdateProfileRequestDto> get copyWith =>
      __$UpdateProfileRequestDtoCopyWithImpl<_UpdateProfileRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateProfileRequestDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateProfileRequestDto &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullName, phone, dob, address);

  @override
  String toString() {
    return 'UpdateProfileRequestDto(fullName: $fullName, phone: $phone, dob: $dob, address: $address)';
  }
}

/// @nodoc
abstract mixin class _$UpdateProfileRequestDtoCopyWith<$Res>
    implements $UpdateProfileRequestDtoCopyWith<$Res> {
  factory _$UpdateProfileRequestDtoCopyWith(_UpdateProfileRequestDto value,
          $Res Function(_UpdateProfileRequestDto) _then) =
      __$UpdateProfileRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String? fullName, String? phone, String? dob, String? address});
}

/// @nodoc
class __$UpdateProfileRequestDtoCopyWithImpl<$Res>
    implements _$UpdateProfileRequestDtoCopyWith<$Res> {
  __$UpdateProfileRequestDtoCopyWithImpl(this._self, this._then);

  final _UpdateProfileRequestDto _self;
  final $Res Function(_UpdateProfileRequestDto) _then;

  /// Create a copy of UpdateProfileRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fullName = freezed,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? address = freezed,
  }) {
    return _then(_UpdateProfileRequestDto(
      fullName: freezed == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _self.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
