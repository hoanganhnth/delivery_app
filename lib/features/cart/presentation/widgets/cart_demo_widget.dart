import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../providers/cart_providers.dart';

/// Demo widget to test cart functionality
class CartDemoWidget extends ConsumerWidget {
  const CartDemoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => cartNotifier.clearCart(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Cart summary
          Container(
            padding: EdgeInsets.all(16.w),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Items: ${cartState.cart.totalItems}'),
                Text('Total: \$${cartState.cart.totalAmount.toStringAsFixed(2)}'),
              ],
            ),
          ),

          // Add sample items buttons
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final sampleItem = CartItemEntity(
                      menuItemId: 1,
                      menuItemName: 'Pizza Margherita',
                      price: 12.99,
                      quantity: 1,
                      restaurantId: 1,
                      restaurantName: 'Pizza Palace',
                    );
                    cartNotifier.addItem(sampleItem);
                  },
                  child: const Text('Add Pizza'),
                ),
                SizedBox(height: 8.w),
                ElevatedButton(
                  onPressed: () {
                    final sampleItem = CartItemEntity(
                      menuItemId: 2,
                      menuItemName: 'Burger',
                      price: 8.99,
                      quantity: 1,
                      restaurantId: 1,
                      restaurantName: 'Pizza Palace',
                    );
                    cartNotifier.addItem(sampleItem);
                  },
                  child: const Text('Add Burger'),
                ),
              ],
            ),
          ),

          // Cart items list
          Expanded(
            child: ListView.builder(
              itemCount: cartState.cart.items.length,
              itemBuilder: (context, index) {
                final item = cartState.cart.items[index];
                return ListTile(
                  title: Text(item.menuItemName),
                  subtitle: Text('Qty: ${item.quantity} - \$${item.totalPrice.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => cartNotifier.updateItemQuantity(item.menuItemId, item.quantity - 1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => cartNotifier.updateItemQuantity(item.menuItemId, item.quantity + 1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => cartNotifier.removeItem(item.menuItemId),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Loading indicator
          if (cartState.isLoading)
            const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
