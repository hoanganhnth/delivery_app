import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/widgets/glass_app_bar.dart';
import 'package:delivery_app/features/cart/presentation/widgets/amber_cart_item_widget.dart';
import 'package:delivery_app/features/cart/presentation/widgets/restaurant_header_card.dart';
import 'package:delivery_app/features/cart/presentation/widgets/cart_order_summary.dart';
import 'package:delivery_app/features/cart/presentation/widgets/cart_checkout_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/cart/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';
import '../widgets/empty_cart_widget.dart';

/// Main cart screen showing cart items and checkout
/// Refactored with Amber Hearth design system
class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  // Amber Hearth design tokens  
  @override
  Widget build(BuildContext context) {
    final cartAsyncValue = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: ref.colors.background,
      appBar: GlassAppBar(
        titleText: S.of(context).shoppingCart,
        leading: GlassBackButton(
          onPressed: () => context.goBack(),
        ),
        actions: [
          cartAsyncValue.whenOrNull(
            data: (cart) => cart.isNotEmpty
                ? GlassActionButton(
                    icon: Icons.delete_outline,
                    onPressed: () => _showClearCartDialog(context, cartNotifier),
                  )
                : null,
          ) ?? const SizedBox.shrink(),
        ],
      ),
      body: cartAsyncValue.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: ref.colors.primary),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: const Color(0xFFBA1A1A),
                  size: 64.w,
                ),
                SizedBox(height: 16.w),
                Text(
                  error.toString(),
                  style: TextStyle(
                    color: const Color(0xFFBA1A1A),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.w),
                ElevatedButton(
                  onPressed: () => ref.invalidate(cartProvider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ref.colors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Thử lại'),
                ),
              ],
            ),
          ),
        ),
        data: (cart) {
          if (cart.items.isEmpty) {
            return const EmptyCartWidget();
          }

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Restaurant header card
                  if (cart.currentRestaurantName != null)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: RestaurantHeaderCard(
                          name: cart.currentRestaurantName ?? '',
                          logoUrl: null, // TODO: Get from cart
                          rating: 4.8,
                          distance: '1.2 km',
                          onTap: () {
                            // TODO: Navigate to restaurant
                          },
                        ),
                      ),
                    ),

                  // Cart items section header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 12.w),
                      child: Row(
                        children: [
                          Text(
                            'Đơn hàng của bạn',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: ref.colors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${cart.items.length} món',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: ref.colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Cart items list with Amber style
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = cart.items[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.w),
                            child: AmberCartItemWidget(
                              name: item.menuItemName,
                              imageUrl: item.imageUrl,
                              price: '${item.price.toStringAsFixed(0)}đ',
                              quantity: item.quantity,
                              subtitle: item.notes,
                              onIncrease: () => ref
                                  .read(cartProvider.notifier)
                                  .updateItemQuantity(item.menuItemId, item.quantity + 1),
                              onDecrease: () {
                                if (item.quantity > 1) {
                                  ref
                                      .read(cartProvider.notifier)
                                      .updateItemQuantity(item.menuItemId, item.quantity - 1);
                                } else {
                                  ref
                                      .read(cartProvider.notifier)
                                      .removeItem(item.menuItemId);
                                }
                              },
                            ),
                          );
                        },
                        childCount: cart.items.length,
                      ),
                    ),
                  ),

                  // Order summary section
                  SliverToBoxAdapter(
                    child: CartOrderSummary(
                      subtotal: cart.totalAmount,
                      deliveryFee: 15000.0,
                    ),
                  ),

                  // Bottom padding for checkout button
                  SliverToBoxAdapter(
                    child: SizedBox(height: 100.w),
                  ),
                ],
              ),

              // Floating checkout button
              Positioned(
                left: 16.w,
                right: 16.w,
                bottom: MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom
                    : 16.w,
                child: CartCheckoutButton(
                  totalAmount: cart.totalAmount + 15000.0,
                  onPressed: () => context.pushCheckout(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showClearCartDialog(BuildContext context, CartNotifier cartNotifier) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          S.of(context).clearCartTitle,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        content: Text(
          S.of(context).clearCartMessage,
          style: TextStyle(
            fontSize: 14.sp,
            color: ref.colors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(
                color: ref.colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              cartNotifier.clearCart();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBA1A1A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(S.of(context).clear),
          ),
        ],
      ),
    );
  }
}
