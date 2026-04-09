import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

/// Category pill widget following Amber Hearth design
/// 
/// Features:
/// - Icon + Label vertical layout
/// - 64x64px icon container
/// - Hover effect: -translate-y-1
/// - Active: Primary background with shadow-lg
/// - Inactive: White with border
class CategoryPill extends ConsumerStatefulWidget {
  /// Category icon
  final IconData icon;
  
  /// Category label (will be uppercase)
  final String label;
  
  /// Whether this category is currently selected
  final bool isActive;
  
  /// Callback when category is tapped
  final VoidCallback onTap;

  const CategoryPill({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  ConsumerState<CategoryPill> createState() => _CategoryPillState();
}

class _CategoryPillState extends ConsumerState<CategoryPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..translate(
              0.0,
              (widget.isActive || _isHovered) ? -4.0 : 0.0,
            ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon container
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? ref.colors.primary // primary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16), // rounded-2xl
                  border: widget.isActive
                      ? null
                      : Border.all(
                          color: const Color(0xFFEDE7E0), // surface-container-high
                          width: 1,
                        ),
                  boxShadow: widget.isActive
                      ? [
                          BoxShadow(
                            color: ref.colors.primary.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Icon(
                  widget.icon,
                  size: 30,
                  color: widget.isActive
                      ? Colors.white
                      : ref.colors.primary, // primary
                ),
              ),
              SizedBox(height: 8),
              // Label
              Text(
                widget.label.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: widget.isActive
                      ? ref.colors.primary // primary
                      : ref.colors.secondary, // secondary
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
