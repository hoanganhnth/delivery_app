import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/cart/presentation/providers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/theme/theme_provider.dart' hide Theme;
import '../../../../generated/l10n.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/empty_cart_widget.dart';

/// Main cart screen showing cart items and checkout
class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final themeColors = ref.watch(themeColorsProvider);
    final textTheme = Theme.of(context).textTheme;

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
      backgroundColor: themeColors.surface,
      body: Builder(
        builder: (context) {
          if (cartState.isLoading && cartState.cart.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (cartState.failure != null && cartState.cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cartState.failure?.message ?? 'Đã xảy ra lỗi',
                    style: textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => cartNotifier.loadCart(),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          final cart = cartState.cart;

          if (cart.items.isEmpty) {
            return const EmptyCartWidget();
          }

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Restaurant info
                  if (cartState.cart.currentRestaurantName != null)
                    SliverToBoxAdapter(
                      child: Container(
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
                    ),

                  // Cart items list
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = cart.items[index];
                        return CartItemWidget(
                          cartItem: item,
                        );
                      },
                      childCount: cart.items.length,
                    ),
                  ),
                ],
              ),
              if (cartState.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.1),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        }
      ),
    );
  }

  Future<void> _showClearCartDialog(BuildContext context, CartNotifier cartNotifier) async {
    await showDialog(
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
}
