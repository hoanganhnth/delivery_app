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
    this.backgroundColor,
  });

  final String title;
  final VoidCallback? onBack;
  final Key? leadingKey;
  final String? backTooltip;
  final bool close;
  final List<Widget> actions;
  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
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

/// Navigation destination model for [AppBottomNavBar].
class AppNavItem {
  const AppNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.semanticLabel,
    this.badgeCount,
    this.key,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final String? semanticLabel;
  final int? badgeCount;
  final Key? key;
}

/// Token-driven bottom navigation bar for the customer shell.
///
/// Follows Design System tokens, WCAG AA touch targets (>=48dp),
/// full semantics, safe-area awareness, and theme switching.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.elevation = 8.0,
    this.topBorderColor,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppNavItem> items;
  final double elevation;
  final Color? topBorderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final borderColor =
        topBorderColor ?? scheme.outlineVariant.withValues(alpha: 0.2);

    return Material(
      color: scheme.surface,
      elevation: elevation,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                for (var i = 0; i < items.length; i++)
                  Expanded(
                    child: _AppBottomNavItemWidget(
                      item: items[i],
                      isSelected: i == currentIndex,
                      onTap: () => onTap(i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBottomNavItemWidget extends StatelessWidget {
  const _AppBottomNavItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final AppNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = isSelected ? scheme.primary : scheme.onSurfaceVariant;
    final iconData = (isSelected && item.activeIcon != null)
        ? item.activeIcon!
        : item.icon;

    final badgeCount = item.badgeCount;
    final hasBadge = badgeCount != null && badgeCount > 0;

    return Semantics(
      key: item.key,
      selected: isSelected,
      button: true,
      label: item.semanticLabel ?? item.label,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 28,
                width: 28,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      iconData,
                      size: 24,
                      color: color,
                    ),
                    if (hasBadge)
                      Positioned(
                        top: -4,
                        right: -8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.error,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            badgeCount > 99 ? '99+' : '$badgeCount',
                            style: TextStyle(
                              color: scheme.onError,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                item.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
