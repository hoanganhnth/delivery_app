import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../generated/l10n.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../cart/presentation/providers/cart_state.dart';

class MenuItemCard extends ConsumerWidget {
  final MenuItemEntity menuItem;
  final String restaurantName;

  const MenuItemCard({
    super.key, 
    required this.menuItem,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUnavailable = menuItem.status != MenuItemStatus.available;
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final itemQuantity = ref.watch(menuItemQuantityProvider(menuItem.id ?? 0));
    final canAddFromRestaurant = ref.watch(canAddFromRestaurantProvider(menuItem.restaurantId ?? 0));

    // Listen for cart state changes to show error messages
    ref.listen<CartState>(cartNotifierProvider, (previous, next) {
      if (next.hasError && next.failure != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure!.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    // Show error message when trying to add from different restaurant
    void showRestaurantConflictDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).cannotAddItem),
          content: Text(S.of(context).differentRestaurantError),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await cartNotifier.clearCart();
                // Add the item after clearing
                final cartItem = menuItem.toCartItem(restaurantName);
                await cartNotifier.addItem(cartItem);
              },
              child: Text(S.of(context).clearCurrentCart),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Opacity(
          opacity: isUnavailable ? 0.6 : 1.0,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                // Menu item image
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: menuItem.image != null
                        ? DecorationImage(
                            image: NetworkImage(menuItem.image!),
                            fit: BoxFit.cover,
                            onError: (error, stackTrace) {},
                          )
                        : null,
                    color: menuItem.image == null ? Colors.grey[300] : null,
                  ),
                  child: menuItem.image == null
                      ? const Icon(Icons.fastfood, color: Colors.grey)
                      : null,
                ),

                SizedBox(width: 12.w),

                // Menu item info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menuItem.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        menuItem.description,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.w),
                      Row(
                        children: [
                          Text(
                            '${menuItem.price.toStringAsFixed(0)}đ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: Colors.orange,
                            ),
                          ),
                          const Spacer(),
                          if (isUnavailable)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.w,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                menuItem.status == MenuItemStatus.soldOut
                                    ? S.of(context).outOfStock
                                    : S.of(context).unavailable,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Decrease/Remove button
                                  if (itemQuantity > 0)
                                    IconButton(
                                      onPressed: () async {
                                        if (itemQuantity > 1) {
                                          await cartNotifier.updateItemQuantity(
                                            menuItem.id ?? 0, 
                                            itemQuantity - 1
                                          );
                                        } else {
                                          await cartNotifier.removeItem(menuItem.id ?? 0);
                                        }
                                      },
                                      icon: Icon(
                                        itemQuantity > 1 ? Icons.remove : Icons.delete_outline,
                                        size: 16,
                                        color: itemQuantity > 1 ? Colors.orange : Colors.red,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                  
                                  // Quantity display
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Text(
                                      '$itemQuantity',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  
                                  // Add button
                                  IconButton(
                                    onPressed: !menuItem.canAddToCart
                                        ? null
                                        : () async {
                                            if (itemQuantity == 0) {
                                              // Check if can add from this restaurant
                                              if (!canAddFromRestaurant) {
                                                showRestaurantConflictDialog();
                                                return;
                                              }
                                              // Add new item to cart
                                              final cartItem = menuItem.toCartItem(restaurantName);
                                              await cartNotifier.addItem(cartItem);
                                            } else {
                                              // Increase quantity
                                              await cartNotifier.updateItemQuantity(
                                                menuItem.id ?? 0,
                                                itemQuantity + 1
                                              );
                                            }
                                          },
                                    icon: Icon(
                                      Icons.add,
                                      size: 16,
                                      color: !menuItem.canAddToCart
                                          ? Colors.grey
                                          : Colors.orange,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
