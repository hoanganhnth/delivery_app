import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import '../../domain/entities/order_entity.dart';

/// Order Card - Editorial style với image, status badge, và hover effects
class OrderCard extends StatefulWidget {
  final OrderEntity order;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.onCancel,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isActive = widget.order.status == OrderStatus.pending ||
        widget.order.status == OrderStatus.delivering;
    final isCompleted = widget.order.status == OrderStatus.delivered;
    final isCancelled = widget.order.status == OrderStatus.cancelled;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: ResponsiveSize.m),
          decoration: BoxDecoration(
            color: isCompleted
                ? colors.cardBackground.withValues(alpha: 0.5)
                : colors.cardBackground,
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusXl),
            border: Border.all(
              color: isActive
                  ? colors.border
                  : isCancelled
                      ? colors.border.withValues(alpha: 0.5)
                      : Colors.transparent,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? colors.shadow.withValues(alpha: 0.15)
                    : colors.shadow.withValues(alpha: 0.05),
                blurRadius: _isHovered ? 16 : 8,
                offset: Offset(0, _isHovered ? 6 : 2),
              ),
            ],
          ),
          child: Opacity(
            opacity: isCancelled ? 0.75 : (isCompleted ? 0.9 : 1.0),
            child: Padding(
              padding: EdgeInsets.all(ResponsiveSize.m),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Image
                  _buildOrderImage(colors, isCancelled),
                  SizedBox(width: ResponsiveSize.m),
                  // Order Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header: Restaurant Name + Status Badge
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                _getRestaurantName(),
                                style: TextStyle(
                                  fontSize: ResponsiveSize.fontXl,
                                  fontWeight: FontWeight.w900,
                                  color: colors.textPrimary,
                                  letterSpacing: -0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: ResponsiveSize.s),
                            _OrderStatusBadge(status: widget.order.status),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        // Date + Items
                        Text(
                          '${_formatDate(widget.order.createdAt)} • ${widget.order.totalItems} ${widget.order.totalItems > 1 ? 'items' : 'item'}',
                          style: TextStyle(
                            fontSize: ResponsiveSize.fontS,
                            fontWeight: FontWeight.w600,
                            color: colors.textSecondary,
                          ),
                        ),
                        SizedBox(height: ResponsiveSize.m),
                        // Footer: Price + Action
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Price
                            Text(
                              '\$${widget.order.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: ResponsiveSize.fontL,
                                fontWeight: FontWeight.w900,
                                color: colors.textPrimary,
                              ),
                            ),
                            // Action
                            _buildActionButton(colors, isActive, isCancelled),
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
      ),
    );
  }

  Widget _buildOrderImage(AppColors colors, bool isCancelled) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 96.w,
      height: 96.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
        color: colors.primary.withValues(alpha: 0.1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
        child: _buildPlaceholderImage(colors), // Always use placeholder for now
      ),
    );
  }

  Widget _buildPlaceholderImage(AppColors colors) {
    return Center(
      child: Icon(
        Icons.restaurant,
        color: colors.primary,
        size: 40.w,
      ),
    );
  }

  String _getRestaurantName() {
    // Get restaurant name from first item if available
    if (widget.order.items.isNotEmpty &&
        widget.order.items.first.menuItemName.isNotEmpty) {
      final firstWord = widget.order.items.first.menuItemName.split(' ').first;
      return '$firstWord Restaurant';
    }
    return 'Restaurant #${widget.order.id ?? 0}';
  }

  Widget _buildActionButton(
      AppColors colors, bool isActive, bool isCancelled) {
    String text;
    IconData icon;
    Color color;

    if (isActive) {
      text = 'Track Order';
      icon = Icons.near_me;
      color = colors.primary;
    } else if (isCancelled) {
      text = 'Reorder';
      icon = Icons.refresh;
      color = colors.textSecondary;
    } else {
      text = 'View Details';
      icon = Icons.chevron_right;
      color = colors.textSecondary;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: ResponsiveSize.fontS,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(width: 2.w),
        Icon(icon, color: color, size: 18.w),
      ],
    );
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'Unknown';
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      // Format: "Oct 24"
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[dateTime.month - 1]} ${dateTime.day}';
    }
  }
}

/// Status Badge - Uppercase với tracking widest
class _OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;

  const _OrderStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case OrderStatus.pending:
      case OrderStatus.delivering:
        bgColor = colors.primary.withValues(alpha: 0.1);
        textColor = colors.primary;
        text = status == OrderStatus.pending ? 'PENDING' : 'IN TRANSIT';
        break;
      case OrderStatus.delivered:
        bgColor = colors.success.withValues(alpha: 0.1);
        textColor = colors.success;
        text = 'COMPLETED';
        break;
      case OrderStatus.cancelled:
        bgColor = colors.error.withValues(alpha: 0.1);
        textColor = colors.error;
        text = 'CANCELLED';
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.s,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusS),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w900,
          color: textColor,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
