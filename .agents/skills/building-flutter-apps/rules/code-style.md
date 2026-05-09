# Rules: Code Style

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| File | snake_case | `user_repository.dart` |
| Class | PascalCase | `UserRepository` |
| Variable | camelCase | `userName` |
| Constant | camelCase | `defaultTimeout` |
| Private | _prefix | `_apiService` |
| Provider | camelCase + Provider | `userRepositoryProvider` |

## File Organization

```
feature/
├── domain/
│   ├── entities/feature_entity.dart
│   ├── repositories/feature_repository.dart
│   └── usecases/get_feature_usecase.dart
├── data/
│   ├── dtos/feature_dto.dart
│   ├── datasources/
│   │   ├── feature_remote_datasource.dart
│   │   └── feature_remote_datasource_impl.dart
│   └── repositories_impl/feature_repository_impl.dart
└── presentation/
    ├── providers/
    │   ├── feature_state.dart
    │   ├── feature_notifier.dart
    │   ├── feature_providers.dart
    │   └── providers.dart (barrel)
    ├── screens/feature_screen.dart
    └── widgets/feature_widget.dart
```

## Import Order

```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter
import 'package:flutter/material.dart';

// 3. External packages
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 4. Project imports (absolute)
import 'package:delivery_app/core/theme/theme_extensions.dart';

// 5. Relative imports
import '../providers/providers.dart';

// 6. Part directives
part 'file.g.dart';
part 'file.freezed.dart';
```

## Localization

- Toàn bộ text hiển thị trên UI phải được khai báo trong `intl_en.arb` và `intl_vi.arb`.
- Naming keys: Dùng camelCase và prefix theo module (ví dụ: `authLoginButton`, `iapCurrentPlan`).
- Chạy `fvm dart run intl_utils:generate` sau khi thêm keys.

## State Classes (Freezed)

- Bắt buộc sử dụng `sealed class` thay vì `abstract class` cho các Freezed states và models để đảm bảo tính an toàn qua exhaustive pattern matching (bắt buộc phải handle tất cả các cases khi dùng `.when()` hoặc `.map()`).

## Comments

```dart
/// Documentation comment for public APIs
/// Use for classes, methods, fields
class UserRepository {
  /// Fetches user by ID
  /// Returns [UserEntity] on success
  Future<Either<Failure, UserEntity>> getById(String id);
}

// Single line comment for implementation details

/* Multi-line comment
   for temporary notes */

// TODO: Description of pending work
// FIXME: Description of known issue
```
