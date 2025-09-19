import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_providers.dart';

/// Demo widget to test cart functionality during development
class CartTestWidget extends ConsumerWidget {
  const CartTestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final itemsCount = ref.watch(cartItemsCountProvider);
    final totalAmount = ref.watch(cartTotalAmountProvider);

    return Card(
      margin: EdgeInsets.all(16.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart Status (Development)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.w),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Items: $itemsCount'),
                      Text('Total: ${totalAmount.toStringAsFixed(0)}đ'),
                      Text('Restaurant: ${cartState.currentRestaurantName ?? 'None'}'),
                      if (cartState.isLoading) const Text('Loading...'),
                      if (cartState.hasError) 
                        Text(
                          'Error: ${cartState.failure?.message}',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: cartState.isEmpty ? null : () => cartNotifier.clearCart(),
                      child: const Text('Clear Cart'),
                    ),
                    SizedBox(height: 8.w),
                    ElevatedButton(
                      onPressed: () => cartNotifier.loadCart(),
                      child: const Text('Reload'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.w),
            if (cartState.cart.items.isNotEmpty) ...[
              const Text('Items in cart:', style: TextStyle(fontWeight: FontWeight.w500)),
              ...cartState.cart.items.map((item) => Padding(
                padding: EdgeInsets.only(left: 16.w, top: 4.w),
                child: Text(
                  '${item.quantity}x ${item.menuItemName} - ${(item.price * item.quantity).toStringAsFixed(0)}đ',
                  style: TextStyle(fontSize: 12.sp),
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}
