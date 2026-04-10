import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';
import '../providers/providers.dart';

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
    final cartAsyncValue = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartTotalAmountProvider);
    final totalItems = ref.watch(cartItemsCountProvider);

    return cartAsyncValue.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (cart) {
        if (cart.items.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ref.colors.surface,
            border: Border(
              top: BorderSide(color: ref.colors.divider, width: 1.w),
            ),
            boxShadow: [
              BoxShadow(
                color: ref.colors.shadow.withValues(alpha: 0.1),
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
                  color: ref.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      showOrderSummary ? S.of(context).hideOrderDetails : S.of(context).showOrderDetails,
                      style: TextStyle(
                        color: ref.colors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      showOrderSummary ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: ref.colors.primary,
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
                    color: ref.colors.textPrimary,
                  ),
                ),
                Text(
                  S.of(context).items(totalItems),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ref.colors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),

            // Pricing Details
            _buildPriceRow(
              context,
              ref,
              S.of(context).subtotal,
              '\$${totalPrice.toStringAsFixed(2)}',
              isSubtotal: true,
            ),
            SizedBox(height: 8.w),
            _buildPriceRow(context, ref, S.of(context).deliveryFee, '\$3.99'),
            SizedBox(height: 8.w),
            _buildPriceRow(context, ref, S.of(context).serviceFee, '\$2.50'),
            SizedBox(height: 8.w),
            _buildPriceRow(
              context,
              ref,
              S.of(context).tax,
              '\$${(totalPrice * 0.08).toStringAsFixed(2)}',
            ),

            SizedBox(height: 12.w),
            Divider(color: ref.colors.divider),
            SizedBox(height: 12.w),
          ],

          // Total (luôn hiển thị)
          _buildPriceRow(
            context,
            ref,
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
                onPressed: onCheckoutPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ref.colors.primary,
                  foregroundColor: ref.colors.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 16.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  S.of(context).proceedToCheckout,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
      },
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    WidgetRef ref,
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
                ? ref.colors.textPrimary
                : ref.colors.textSecondary,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal
                ? ref.colors.primary
                : (isSubtotal
                      ? ref.colors.textPrimary
                      : ref.colors.textSecondary),
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
          color: ref.colors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ref.colors.primary.withValues(alpha: 0.3),
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
                    color: ref.colors.onPrimary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$totalItems',
                    style: TextStyle(
                      color: ref.colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'View Cart',
                  style: TextStyle(
                    color: ref.colors.onPrimary,
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
                    color: ref.colors.onPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ref.colors.onPrimary,
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
