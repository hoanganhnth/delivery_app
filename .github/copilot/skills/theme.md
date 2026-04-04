# Skill: Theme System

> Use when: Styling widgets, colors, typography, dimensions

## Access Colors

```dart
// In Widget (BuildContext)
Container(
  color: context.colors.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: context.colors.textPrimary),
  ),
)

// In ConsumerWidget (WidgetRef)
Consumer(builder: (context, ref, child) {
  return Container(color: ref.colors.surface);
})
```

## Available Colors

```dart
context.colors.primary        // Primary amber (#F49D25)
context.colors.secondary      // Secondary umber
context.colors.background     // Background color
context.colors.surface        // Surface/card color
context.colors.textPrimary    // Primary text
context.colors.textSecondary  // Secondary text
context.colors.error          // Error red
context.colors.success        // Success green
context.colors.warning        // Warning orange
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
if (context.isDarkTheme) {
  // Dark mode specific
}

if (context.isLightTheme) {
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
