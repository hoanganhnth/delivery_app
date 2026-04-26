import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import '../widgets/delivery_timeline.dart';
import '../widgets/courier_info_card.dart';
import '../widgets/order_progress_bar.dart';
import '../providers/providers.dart';
import '../../domain/entities/order_entity.dart';

/// Track Order Screen - Dark Nav với Map và Real-time Tracking
class TrackOrderScreen extends ConsumerWidget {
  final num orderId;
  
  const TrackOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderDetailProvider(orderId));
    final colors = ref.colors;
    
    return Scaffold(
      backgroundColor: colors.background,
      body: orderState.when(
        data: (order) => order == null
            ? _buildOrderNotFound(colors)
            : _TrackOrderBody(order: order),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _buildError(colors, error.toString(), ref),
      ),
    );
  }

  Widget _buildOrderNotFound(AppColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.w,
            color: colors.textSecondary,
          ),
          SizedBox(height: ResponsiveSize.m),
          Text(
            'Không tìm thấy đơn hàng',
            style: TextStyle(
              fontSize: ResponsiveSize.fontL,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(AppColors colors, String message, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.w,
            color: colors.error,
          ),
          SizedBox(height: ResponsiveSize.m),
          Text(
            message,
            style: TextStyle(
              fontSize: ResponsiveSize.fontM,
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ResponsiveSize.l),
          ElevatedButton(
            onPressed: () => ref.invalidate(orderDetailProvider(orderId)),
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}

class _TrackOrderBody extends ConsumerWidget {
  final OrderEntity order;

  const _TrackOrderBody({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    
    return Stack(
      children: [
        // Map Section (Top 40%)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 353.h,
          child: _MapSection(order: order),
        ),
        
        // Floating Back Button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8.h,
          left: ResponsiveSize.m,
          child: _FloatingBackButton(colors: colors),
        ),
        
        // Main Content Card (Bottom)
        Positioned(
          top: 320.h,
          left: 0,
          right: 0,
          bottom: 0,
          child: _MainContentCard(order: order),
        ),
      ],
    );
  }
}

/// Map Section với placeholder
class _MapSection extends ConsumerWidget {
  final OrderEntity order;

  const _MapSection({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.primary.withValues(alpha: 0.1),
            colors.primary.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Grid Pattern (simulating map)
          CustomPaint(
            size: Size.infinite,
            painter: _MapGridPainter(
              gridColor: colors.border.withValues(alpha: 0.3),
            ),
          ),
          
          // Route Simulation
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Restaurant Icon
                _MapMarker(
                  icon: Icons.restaurant,
                  color: colors.primary,
                  label: 'Nhà hàng',
                ),
                
                // Route line
                Container(
                  width: 3.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colors.primary,
                        colors.primary.withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Delivery Icon (animated position would go here)
                _MapMarker(
                  icon: Icons.delivery_dining,
                  color: colors.success,
                  label: 'Shipper',
                  isActive: true,
                ),
                
                // Route line to destination
                Container(
                  width: 3.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: colors.border.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Destination Icon
                _MapMarker(
                  icon: Icons.location_on,
                  color: colors.error,
                  label: 'Giao hàng',
                ),
              ],
            ),
          ),
          
          // ETA Badge (top right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.h,
            right: ResponsiveSize.m,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.m,
                vertical: ResponsiveSize.s,
              ),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
                boxShadow: [
                  BoxShadow(
                    color: colors.shadow.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16.w,
                    color: colors.primary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '15-20 phút',
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontS,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Map Marker Widget
class _MapMarker extends ConsumerWidget {
  final IconData icon;
  final Color color;
  final String label;
  final bool isActive;

  const _MapMarker({
    required this.icon,
    required this.color,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isActive ? 48.w : 40.w,
          height: isActive ? 48.w : 40.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 16,
                      spreadRadius: 4,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: isActive ? 24.w : 20.w,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

/// Grid Painter for map simulation
class _MapGridPainter extends CustomPainter {
  final Color gridColor;

  _MapGridPainter({required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    const spacing = 30.0;

    // Vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Floating Back Button
class _FloatingBackButton extends ConsumerWidget {
  final AppColors colors;

  const _FloatingBackButton({required this.colors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: colors.cardBackground,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back,
          color: colors.textPrimary,
          size: 20.w,
        ),
      ),
    );
  }
}

/// Main Content Card with status and timeline
class _MainContentCard extends ConsumerWidget {
  final OrderEntity order;

  const _MainContentCard({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          ResponsiveSize.l,
          ResponsiveSize.l,
          ResponsiveSize.l,
          ResponsiveSize.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            SizedBox(height: ResponsiveSize.l),
            
            // Status Header
            _StatusHeader(order: order),
            
            SizedBox(height: ResponsiveSize.l),
            
            // Progress Bar
            OrderProgressBar(
              progress: _getProgress(order.status),
            ),
            
            SizedBox(height: ResponsiveSize.xl),
            
            // Courier Info (if delivering)
            if (order.status == OrderStatus.delivering) ...[
              CourierInfoCard(
                courierName: 'Hoàng Minh Quân', // TODO: Get from order
                courierPhoto: null,
                rating: 4.9,
                onCall: () {
                  // TODO: Call courier
                },
                onChat: () {
                  // TODO: Chat with courier
                },
              ),
              SizedBox(height: ResponsiveSize.l),
            ],
            
            // Timeline
            Container(
              padding: EdgeInsets.all(ResponsiveSize.m),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(ResponsiveSize.radiusXl),
              ),
              child: DeliveryTimeline(
                status: order.status,
                rawBackendStatus: order.rawBackendStatus,
              ),
            ),
            
            SizedBox(height: ResponsiveSize.l),
            
            // Order Details Card
            _OrderDetailsCard(order: order),
          ],
        ),
      ),
    );
  }


  double _getProgress(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 0.33;
      case OrderStatus.delivering:
        return 0.66;
      case OrderStatus.delivered:
        return 1.0;
      case OrderStatus.cancelled:
        return 0.0;
    }
  }
}

/// Status Header
class _StatusHeader extends ConsumerWidget {
  final OrderEntity order;

  const _StatusHeader({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getStatusTitle(order.status),
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900,
                  color: colors.textPrimary,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                _getStatusSubtitle(order.status),
                style: TextStyle(
                  fontSize: ResponsiveSize.fontM,
                  fontWeight: FontWeight.w500,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        // Order ID Badge
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.m,
            vertical: ResponsiveSize.s,
          ),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
          ),
          child: Text(
            '#${order.id}',
            style: TextStyle(
              fontSize: ResponsiveSize.fontS,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
        ),
      ],
    );
  }

  String _getStatusTitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Đang xác nhận';
      case OrderStatus.delivering:
        return 'Đang giao hàng';
      case OrderStatus.delivered:
        return 'Đã giao thành công';
      case OrderStatus.cancelled:
        return 'Đã hủy';
    }
  }

  String _getStatusSubtitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Nhà hàng đang xác nhận đơn của bạn';
      case OrderStatus.delivering:
        return 'Shipper đang trên đường giao hàng';
      case OrderStatus.delivered:
        return 'Đơn hàng đã được giao thành công';
      case OrderStatus.cancelled:
        return 'Đơn hàng đã bị hủy';
    }
  }
}

