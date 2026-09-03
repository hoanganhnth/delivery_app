import 'package:flutter/material.dart';

import '../foundations/app_dimensions.dart' show AppSizes;
import '../foundations/app_spacing.dart';
import 'app_button.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.onBack,
    this.leadingKey,
    this.backTooltip,
    this.close = false,
    this.actions = const [],
  });

  final String title;
  final VoidCallback? onBack;
  final Key? leadingKey;
  final String? backTooltip;
  final bool close;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    leading: onBack == null
        ? null
        : AppIconButton(
            key: leadingKey,
            tooltip:
                backTooltip ??
                (close
                    ? MaterialLocalizations.of(context).closeButtonTooltip
                    : MaterialLocalizations.of(context).backButtonTooltip),
            icon: close ? Icons.close : Icons.arrow_back,
            onPressed: onBack,
          ),
    title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
    actions: actions,
  );
}

class AppStickyAction extends StatelessWidget {
  const AppStickyAction({
    super.key,
    required this.child,
    this.summary,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.page,
      AppSpacing.sm,
      AppSpacing.page,
      AppSpacing.md,
    ),
  });

  final Widget child;
  final Widget? summary;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      elevation: 3,
      child: SafeArea(
        top: false,
        minimum: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (summary != null) ...[
              summary!,
              const SizedBox(height: AppSpacing.sm),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
