import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../domain/entities/livestream_entity.dart';

/// Bottom sheet hiển thị danh sách sản phẩm trong livestream
class LivestreamProductSheet extends ConsumerWidget {
  final List<LivestreamProductEntity> products;

  const LivestreamProductSheet({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.w),
            width: 40.w,
            height: 4.w,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Text(
                  'Sản phẩm trong livestream',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${products.length} sản phẩm',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.w),

          // Product list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _ProductItem(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductItem extends ConsumerWidget {
  final LivestreamProductEntity product;

  const _ProductItem({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(cartNotifierProvider.notifier);

    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: product.image,
              width: 80.w,
              height: 80.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: Icon(Icons.fastfood, size: 40, color: Colors.grey),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                if (product.description != null) ...[
                  SizedBox(height: 4.w),
                  Text(
                    product.description!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                SizedBox(height: 8.w),

                // Price
                Row(
                  children: [
                    if (product.hasDiscount) ...[
                      Text(
                        '₫${product.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      '₫${product.finalPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: context.colors.primary,
                      ),
                    ),
                    if (product.hasDiscount) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '-${product.discountPercent}%',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                SizedBox(height: 8.w),

                // Stock info
                if (product.stockQuantity != null)
                  Text(
                    'Còn ${product.stockQuantity} sản phẩm',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: product.stockQuantity! > 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Add to cart button
          ElevatedButton(
            onPressed: () async {
              // Create cart item from product
              final cartItem = CartItemEntity(
                menuItemId: product.id,
                menuItemName: product.name,
                price: product.finalPrice,
                quantity: 1,
                restaurantId: product.restaurantId,
                restaurantName: product.restaurantName,
                imageUrl: product.image,
              );

              await cartNotifier.addItem(cartItem);

              // Show snackbar
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã thêm ${product.name} vào giỏ hàng'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Icon(Icons.add_shopping_cart, size: 20),
          ),
        ],
      ),
    );
  }
}
