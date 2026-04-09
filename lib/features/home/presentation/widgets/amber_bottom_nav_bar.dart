import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

/// Amber Hearth style floating dark bottom navigation bar
/// 
/// This is a reusable bottom navigation component that follows the Stitch design:
/// - Floating dark pill (stone-900) with rounded-full
/// - Active state: Elevated orange pill with -translate-y effect
/// - Inactive state: Gray icons with hover effects
/// - Smooth transitions with scale animations
class AmberBottomNavBar extends ConsumerWidget {
  /// Current selected index (0-based)
  final int currentIndex;
  
  /// Callback when a navigation item is tapped
  final ValueChanged<int> onTap;

  const AmberBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 24,
        top: 0,
      ),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: const Color(0xFF292524), // stone-900
          borderRadius: BorderRadius.circular(9999), // rounded-full
          boxShadow: [
            BoxShadow(
              color: ref.colors.primary.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home,
              label: 'Home',
              isActive: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: Icons.shopping_cart_outlined,
              label: 'Cart',
              isActive: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            _NavItem(
              icon: Icons.receipt_long_outlined,
              label: 'Orders',
              isActive: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isActive: currentIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual navigation item with active/inactive states
class _NavItem extends ConsumerWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(0.0, isActive ? -8.0 : 0.0), // -translate-y-2 effect
        child: Container(
          width: isActive ? 72 : 56,
          height: isActive ? 72 : 56,
          decoration: BoxDecoration(
            color: isActive 
                ? ref.colors.primary // primary
                : Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: ref.colors.primary.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: isActive 
                    ? Colors.white 
                    : const Color(0xFF9CA3AF), // stone-400
              ),
              SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: isActive 
                      ? Colors.white 
                      : const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
