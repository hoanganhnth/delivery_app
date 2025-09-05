import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Theme',
              style: AppTextStyles.h5.copyWith(color: colors.onSurface),
            ),
            SizedBox(height: AppSpacing.md),
            
            // Theme options
            ...AppTheme.availableThemes.entries.map((entry) {
              final themeName = entry.key;
              final themeData = entry.value;
              final isSelected = currentTheme.name == themeName;

              return Card(
                elevation: isSelected ? 4 : 1,
                margin: EdgeInsets.only(bottom: AppSpacing.md),
                child: InkWell(
                  onTap: () {
                    ref.read(themeProvider.notifier).setTheme(themeData.type);
                  },
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        // Theme preview
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                            border: Border.all(
                              color: themeData.colors.outline,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: themeData.colors.primary,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(AppRadius.sm - 2),
                                      bottomLeft: Radius.circular(AppRadius.sm - 2),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: themeData.colors.secondary,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(AppRadius.sm - 2),
                                      bottomRight: Radius.circular(AppRadius.sm - 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: AppSpacing.md),
                        
                        // Theme info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getThemeDisplayName(themeName),
                                style: AppTextStyles.bodyLarge.copyWith(
                                  color: colors.onSurface,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: AppSpacing.xs),
                              Text(
                                _getThemeDescription(themeName),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Selection indicator
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: colors.primary,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            
            SizedBox(height: AppSpacing.xl),
            
            // Quick toggle button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
                icon: Icon(
                  currentTheme.colors.brightness == Brightness.dark 
                      ? Icons.light_mode 
                      : Icons.dark_mode,
                ),
                label: Text(
                  currentTheme.colors.brightness == Brightness.dark 
                      ? 'Switch to Light Theme' 
                      : 'Switch to Dark Theme',
                ),
              ),
            ),
            
            SizedBox(height: AppSpacing.lg),
            
            // Theme preview section
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme Preview',
                      style: AppTextStyles.h6.copyWith(color: colors.onSurface),
                    ),
                    SizedBox(height: AppSpacing.md),
                    
                    // Color swatches
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _ColorSwatch(label: 'Primary', color: colors.primary),
                        _ColorSwatch(label: 'Secondary', color: colors.secondary),
                        _ColorSwatch(label: 'Surface', color: colors.surface),
                        _ColorSwatch(label: 'Error', color: colors.error),
                      ],
                    ),
                    
                    SizedBox(height: AppSpacing.md),
                    
                    // Sample UI elements
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Primary Button'),
                          ),
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Outlined Button'),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppSpacing.sm),
                    
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Sample Input',
                        hintText: 'Enter text here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeDisplayName(String themeName) {
    switch (themeName) {
      case 'light':
        return 'Light Theme';
      case 'dark':
        return 'Dark Theme';
      case 'ocean':
        return 'Ocean Theme';
      default:
        return themeName.replaceAll('_', ' ').split(' ').map((word) => 
          word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase()
        ).join(' ');
    }
  }

  String _getThemeDescription(String themeName) {
    switch (themeName) {
      case 'light':
        return 'Clean and bright interface';
      case 'dark':
        return 'Easy on the eyes in low light';
      case 'ocean':
        return 'Calm and refreshing blue tones';
      default:
        return 'Custom theme variation';
    }
  }
}

class _ColorSwatch extends StatelessWidget {
  final String label;
  final Color color;

  const _ColorSwatch({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(
              color: context.colors.outline,
              width: 1,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
