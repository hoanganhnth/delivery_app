import 'package:delivery_app/core/routing/routing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/cart/presentation/providers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';
import '../providers/cart_providers.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/cart_summary_widget.dart';
import '../widgets/empty_cart_widget.dart';

/// Main cart screen showing cart items and checkout
class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool _showOrderSummary = true;

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).shoppingCart),
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
        actions: [
          if (cartState.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _showClearCartDialog(context, cartNotifier),
              tooltip: S.of(context).clearCart,
            ),
        ],
      ),
      body: cartState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartState.isEmpty
              ? const EmptyCartWidget()
              : Column(
                  children: [
                    // Restaurant info
                    if (cartState.cart.currentRestaurantName != null)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        color: context.colors.surface,
                        child: Row(
                          children: [
                            Icon(
                              Icons.restaurant,
                              color: context.colors.primary,
                              size: 20,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              S.of(context).itemsFrom(cartState.cart.currentRestaurantName ?? ''),
                              style: TextStyle(
                                color: context.colors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Cart items list
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(16.w),
                        itemCount: cartState.cart.items.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = cartState.cart.items[index];
                          return CartItemWidget(
                            cartItem: item,
                            onQuantityChanged: () {},
                          );
                        },
                      ),
                    ),

                    // Cart summary and checkout
                    CartSummaryWidget(
                      onCheckoutPressed: () => _navigateToCheckout(context),
                      showOrderSummary: _showOrderSummary,
                      onToggleOrderSummary: () => setState(() => _showOrderSummary = !_showOrderSummary),
                    ),
                  ],
                ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartNotifier cartNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).clearCartTitle),
        content: Text(S.of(context).clearCartMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              cartNotifier.clearCart();
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).clear),
          ),
        ],
      ),
    );
  }

  void _navigateToCheckout(BuildContext context) {
    // Navigate to checkout screen
    context.pushCheckout();
  }
}
