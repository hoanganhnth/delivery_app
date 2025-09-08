import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';

/// Widget displayed when cart is empty
class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 120,
              color: context.colors.textDisabled,
            ),
            const SizedBox(height: 24),
            Text(
              S.of(context).yourCartIsEmpty,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              S.of(context).addSomeDeliciousItems,
              style: TextStyle(
                fontSize: 16,
                color: context.colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/restaurants'),
              icon: const Icon(Icons.restaurant_menu),
              label: Text(S.of(context).browseRestaurants),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
