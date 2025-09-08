import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../providers/cart_providers.dart';

/// Widget displaying cart totals and checkout button
class CartSummaryWidget extends ConsumerWidget {
  final VoidCallback? onCheckoutPressed;
  final bool showCheckoutButton;

  const CartSummaryWidget({
    super.key,
    this.onCheckoutPressed,
    this.showCheckoutButton = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final totalPrice = ref.watch(cartTotalAmountProvider);
    final totalItems = ref.watch(cartItemsCountProvider);

    if (cartState.cart.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(
            color: context.colors.divider,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Order Summary Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: context.colors.textPrimary,
                ),
              ),
              Text(
                '$totalItems items',
                style: TextStyle(
                  fontSize: 14,
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Pricing Details
          _buildPriceRow(
            context,
            'Subtotal',
            '\$${totalPrice.toStringAsFixed(2)}',
            isSubtotal: true,
          ),
          const SizedBox(height: 8),
          _buildPriceRow(
            context,
            'Delivery Fee',
            '\$3.99',
          ),
          const SizedBox(height: 8),
          _buildPriceRow(
            context,
            'Service Fee',
            '\$2.50',
          ),
          const SizedBox(height: 8),
          _buildPriceRow(
            context,
            'Tax',
            '\$${(totalPrice * 0.08).toStringAsFixed(2)}',
          ),

          const SizedBox(height: 12),
          Divider(color: context.colors.divider),
          const SizedBox(height: 12),

          // Total
          _buildPriceRow(
            context,
            'Total',
            '\$${(totalPrice + 3.99 + 2.50 + (totalPrice * 0.08)).toStringAsFixed(2)}',
            isTotal: true,
          ),

          if (showCheckoutButton) ...[
            const SizedBox(height: 20),
            // Checkout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cartState.isLoading ? null : onCheckoutPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: cartState.isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.colors.onPrimary,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.shopping_bag_outlined),
                          const SizedBox(width: 8),
                          const Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    String label,
    String price, {
    bool isSubtotal = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal 
                ? context.colors.textPrimary 
                : context.colors.textSecondary,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal 
                ? context.colors.primary 
                : (isSubtotal ? context.colors.textPrimary : context.colors.textSecondary),
          ),
        ),
      ],
    );
  }
}

/// Compact cart summary widget for bottom sheets or small spaces
class CompactCartSummaryWidget extends ConsumerWidget {
  final VoidCallback? onTap;

  const CompactCartSummaryWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPrice = ref.watch(cartTotalAmountProvider);
    final totalItems = ref.watch(cartItemsCountProvider);

    if (totalItems == 0) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: context.colors.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.colors.onPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$totalItems',
                    style: TextStyle(
                      color: context.colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'View Cart',
                  style: TextStyle(
                    color: context.colors.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: context.colors.onPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: context.colors.onPrimary,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
