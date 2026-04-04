# Rules: Commands

## Development

| Action | Command |
|--------|---------|
| Run app | `fvm flutter run` |
| Run with flavor | `fvm flutter run --flavor dev` |
| Hot reload | `r` (in terminal) |
| Hot restart | `R` (in terminal) |

## Code Generation

| Action | Command |
|--------|---------|
| Build once | `fvm dart run build_runner build --delete-conflicting-outputs` |
| Watch mode | `fvm dart run build_runner watch --delete-conflicting-outputs` |
| Clean build | `fvm dart run build_runner clean` |

## Dependencies

| Action | Command |
|--------|---------|
| Get packages | `fvm flutter pub get` |
| Upgrade | `fvm flutter pub upgrade` |
| Outdated | `fvm flutter pub outdated` |

## Analysis

| Action | Command |
|--------|---------|
| Analyze all | `fvm flutter analyze` |
| Analyze path | `fvm flutter analyze lib/features/auth` |
| Format | `fvm dart format lib/` |
| Fix | `fvm dart fix --apply` |

## Testing

| Action | Command |
|--------|---------|
| All tests | `fvm flutter test` |
| Single file | `fvm flutter test test/path/file_test.dart` |
| Coverage | `fvm flutter test --coverage` |
| Watch | `fvm flutter test --watch` |

## Build

| Action | Command |
|--------|---------|
| APK | `fvm flutter build apk` |
| App Bundle | `fvm flutter build appbundle` |
| iOS | `fvm flutter build ios` |
| Web | `fvm flutter build web` |

## Clean

| Action | Command |
|--------|---------|
| Clean all | `fvm flutter clean` |
| Full reset | `fvm flutter clean && fvm flutter pub get && fvm dart run build_runner build --delete-conflicting-outputs` |

## Localization

| Action | Command |
|--------|---------|
| Generate | `fvm flutter pub run intl_utils:generate` |
