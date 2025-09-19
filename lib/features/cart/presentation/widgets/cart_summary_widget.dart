import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';
import '../providers/cart_providers.dart';

/// Widget displaying cart totals and checkout button
class CartSummaryWidget extends ConsumerWidget {
  final VoidCallback? onCheckoutPressed;
  final bool showCheckoutButton;
  final bool showOrderSummary;
  final VoidCallback? onToggleOrderSummary;

  const CartSummaryWidget({
    super.key,
    this.onCheckoutPressed,
    this.showCheckoutButton = true,
    this.showOrderSummary = true,
    this.onToggleOrderSummary,
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(color: context.colors.divider, width: 1.w),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Toggle Button for Order Summary
          if (onToggleOrderSummary != null)
            InkWell(
              onTap: onToggleOrderSummary,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      showOrderSummary ? S.of(context).hideOrderDetails : S.of(context).showOrderDetails,
                      style: TextStyle(
                        color: context.colors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      showOrderSummary ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: context.colors.primary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

          if (onToggleOrderSummary != null) SizedBox(height: 16.w),

          // Order Summary Header (chỉ hiện khi showOrderSummary = true)
          if (showOrderSummary) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).orderSummary,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  S.of(context).items(totalItems),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),

            // Pricing Details
            _buildPriceRow(
              context,
              S.of(context).subtotal,
              '\$${totalPrice.toStringAsFixed(2)}',
              isSubtotal: true,
            ),
            SizedBox(height: 8.w),
            _buildPriceRow(context, S.of(context).deliveryFee, '\$3.99'),
            SizedBox(height: 8.w),
            _buildPriceRow(context, S.of(context).serviceFee, '\$2.50'),
            SizedBox(height: 8.w),
            _buildPriceRow(
              context,
              S.of(context).tax,
              '\$${(totalPrice * 0.08).toStringAsFixed(2)}',
            ),

            SizedBox(height: 12.w),
            Divider(color: context.colors.divider),
            SizedBox(height: 12.w),
          ],

          // Total (luôn hiển thị)
          _buildPriceRow(
            context,
            S.of(context).total,
            '\$${(totalPrice + 3.99 + 2.50 + (totalPrice * 0.08)).toStringAsFixed(2)}',
            isTotal: true,
          ),

          if (showCheckoutButton) ...[
            SizedBox(height: 20.w),
            // Checkout Button (luôn hiển thị)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cartState.isLoading ? null : onCheckoutPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 16.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: cartState.isLoading
                    ? SizedBox(
                        height: 20.w,
                        width: 20.w,
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
                          SizedBox(width: 8.w),
                          Text(
                            S.of(context).proceedToCheckout,
                            style: TextStyle(
                              fontSize: 16.sp,
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
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal
                ? context.colors.textPrimary
                : context.colors.textSecondary,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal
                ? context.colors.primary
                : (isSubtotal
                      ? context.colors.textPrimary
                      : context.colors.textSecondary),
          ),
        ),
      ],
    );
  }
}

/// Compact cart summary widget for bottom sheets or small spaces
class CompactCartSummaryWidget extends ConsumerWidget {
  final VoidCallback? onTap;

  const CompactCartSummaryWidget({super.key, this.onTap});

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
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: context.colors.primary.withValues(alpha: 0.3),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.w,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.onPrimary.withValues(alpha: 0.2),
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
                SizedBox(width: 12.w),
                Text(
                  'View Cart',
                  style: TextStyle(
                    color: context.colors.onPrimary,
                    fontSize: 16.sp,
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
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8.w),
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
