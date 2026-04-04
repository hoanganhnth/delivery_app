import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

/// Amber Hearth style restaurant card
/// 
/// Features:
/// - Border radius: 40px (rounded-[2.5rem])
/// - Image height: 192px (h-48)
/// - Hover: Image scale-105 transition-500
/// - Badge position: Absolute top-4 right-4
/// - Time badge: Bottom-4 left-4 with backdrop-blur
class RestaurantCard extends StatefulWidget {
  /// Restaurant name
  final String name;
  
  /// Restaurant image URL
  final String? imageUrl;
  
  /// Restaurant rating (0-5)
  final double rating;
  
  /// Delivery time (e.g., "15-25 min")
  final String deliveryTime;
  
  /// Restaurant category (e.g., "Modern American")
  final String category;
  
  /// Price level (e.g., "$$$")
  final String priceLevel;
  
  /// Distance (e.g., "1.2 miles")
  final String distance;
  
  /// Delivery fee (e.g., "Free Delivery" or "$2.99 Delivery")
  final String deliveryFee;
  
  /// Whether delivery is free
  final bool isFreeDelivery;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;

  const RestaurantCard({
    super.key,
    required this.name,
    this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.category,
    required this.priceLevel,
    required this.distance,
    required this.deliveryFee,
    this.isFreeDelivery = false,
    this.onTap,
  });

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with overlays
            Stack(
              children: [
                // Image container
                Container(
                  height: 192,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: AnimatedScale(
                      scale: _isHovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: widget.imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: widget.imageUrl!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => Container(
                                color: const Color(0xFFF4EEE7),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: context.colors.primary,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: const Color(0xFFF4EEE7),
                                child: Icon(
                                  Icons.restaurant,
                                  size: 64,
                                  color: context.colors.secondary,
                                ),
                              ),
                            )
                          : Container(
                              color: const Color(0xFFF4EEE7),
                              child: Icon(
                                Icons.restaurant,
                                size: 64,
                                color: context.colors.secondary,
                              ),
                            ),
                    ),
                  ),
                ),
                
                // Rating badge (top-right)
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Color(0xFFF59E0B), // amber-500
                        ),
                        SizedBox(width: 4),
                        Text(
                          widget.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1C160D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Delivery time badge (bottom-left)
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C160D).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          widget.deliveryTime.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Restaurant info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1C160D),
                          letterSpacing: -0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${widget.category} • ${widget.priceLevel} • ${widget.distance}',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.colors.secondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(width: 12),
                
                // Delivery fee badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isFreeDelivery
                        ? context.colors.primary.withValues(alpha: 0.1)
                        : const Color(0xFFEDE7E0),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    widget.deliveryFee.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      color: widget.isFreeDelivery
                          ? context.colors.primary
                          : context.colors.secondary,
                    ),
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
