import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/order_entity.dart';

/// Widget hiển thị thông tin khách hàng
class OrderCustomerInfoCard extends StatelessWidget {
  final OrderEntity order;

  const OrderCustomerInfoCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: theme.primaryColor,
                  size: 24,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Thông tin khách hàng',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.w),
            _buildInfoRow(
              context,
              Icons.person_outline,
              'Tên khách hàng',
              order.customerName,
            ),
            SizedBox(height: 8.w),
            _buildInfoRow(
              context,
              Icons.phone,
              'Số điện thoại',
              order.customerPhone,
            ),
            SizedBox(height: 8.w),
            _buildInfoRow(
              context,
              Icons.location_on,
              'Địa chỉ giao hàng',
              order.deliveryAddress,
            ),
            if (order.notes != null && order.notes!.isNotEmpty) ...[
              SizedBox(height: 8.w),
              _buildInfoRow(
                context,
                Icons.note,
                'Ghi chú',
                order.notes!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                value,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
