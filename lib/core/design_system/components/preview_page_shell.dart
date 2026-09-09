import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';

/// Shared visual tokens for the customer phone preview.
///
/// The preview intentionally uses a light gray canvas, white content sections,
/// compact 4px controls and ShopeeFood orange as the action color. The colors
/// still resolve through the active theme so the existing dark-mode preview
/// remains usable.
abstract final class PreviewUi {
  static const accent = Color(0xFFEE4D2D);
  static const line = Color(0xFFEEEEEE);
  static const lightMuted = Color(0xFF888888);
  static String get fontFamily =>
      defaultTargetPlatform == TargetPlatform.iOS
      ? 'Arial'
      : 'Plus Jakarta Sans';

  static List<String> get fontFamilyFallback =>
      defaultTargetPlatform == TargetPlatform.iOS
      ? const ['Helvetica Neue', 'Plus Jakarta Sans', 'sans-serif']
      : const ['Arial', 'sans-serif'];

  static Color canvas(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? const Color(0xFF171717)
        : const Color(0xFFF5F5F5);
  }

  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color text(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color muted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFFB0B0B0)
      : lightMuted;

  static Color divider(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF3B3B3B)
      : line;

  static Color accentSurface(BuildContext context, {double alpha = .06}) =>
      accent.withValues(alpha: alpha);

  static BorderRadius get controlRadius =>
      const BorderRadius.all(Radius.circular(4));

  static ThemeData theme(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      textTheme: base.textTheme.apply(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
      ),
    );
  }
}

/// Applies the typography used by the customer phone preview without
/// changing the app's native design-system font outside preview surfaces.
class PreviewTypography extends StatelessWidget {
  const PreviewTypography({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Theme(data: PreviewUi.theme(context), child: child);
}

/// Compact 50px header matching the phone preview's secondary screens.
class PreviewPageHeader extends StatelessWidget implements PreferredSizeWidget {
  const PreviewPageHeader({
    super.key,
    required this.title,
    this.onBack,
    this.leadingKey,
    this.onCart,
    this.cartItemCount = 0,
    this.actions = const <Widget>[],
    this.toolbarHeight = 50,
  });

  final String title;
  final VoidCallback? onBack;
  final Key? leadingKey;
  final VoidCallback? onCart;
  final int cartItemCount;
  final List<Widget> actions;
  final double toolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final hasTrailing = onCart != null || actions.isNotEmpty;
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: PreviewUi.surface(context),
      foregroundColor: PreviewUi.text(context),
      leadingWidth: 44,
      leading: onBack == null
          ? const SizedBox(width: 44)
          : IconButton(
              key: leadingKey,
              tooltip: 'Quay lại',
              onPressed: onBack,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back, color: PreviewUi.accent),
            ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: PreviewUi.text(context),
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        if (onCart != null)
          _PreviewCartAction(onPressed: onCart!, itemCount: cartItemCount),
        ...actions,
        if (!hasTrailing) const SizedBox(width: 44),
      ],
    );
  }
}

class _PreviewCartAction extends StatelessWidget {
  const _PreviewCartAction({required this.onPressed, required this.itemCount});

  final VoidCallback onPressed;
  final int itemCount;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 44,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        IconButton(
          tooltip: 'Giỏ hàng',
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.shopping_bag_outlined, size: 22),
        ),
        if (itemCount > 0)
          Positioned(
            right: 1,
            top: 4,
            child: Container(
              constraints: const BoxConstraints(minWidth: 15),
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: PreviewUi.accent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                itemCount > 99 ? '99+' : '$itemCount',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

/// A flat white section separated from the gray preview canvas by 8px.
class PreviewSurface extends StatelessWidget {
  const PreviewSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 8),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) => Container(
    margin: margin,
    padding: padding,
    color: PreviewUi.surface(context),
    child: child,
  );
}

/// Empty/error content with the same density as the preview's catalog state.
class PreviewEmptyState extends StatelessWidget {
  const PreviewEmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.receipt_long_outlined,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 56, 24, 56),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 52, color: const Color(0xFFD8C8C0)),
        const SizedBox(height: 18),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: PreviewUi.text(context),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 10),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: TextStyle(color: PreviewUi.muted(context), fontSize: 12),
          ),
        ],
        if (actionLabel != null && onAction != null) ...[
          const SizedBox(height: 22),
          SizedBox(
            width: 220,
            height: 44,
            child: FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                backgroundColor: PreviewUi.accent,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
              ),
              child: Text(actionLabel!),
            ),
          ),
        ],
      ],
    ),
  );
}
