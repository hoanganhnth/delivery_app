import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/providers/providers.dart';
import '../../domain/entities/livestream_entity.dart';

/// Floating pinned product overlay that appears above the livestream video
/// when the host pins a product. Viewers can tap to add to cart immediately.
class LivestreamPinnedProductOverlay extends ConsumerStatefulWidget {
  final LivestreamProductEntity product;

  const LivestreamPinnedProductOverlay({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<LivestreamPinnedProductOverlay> createState() =>
      _LivestreamPinnedProductOverlayState();
}

class _LivestreamPinnedProductOverlayState
    extends ConsumerState<LivestreamPinnedProductOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  bool _addedToCart = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleAddToCart() async {
    final product = widget.product;
    final cartNotifier = ref.read(cartProvider.notifier);

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

    if (mounted) {
      setState(() => _addedToCart = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã thêm ${product.name} vào giỏ hàng'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Reset after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _addedToCart = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ref.colors.primary.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: ref.colors.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              // Product image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  width: 56.w,
                  height: 56.w,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: Colors.grey[800],
                    child: Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: Colors.grey[800],
                    child: Icon(
                      Icons.fastfood_rounded,
                      size: 28,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Live badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'ĐANG GHIM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.w),
                    // Name
                    Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.w),
                    // Price row
                    Row(
                      children: [
                        if (product.hasDiscount) ...[
                          Text(
                            '₫${product.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 11.sp,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 6.w),
                        ],
                        Text(
                          '₫${product.finalPrice.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: ref.colors.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (product.hasDiscount) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              '-${product.discountPercent}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // Add to cart button
              GestureDetector(
                onTap: _addedToCart ? null : _handleAddToCart,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.w,
                  ),
                  decoration: BoxDecoration(
                    color: _addedToCart
                        ? Colors.green
                        : ref.colors.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: (_addedToCart
                                ? Colors.green
                                : ref.colors.primary)
                            .withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: _addedToCart
                      ? Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        )
                      : Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
