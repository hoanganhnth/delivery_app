// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Theme provider to manage app theme state

@ProviderFor(Theme)
final themeProvider = ThemeProvider._();

/// Theme provider to manage app theme state
final class ThemeProvider extends $NotifierProvider<Theme, AppTheme> {
  /// Theme provider to manage app theme state
  ThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeHash();

  @$internal
  @override
  Theme create() => Theme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppTheme value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppTheme>(value),
    );
  }
}

String _$themeHash() => r'63ca0e9c250d589a3efe900a18d8b69269cfa881';

/// Theme provider to manage app theme state

abstract class _$Theme extends $Notifier<AppTheme> {
  AppTheme build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppTheme, AppTheme>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppTheme, AppTheme>,
              AppTheme,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Convenience providers for accessing theme data

@ProviderFor(themeColors)
final themeColorsProvider = ThemeColorsProvider._();

/// Convenience providers for accessing theme data

final class ThemeColorsProvider
    extends $FunctionalProvider<AppColors, AppColors, AppColors>
    with $Provider<AppColors> {
  /// Convenience providers for accessing theme data
  ThemeColorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeColorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeColorsHash();

  @$internal
  @override
  $ProviderElement<AppColors> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppColors create(Ref ref) {
    return themeColors(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppColors value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppColors>(value),
    );
  }
}

String _$themeColorsHash() => r'0aff7d795b15abad11b211130dc699546acdd583';

@ProviderFor(themeType)
final themeTypeProvider = ThemeTypeProvider._();

final class ThemeTypeProvider
    extends $FunctionalProvider<AppThemeType, AppThemeType, AppThemeType>
    with $Provider<AppThemeType> {
  ThemeTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeTypeHash();

  @$internal
  @override
  $ProviderElement<AppThemeType> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppThemeType create(Ref ref) {
    return themeType(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppThemeType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppThemeType>(value),
    );
  }
}

String _$themeTypeHash() => r'b9826f03ae18d28dcb61fd9c59966c6818d7c6c5';

@ProviderFor(isDarkTheme)
final isDarkThemeProvider = IsDarkThemeProvider._();

final class IsDarkThemeProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsDarkThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isDarkThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isDarkThemeHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isDarkTheme(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isDarkThemeHash() => r'326f2b458899e8a954eb66e910eb9f858a33d73e';

@ProviderFor(isLightTheme)
final isLightThemeProvider = IsLightThemeProvider._();

final class IsLightThemeProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsLightThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLightThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLightThemeHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLightTheme(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLightThemeHash() => r'57dca1cf088d73b84238e83a21d34c33ba01efc7';
