import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../widgets/order_status_card.dart';
import '../widgets/order_customer_info_card.dart';
import '../widgets/order_items_card.dart';
import '../widgets/order_payment_card.dart';
import '../widgets/order_action_buttons.dart';
import '../widgets/order_error_widgets.dart';
import '../widgets/order_delivery_tracking_card.dart';
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
    // Load order detail when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderDetailProvider.notifier).getOrderById(widget.orderId);
    });
  }

  @override
  void dispose() {
    // ref.invalidate(orderDetailProvider);
    // ref.read(shipperLocationNotifierProvider.notifier).stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailState = ref.watch(orderDetailProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${S.of(context).order} #${widget.orderId}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _buildBody(orderDetailState, theme),
    );
  }

  Widget _buildBody(OrderDetailState orderDetailState, ThemeData theme) {
    if (orderDetailState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orderDetailState.errorMessage != null) {
      return OrderErrorWidget(
        message: orderDetailState.errorMessage!,
        onRetry: () =>
            ref.read(orderDetailProvider.notifier).getOrderById(widget.orderId),
      );
    }

    if (orderDetailState.order == null) {
      return const OrderNotFoundWidget();
    }

    final order = orderDetailState.order!;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(orderDetailProvider.notifier).getOrderById(widget.orderId);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderStatusCard(order: order),
            SizedBox(height: 16.w),

            // Delivery tracking section for orders being delivered
            if (order.status == OrderStatus.delivering)
              OrderDeliveryTrackingCard(order: order),

            OrderCustomerInfoCard(order: order),
            SizedBox(height: 16.w),
            OrderItemsCard(order: order),
            SizedBox(height: 16.w),
            OrderPaymentCard(order: order),
            SizedBox(height: 16.w),
            OrderActionButtons(
              order: order,
              onOrderCanceled: () {
                // Refresh the order after cancellation
                ref
                    .read(orderDetailProvider.notifier)
                    .getOrderById(widget.orderId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
