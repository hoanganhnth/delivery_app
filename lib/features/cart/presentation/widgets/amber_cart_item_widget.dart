import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

/// Amber Hearth style cart item widget
/// 
/// Features:
/// - Horizontal layout: image + content + quantity control
/// - Border radius: 32px (rounded-[2rem])
/// - Image: 96x96px rounded-2xl
/// - Quantity control: Vertical pill with shadow-inner
/// - Hover: shadow-md elevation
class AmberCartItemWidget extends StatefulWidget {
  /// Item name
  final String name;
  
  /// Item image URL
  final String? imageUrl;
  
  /// Item subtitle (e.g., "Medium Rare • Khoai tây nghiền")
  final String? subtitle;
  
  /// Item price (formatted string)
  final String price;
  
  /// Current quantity
  final int quantity;
  
  /// Callback when quantity is increased
  final VoidCallback? onIncrease;
  
  /// Callback when quantity is decreased
  final VoidCallback? onDecrease;
  
  /// Callback when item is tapped
  final VoidCallback? onTap;

  const AmberCartItemWidget({
    super.key,
    required this.name,
    this.imageUrl,
    this.subtitle,
    required this.price,
    required this.quantity,
    this.onIncrease,
    this.onDecrease,
    this.onTap,
  });

  @override
  State<AmberCartItemWidget> createState() => _AmberCartItemWidgetState();
}

class _AmberCartItemWidgetState extends State<AmberCartItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.08 : 0.05),
                blurRadius: _isHovered ? 12 : 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Item image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: widget.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: widget.imageUrl!,
                          fit: BoxFit.cover,
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
                              Icons.fastfood,
                              size: 48,
                              color: context.colors.secondary,
                            ),
                          ),
                        )
                      : Container(
                          color: const Color(0xFFF4EEE7),
                          child: Icon(
                            Icons.fastfood,
                            size: 48,
                            color: context.colors.secondary,
                          ),
                        ),
                ),
              ),
              
              SizedBox(width: 16),
              
              // Item details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C160D),
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.subtitle != null) ...[
                      SizedBox(height: 4),
                      Text(
                        widget.subtitle!,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: context.colors.secondary.withValues(alpha: 0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: 8),
                    Text(
                      widget.price,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 16),
              
              // Quantity control
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: context.colors.background,
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                      spreadRadius: -1,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Increase button
                    _QuantityButton(
                      icon: Icons.add,
                      onTap: widget.onIncrease,
                    ),
                    
                    // Quantity
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        widget.quantity.toString(),
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1C160D),
                        ),
                      ),
                    ),
                    
                    // Decrease button
                    _QuantityButton(
                      icon: Icons.remove,
                      onTap: widget.onDecrease,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Quantity button (+ or -)
class _QuantityButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _QuantityButton({
    required this.icon,
    this.onTap,
  });

  @override
  State<_QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<_QuantityButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        transform: Matrix4.identity()..scale(_isPressed ? 0.9 : 1.0),
        child: Icon(
          widget.icon,
          size: 16,
          color: context.colors.secondary,
        ),
      ),
    );
  }
}
