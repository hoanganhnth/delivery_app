import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../application/profile_view_state.dart';
import '../components/profile_preview_components.dart';

/// Private profile fields live on their own route so the account tab remains
/// safe to glance at in public.
class ProfilePersonalInformationView extends StatelessWidget {
  const ProfilePersonalInformationView({
    super.key,
    required this.data,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.previewMode = false,
    this.bottomNavigationBar,
    this.onBack,
    this.onCart,
  });

  final ProfileViewData data;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final bool previewMode;
  final Widget? bottomNavigationBar;
  final VoidCallback? onBack;
  final VoidCallback? onCart;

  @override
  Widget build(BuildContext context) {
    if (previewMode) {
      return Scaffold(
        backgroundColor: PreviewUi.canvas(context),
        appBar: ProfilePreviewHeader(
          title: 'Thông tin cá nhân',
          onBack: onBack ?? () => Navigator.of(context).maybePop(),
          onCart: onCart ?? () => Navigator.of(context).maybePop(),
        ),
        body: ProfilePersonalInformationPreviewBody(
          data: data,
          isLoading: isLoading,
          errorMessage: errorMessage,
          onRetry: onRetry,
        ),
        bottomNavigationBar: bottomNavigationBar,
      );
    }
    final strings = S.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final name = data.displayName?.trim().isNotEmpty == true
        ? data.displayName!
        : strings.profileTitle;

    return Scaffold(
      appBar: AppBar(title: Text(strings.profileEditProfile)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          if (isLoading) const LinearProgressIndicator(),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Column(
                children: [
                  Text(errorMessage!, style: TextStyle(color: scheme.error)),
                  TextButton(onPressed: onRetry, child: Text(strings.retry)),
                ],
              ),
            ),
          AppSurfaceCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              children: [
                _InformationRow(label: strings.fullName, value: name),
                const Divider(height: 24),
                _InformationRow(
                  label: strings.emailAddress,
                  value: data.email?.trim().isNotEmpty == true
                      ? data.email!
                      : '—',
                ),
                const Divider(height: 24),
                _InformationRow(
                  label: strings.addressPhone,
                  value: data.phone?.trim().isNotEmpty == true
                      ? data.phone!
                      : '—',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            strings.profileEditProfileDesc,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  const _InformationRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 4,
        child: Text(label, style: Theme.of(context).textTheme.bodySmall),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        flex: 6,
        child: Text(
          value,
          textAlign: TextAlign.end,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}
