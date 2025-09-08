import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../providers/cart_providers.dart';

/// Widget for displaying a single cart item
class CartItemWidget extends ConsumerWidget {
  final CartItemEntity cartItem;
  final VoidCallback? onQuantityChanged;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: context.colors.surface,
                    child: cartItem.imageUrl != null
                        ? Image.network(
                            cartItem.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.restaurant,
                                size: 40,
                                color: context.colors.textSecondary,
                              );
                            },
                          )
                        : Icon(
                            Icons.restaurant,
                            size: 40,
                            color: context.colors.textSecondary,
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                // Item Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.menuItemName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.colors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${cartItem.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: context.colors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: context.colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Quantity Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Notes section (if exists)
                if (cartItem.notes != null && cartItem.notes!.isNotEmpty)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Note: ${cartItem.notes}',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                else
                  const Spacer(),
                
                const SizedBox(width: 16),
                
                // Quantity Controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colors.outline),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Decrease button
                      InkWell(
                        onTap: cartItem.quantity > 1
                            ? () {
                                ref.read(cartNotifierProvider.notifier)
                                    .updateItemQuantity(cartItem.menuItemId, cartItem.quantity - 1);
                                onQuantityChanged?.call();
                              }
                            : () {
                                ref.read(cartNotifierProvider.notifier)
                                    .removeItem(cartItem.menuItemId);
                                onQuantityChanged?.call();
                              },
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            cartItem.quantity > 1 ? Icons.remove : Icons.delete_outline,
                            size: 20,
                            color: cartItem.quantity > 1 
                                ? context.colors.textPrimary 
                                : context.colors.error,
                          ),
                        ),
                      ),
                      
                      // Quantity display
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          cartItem.quantity.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.colors.textPrimary,
                          ),
                        ),
                      ),
                      
                      // Increase button
                      InkWell(
                        onTap: () {
                          ref.read(cartNotifierProvider.notifier)
                              .updateItemQuantity(cartItem.menuItemId, cartItem.quantity + 1);
                          onQuantityChanged?.call();
                        },
                        borderRadius: const BorderRadius.horizontal(right: Radius.circular(24)),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: context.colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