/// Order Details Card with dashed border
class _OrderDetailsCard extends ConsumerWidget {
  final OrderEntity order;

  const _OrderDetailsCard({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    
    return Container(
      padding: EdgeInsets.all(ResponsiveSize.m),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusXl),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chi tiết đơn hàng',
                style: TextStyle(
                  fontSize: ResponsiveSize.fontL,
                  fontWeight: FontWeight.w900,
                  color: colors.textPrimary,
                ),
              ),
              Icon(
                Icons.receipt_long,
                color: colors.textSecondary,
                size: 20.w,
              ),
            ],
          ),
          
          SizedBox(height: ResponsiveSize.m),
          
          // Items
          ...order.items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: ResponsiveSize.s),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${item.quantity}x ${item.menuItemName}',
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontM,
                      fontWeight: FontWeight.w500,
                      color: colors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '₫${(item.price * item.quantity).toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: ResponsiveSize.fontM,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          )),
          
          // Divider
          Padding(
            padding: EdgeInsets.symmetric(vertical: ResponsiveSize.s),
            child: Divider(
              color: colors.border.withValues(alpha: 0.3),
              height: 1,
            ),
          ),
          
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng cộng',
                style: TextStyle(
                  fontSize: ResponsiveSize.fontL,
                  fontWeight: FontWeight.w900,
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '₫${order.totalAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: colors.primary,
                ),
              ),
            ],
          ),
          
          SizedBox(height: ResponsiveSize.m),
          
          // Delivery Address
          Container(
            padding: EdgeInsets.all(ResponsiveSize.m),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: colors.primary,
                  size: 20.w,
                ),
                SizedBox(width: ResponsiveSize.s),
                Expanded(
                  child: Text(
                    order.deliveryAddress,
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontS,
                      fontWeight: FontWeight.w500,
                      color: colors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

