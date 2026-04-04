# Skill: Freezed (Code Generation)

> Use when: Creating DTOs, Entities, State classes

## Pattern: DTO (Data Transfer Object)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String name,
    String? email,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @Default(false) bool isActive,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

// Extension for mapping
extension UserDtoX on UserDto {
  UserEntity toEntity() => UserEntity(
    id: id,
    name: name,
    email: email,
    phoneNumber: phoneNumber,
  );
}
```

## Pattern: Entity (Domain Layer)

```dart
@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String name,
    String? email,
    String? phoneNumber,
  }) = _UserEntity;
}
```

## Pattern: State Class

```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isAuthenticated,
    UserEntity? user,
    Failure? failure,
  }) = _AuthState;
}

extension AuthStateX on AuthState {
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  bool get isLoggedIn => isAuthenticated && user != null;
}
```

## Pattern: Union Types (Sealed Class)

```dart
@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(String email, String password) = LoginEvent;
  const factory AuthEvent.logout() = LogoutEvent;
  const factory AuthEvent.refresh() = RefreshEvent;
}

// Usage with pattern matching
authEvent.when(
  login: (email, password) => /* handle */,
  logout: () => /* handle */,
  refresh: () => /* handle */,
);
```

## Annotations

```dart
@JsonKey(name: 'api_field')     // Map to API field name
@Default(value)                  // Default value
@JsonKey(ignore: true)          // Ignore in JSON
@JsonKey(fromJson: _parse)      // Custom parser
```

## Build Command

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```
