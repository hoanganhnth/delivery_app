import 'package:flutter/material.dart';

import '../foundations/app_spacing.dart';
import 'app_button.dart';

enum AppFeedbackKind { loading, empty, error }

class AppStateFeedback extends StatelessWidget {
  const AppStateFeedback.loading({super.key, required this.title, this.message})
    : kind = AppFeedbackKind.loading,
      icon = null,
      actionLabel = null,
      onAction = null;

  const AppStateFeedback.empty({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  }) : kind = AppFeedbackKind.empty;

  const AppStateFeedback.error({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.error_outline,
    this.actionLabel,
    this.onAction,
  }) : kind = AppFeedbackKind.error;

  final AppFeedbackKind kind;
  final String title;
  final String? message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      container: true,
      liveRegion: kind != AppFeedbackKind.empty,
      label: [title, if (message != null) message!].join('. '),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (kind == AppFeedbackKind.loading)
                const CircularProgressIndicator()
              else
                Icon(
                  icon,
                  size: 56,
                  color: kind == AppFeedbackKind.error
                      ? scheme.error
                      : scheme.primary,
                ),
              const SizedBox(height: AppSpacing.md),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: actionLabel!,
                  onPressed: onAction,
                  variant: AppButtonVariant.secondary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
