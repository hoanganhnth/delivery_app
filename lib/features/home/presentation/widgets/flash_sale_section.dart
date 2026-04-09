import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

/// Flash Sale Section following Amber Hearth design
/// 
/// Features:
/// - Primary/5 background with pattern overlay
/// - Countdown timer with dark chips
/// - Horizontal scroll sale items
/// - Discount badges (error color)
/// - Animated bolt icon
class FlashSaleSection extends ConsumerWidget {
  /// Sale items to display
  final List<FlashSaleItem> items;
  
  /// Countdown hours
  final int hours;
  
  /// Countdown minutes
  final int minutes;
  
  /// Countdown seconds
  final int seconds;
  
  /// Callback when "Shop Now" is tapped
  final VoidCallback? onShopNow;

  const FlashSaleSection({
    super.key,
    required this.items,
    this.hours = 4,
    this.minutes = 22,
    this.seconds = 15,
    this.onShopNow,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ref.colors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // Decorative watermark
          Positioned(
            right: -40,
            top: -40,
            child: Icon(
              Icons.verified,
              size: 200,
              color: ref.colors.primary.withValues(alpha: 0.1),
            ),
          ),
          
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with countdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title and countdown
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Flash Sale',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                                color: Color(0xFF1C160D),
                              ),
                            ),
                            SizedBox(width: 8),
                            TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0.8, end: 1.0),
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeInOut,
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Icon(
                                    Icons.bolt,
                                    color: ref.colors.primary,
                                    size: 24,
                                  ),
                                );
                              },
                              onEnd: () {
                                // Animation repeats automatically via TweenAnimationBuilder rebuild
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'ENDING IN',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: ref.colors.secondary,
                              ),
                            ),
                            SizedBox(width: 8),
                            _CountdownChip(value: hours.toString().padLeft(2, '0')),
                            const _CountdownSeparator(),
                            _CountdownChip(value: minutes.toString().padLeft(2, '0')),
                            const _CountdownSeparator(),
                            _CountdownChip(value: seconds.toString().padLeft(2, '0')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Shop Now button
                  GestureDetector(
                    onTap: onShopNow,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'SHOP NOW',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: ref.colors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // Sale items horizontal scroll
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (context, index) => SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return _SaleItemCard(item: items[index]);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Countdown chip widget
class _CountdownChip extends ConsumerWidget {
  final String value;

  const _CountdownChip({required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF1C160D),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Countdown separator ":"
class _CountdownSeparator extends ConsumerWidget {
  const _CountdownSeparator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        ':',
        style: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1C160D),
        ),
      ),
    );
  }
}

/// Sale item card widget
class _SaleItemCard extends ConsumerWidget {
  final FlashSaleItem item;

  const _SaleItemCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with discount badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 112,
                    width: double.infinity,
                    child: item.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: item.imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: const Color(0xFFF4EEE7),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ref.colors.primary,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: const Color(0xFFF4EEE7),
                              child: Icon(
                                Icons.fastfood,
                                size: 48,
                                color: ref.colors.secondary,
                              ),
                            ),
                          )
                        : Container(
                            color: const Color(0xFFF4EEE7),
                            child: Icon(
                              Icons.fastfood,
                              size: 48,
                              color: ref.colors.secondary,
                            ),
                          ),
                  ),
                ),
                
                // Discount badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBA1A1A), // error
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.discountBadge,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 12),
            
            // Item name
            Text(
              item.name,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C160D),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: 4),
            
            // Prices
            Row(
              children: [
                Text(
                  item.salePrice,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: ref.colors.primary,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  item.originalPrice,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 10,
                    decoration: TextDecoration.lineThrough,
                    color: ref.colors.secondary.withValues(alpha: 0.5),
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

/// Flash sale item data model
class FlashSaleItem {
  final String name;
  final String? imageUrl;
  final String salePrice;
  final String originalPrice;
  final String discountBadge; // e.g., "50% OFF", "BOGO"
  final VoidCallback? onTap;

  const FlashSaleItem({
    required this.name,
    this.imageUrl,
    required this.salePrice,
    required this.originalPrice,
    required this.discountBadge,
    this.onTap,
  });
}
