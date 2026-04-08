import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../widgets/order_customer_info_card.dart';
import '../widgets/order_payment_card.dart';
import '../widgets/order_action_buttons.dart';
import '../widgets/order_error_widgets.dart';
import '../widgets/delivery_timeline.dart';
import '../widgets/courier_info_card.dart';
import '../widgets/order_progress_bar.dart';
import '../../../../generated/l10n.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final num orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    // AsyncNotifier will auto-load when called with orderId parameter
    // No need to manually call getOrderById
  }

  @override
  void dispose() {
    // ref.invalidate(orderDetailProvider(widget.orderId));
    // ref.read(shipperLocationProvider.notifier).stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailState = ref.watch(orderDetailProvider(widget.orderId));
    final colors = context.colors;
    
    return Scaffold(
      backgroundColor: colors.background,
      appBar: _buildAppBar(colors),
      body: _buildBody(orderDetailState),
    );
  }

  PreferredSizeWidget _buildAppBar(AppColors colors) {
    return AppBar(
      backgroundColor: colors.background,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colors.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        '${S.of(context).order} #${widget.orderId}',
        style: TextStyle(
          fontSize: ResponsiveSize.fontL,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share_outlined, color: colors.textSecondary),
          onPressed: () {
            // TODO: Share order
          },
        ),
      ],
    );
  }

  Widget _buildBody(AsyncValue<OrderEntity?> orderDetailState) {
    final colors = context.colors;
    return orderDetailState.when(
      data: (order) => order == null
          ? const OrderNotFoundWidget()
          : RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(orderDetailProvider(widget.orderId));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(ResponsiveSize.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Status Card
                    _buildMainStatusCard(order, colors),
                    SizedBox(height: ResponsiveSize.m),
                    
                    // Delivery Timeline
                    if (order.status != OrderStatus.cancelled)
                      _buildTimelineSection(order, colors),
                    
                    // Courier Info (only if delivering)
                    if (order.status == OrderStatus.delivering) ...[
                      SizedBox(height: ResponsiveSize.m),
                      CourierInfoCard(
                        courierName: 'Hoàng Minh Quân', // TODO: Get from order
                        rating: 4.9,
                        onCall: () {
                          // TODO: Call courier
                        },
                        onChat: () {
                          // TODO: Chat with courier
                        },
                      ),
                    ],
                    
                    SizedBox(height: ResponsiveSize.m),
                    
                    // Order Items
                    _buildOrderItemsSection(order, colors),
                    
                    SizedBox(height: ResponsiveSize.m),
                    
                    // Customer Info
                    OrderCustomerInfoCard(order: order),
                    
                    SizedBox(height: ResponsiveSize.m),
                    
                    // Payment
                    OrderPaymentCard(order: order),
                    
                    SizedBox(height: ResponsiveSize.m),
                    
                    // Actions
                    OrderActionButtons(
                      order: order,
                      onOrderCanceled: () => ref.invalidate(
                        orderDetailProvider(widget.orderId),
                      ),
                    ),
                    
                    SizedBox(height: ResponsiveSize.xl),
                  ],
                ),
              ),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => OrderErrorWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(orderDetailProvider(widget.orderId)),
      ),
    );
  }

  Widget _buildMainStatusCard(OrderEntity order, AppColors colors) {
    return Container(
      padding: EdgeInsets.all(ResponsiveSize.l),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusXl * 1.5),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStatusTitle(order.status),
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w900,
                        color: colors.textPrimary,
                        letterSpacing: -1,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    if (order.estimatedDeliveryTime != null)
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: colors.primary,
                            size: 18.w,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Dự kiến 15-20 phút',
                            style: TextStyle(
                              fontSize: ResponsiveSize.fontL,
                              fontWeight: FontWeight.w600,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
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
          ),
          
          SizedBox(height: ResponsiveSize.l),
          
          // Progress Bar
          if (order.status != OrderStatus.cancelled)
            OrderProgressBar(
              progress: _getProgress(order.status),
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection(OrderEntity order, AppColors colors) {
    return Container(
      padding: EdgeInsets.all(ResponsiveSize.l),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusXl * 1.5),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DeliveryTimeline(
        currentStep: _getCurrentStep(order.status),
      ),
    );
  }

  Widget _buildOrderItemsSection(OrderEntity order, AppColors colors) {
    return Container(
      padding: EdgeInsets.all(ResponsiveSize.m + 4.w),
      decoration: BoxDecoration(
        color: colors.cardBackground.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusXl * 1.5),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.5),
          width: 2,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Icons.expand_more,
                color: colors.textSecondary,
              ),
            ],
          ),
          SizedBox(height: ResponsiveSize.m),
          // Items list
          ...order.items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: ResponsiveSize.s),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.quantity}x ${item.menuItemName}',
                      style: TextStyle(
                        fontSize: ResponsiveSize.fontM,
                        fontWeight: FontWeight.w500,
                        color: colors.textSecondary,
                      ),
                    ),
                    Text(
                      '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: ResponsiveSize.fontM,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              )),
          Divider(
            height: ResponsiveSize.l,
            color: colors.border.withValues(alpha: 0.3),
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
                '\$${order.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: ResponsiveSize.fontXl,
                  fontWeight: FontWeight.w900,
                  color: colors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStatusTitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Đang chờ xác nhận';
      case OrderStatus.delivering:
        return 'Đơn hàng đang được giao';
      case OrderStatus.delivered:
        return 'Đã giao thành công';
      case OrderStatus.cancelled:
        return 'Đơn hàng đã hủy';
    }
  }

  String _getCurrentStep(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'confirming';
      case OrderStatus.delivering:
        return 'delivering';
      case OrderStatus.delivered:
        return 'delivered';
      case OrderStatus.cancelled:
        return 'confirming';
    }
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