# Skill: Theme System

> Use when: Styling widgets, colors, typography, dimensions

## Access Colors

```dart
// In ConsumerWidget / ConsumerStatefulWidget
Widget build(BuildContext context, WidgetRef ref) {
  return Container(
    color: ref.colors.primary,
    child: Text(
      'Hello',
      style: TextStyle(color: ref.colors.textPrimary),
    ),
  );
}
```

## Available Colors

```dart
ref.colors.primary        // Primary amber (#F49D25)
ref.colors.secondary      // Secondary umber
ref.colors.background     // Background color
ref.colors.surface        // Surface/card color
ref.colors.textPrimary    // Primary text
ref.colors.textSecondary  // Secondary text
ref.colors.error          // Error red
ref.colors.success        // Success green
ref.colors.warning        // Warning orange
```

## Typography

```dart
Text('Title', style: context.textStyles.headlineLarge)
Text('Body', style: context.textStyles.bodyMedium)
Text('Caption', style: context.textStyles.labelSmall)
```

## Dimensions

```dart
padding: EdgeInsets.all(AppDimensions.paddingSmall)     // 8
padding: EdgeInsets.all(AppDimensions.paddingMedium)    // 16
padding: EdgeInsets.all(AppDimensions.paddingLarge)     // 24

borderRadius: BorderRadius.circular(AppDimensions.radiusSmall)   // 4
borderRadius: BorderRadius.circular(AppDimensions.radiusMedium)  // 8
borderRadius: BorderRadius.circular(AppDimensions.radiusLarge)   // 16
```

## Theme Detection

```dart
if (ref.isDarkTheme) {
  // Dark mode specific
}

if (ref.isLightTheme) {
  // Light mode specific
}
```

## Theme Switching

```dart
// Watch current theme
final theme = ref.watch(themeNotifierProvider);

// Change theme
ref.read(themeNotifierProvider.notifier).setTheme(AppThemeType.dark);

// Toggle
ref.read(themeNotifierProvider.notifier).toggleTheme();
```

## Key Import

```dart
import 'package:delivery_app/core/theme/theme_extensions.dart';
```
