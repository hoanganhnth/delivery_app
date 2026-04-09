import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

/// Restaurant header card for cart screen
/// 
/// Features:
/// - White card with rounded-3xl (24px)
/// - Logo: 64x64px rounded-2xl
/// - "Đang đặt tại" uppercase badge
/// - Rating and distance info
/// - Large verified icon watermark (primary/5)
class RestaurantHeaderCard extends ConsumerWidget {
  /// Restaurant name
  final String name;
  
  /// Restaurant logo URL
  final String? logoUrl;
  
  /// Restaurant rating (0-5)
  final double rating;
  
  /// Distance (e.g., "1.2km")
  final String distance;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;

  const RestaurantHeaderCard({
    super.key,
    required this.name,
    this.logoUrl,
    required this.rating,
    required this.distance,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative watermark
            Positioned(
              right: -16,
              bottom: -16,
              child: Icon(
                Icons.verified,
                size: 144,
                color: ref.colors.primary.withValues(alpha: 0.05),
              ),
            ),
            
            // Content
            Row(
              children: [
                // Restaurant logo
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: ref.colors.primary.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: logoUrl != null
                        ? CachedNetworkImage(
                            imageUrl: logoUrl!,
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
                                Icons.restaurant,
                                size: 32,
                                color: ref.colors.secondary,
                              ),
                            ),
                          )
                        : Container(
                            color: const Color(0xFFF4EEE7),
                            child: Icon(
                              Icons.restaurant,
                              size: 32,
                              color: ref.colors.secondary,
                            ),
                          ),
                  ),
                ),
                
                SizedBox(width: 16),
                
                // Restaurant info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ĐANG ĐẶT TẠI',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: ref.colors.secondary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          color: Color(0xFF1C160D),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: ref.colors.primary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1C160D),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '• $distance',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: ref.colors.secondary,
                            ),
                          ),
                        ],
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
