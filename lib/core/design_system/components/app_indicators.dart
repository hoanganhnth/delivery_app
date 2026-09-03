import 'package:flutter/material.dart';

import '../foundations/app_radii.dart';
import '../foundations/app_spacing.dart';
import '../theme/app_semantic_colors.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.leading,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Widget? leading;

  @override
  Widget build(BuildContext context) => FilterChip(
    label: Text(label),
    selected: selected,
    onSelected: onSelected,
    avatar: leading,
    showCheckmark: false,
    shape: const StadiumBorder(),
    side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
    visualDensity: VisualDensity.compact,
  );
}

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.tone = AppBadgeTone.neutral,
  });

  final String label;
  final AppBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (background, foreground) = switch (tone) {
      AppBadgeTone.neutral => (
        scheme.surfaceContainerHighest,
        scheme.onSurfaceVariant,
      ),
      AppBadgeTone.accent => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      AppBadgeTone.success => (
        context.semanticColors.success.withValues(alpha: 0.14),
        context.semanticColors.success,
      ),
      AppBadgeTone.warning => (
        context.semanticColors.warning.withValues(alpha: 0.14),
        context.semanticColors.warning,
      ),
    };
    return Semantics(
      label: label,
      child: ExcludeSemantics(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: AppRadii.pillRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.xxs,
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum AppBadgeTone { neutral, accent, success, warning }
