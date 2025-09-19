import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/order_entity.dart';
import '../widgets/order_card.dart';

/// Widget hiển thị danh sách orders
class OrdersList extends StatelessWidget {
  final List<OrderEntity> orders;
  final bool isLoading;
  final ScrollController? scrollController;
  final Function(int orderId) onOrderTap;
  final Function(OrderEntity order)? onOrderCancel;

  const OrdersList({
    super.key,
    required this.orders,
    required this.isLoading,
    required this.onOrderTap,
    this.scrollController,
    this.onOrderCancel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.all(16.w),
      itemCount: orders.length + (isLoading ? 1 : 0),
      separatorBuilder: (context, index) => SizedBox(height: 12.w),
      itemBuilder: (context, index) {
        if (index == orders.length) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final order = orders[index];
        return OrderCard(
          order: order,
          onTap: () => onOrderTap(order.id!),
          onCancel: order.status == OrderStatus.pending
              ? () => onOrderCancel?.call(order)
              : null,
        );
      },
    );
  }
}
