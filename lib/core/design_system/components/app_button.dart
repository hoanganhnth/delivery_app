import 'package:flutter/material.dart';

import '../foundations/app_dimensions.dart' show AppSizes;
import '../foundations/app_radii.dart';
import '../foundations/app_spacing.dart';

enum AppButtonVariant { primary, secondary, quiet }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.semanticLabel,
    this.icon,
    this.isLoading = false,
    this.variant = AppButtonVariant.primary,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final IconData? icon;
  final bool isLoading;
  final AppButtonVariant variant;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final content = AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: isLoading
          ? const SizedBox.square(
              key: ValueKey('loading'),
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              key: const ValueKey('label'),
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: AppSpacing.xs),
                ],
                Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
              ],
            ),
    );
    final button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: enabled ? onPressed : null,
        style: _style(context),
        child: content,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: _style(context),
        child: content,
      ),
      AppButtonVariant.quiet => TextButton(
        onPressed: enabled ? onPressed : null,
        style: _style(context),
        child: content,
      ),
    };

    return Semantics(
      container: true,
      button: true,
      enabled: enabled,
      label: semanticLabel ?? label,
      child: ExcludeSemantics(
        child: SizedBox(width: expand ? double.infinity : null, child: button),
      ),
    );
  }

  ButtonStyle _style(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(
        Size(0, AppSizes.buttonHeightLg),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppRadii.control),
      ),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return scheme.onPrimary.withValues(alpha: 0.18);
        }
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          return scheme.onPrimary.withValues(alpha: 0.1);
        }
        return null;
      }),
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.isSelected = false,
    this.hasBackground = false,
    this.backgroundColor,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSelected;
  final bool hasBackground;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onPressed != null && !isLoading;
    return Semantics(
      container: true,
      button: true,
      enabled: enabled,
      selected: isSelected,
      label: tooltip,
      child: ExcludeSemantics(
        child: SizedBox.square(
          dimension: 48,
          child: IconButton(
            tooltip: tooltip,
            onPressed: enabled ? onPressed : null,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (isSelected) return scheme.primaryContainer;
                if (states.contains(WidgetState.pressed)) {
                  return hasBackground || backgroundColor != null
                      ? scheme.primaryContainer.withValues(alpha: 0.7)
                      : scheme.primary.withValues(alpha: 0.12);
                }
                if (backgroundColor != null) return backgroundColor;
                if (hasBackground) {
                  return scheme.surfaceContainerHighest.withValues(alpha: 0.7);
                }
                return Colors.transparent;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return scheme.onSurface.withValues(alpha: 0.38);
                }
                return isSelected ? scheme.primary : scheme.onSurface;
              }),
              shape: WidgetStatePropertyAll(
                hasBackground || backgroundColor != null
                    ? const RoundedRectangleBorder(borderRadius: AppRadii.control)
                    : const CircleBorder(),
              ),
            ),
            icon: isLoading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(icon, size: 22),
          ),
        ),
      ),
    );
  }
}
