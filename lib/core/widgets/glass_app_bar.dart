import 'dart:ui';
import 'package:flutter/material.dart';

/// Amber Hearth style glass morphism app bar
/// 
/// Features:
/// - Sticky glass effect with backdrop blur
/// - White/90 background
/// - Subtle shadow
/// - Height: 64px with px-6 py-4 padding
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Leading widget (usually back button or logo)
  final Widget? leading;
  
  /// Title widget
  final Widget? title;
  
  /// Title text (alternative to title widget)
  final String? titleText;
  
  /// Actions widgets
  final List<Widget>? actions;
  
  /// Whether to center the title
  final bool centerTitle;
  
  /// Background color (default: white/90)
  final Color? backgroundColor;

  const GlassAppBar({
    super.key,
    this.leading,
    this.title,
    this.titleText,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white.withValues(alpha: 0.9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Row(
                children: [
                  // Leading
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 16),
                  ],
                  
                  // Title
                  if (centerTitle) const Spacer(),
                  Expanded(
                    flex: centerTitle ? 0 : 1,
                    child: title ??
                        (titleText != null
                            ? Text(
                                titleText!,
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                  color: Color(0xFF1C160D), // on-surface
                                ),
                              )
                            : const SizedBox.shrink()),
                  ),
                  if (centerTitle) const Spacer(),
                  
                  // Actions
                  if (actions != null) ...[
                    const SizedBox(width: 16),
                    ...actions!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

/// Glass back button for use in app bars
class GlassBackButton extends StatelessWidget {
  /// Callback when button is tapped
  final VoidCallback? onPressed;

  const GlassBackButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back,
          size: 20,
          color: Color(0xFF1C160D), // on-surface
        ),
      ),
    );
  }
}

/// Glass action button for use in app bars
class GlassActionButton extends StatelessWidget {
  /// Icon to display
  final IconData icon;
  
  /// Callback when button is tapped
  final VoidCallback? onPressed;
  
  /// Icon color (default: on-surface)
  final Color? iconColor;

  const GlassActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: iconColor ?? const Color(0xFF1C160D), // on-surface
        ),
      ),
    );
  }
}
