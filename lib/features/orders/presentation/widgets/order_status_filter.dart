import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/order_entity.dart';
import '../../../../generated/l10n.dart';

/// Widget để lọc đơn hàng theo trạng thái
class OrderStatusFilter extends StatelessWidget {
  final OrderStatus? selectedStatus;
  final Function(OrderStatus?) onStatusChanged;

  const OrderStatusFilter({
    super.key,
    this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: 50.w,
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _buildFilterChip(
            context: context,
            theme: theme,
            label: S.of(context).all,
            isSelected: selectedStatus == null,
            onTap: () => onStatusChanged(null),
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context: context,
            theme: theme,
            label: S.of(context).pending,
            isSelected: selectedStatus == OrderStatus.pending,
            onTap: () => onStatusChanged(OrderStatus.pending),
            color: OrderStatus.pending.color,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context: context,
            theme: theme,
            label: S.of(context).delivering,
            isSelected: selectedStatus == OrderStatus.delivering,
            onTap: () => onStatusChanged(OrderStatus.delivering),
            color: OrderStatus.delivering.color,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context: context,
            theme: theme,
            label: S.of(context).delivered,
            isSelected: selectedStatus == OrderStatus.delivered,
            onTap: () => onStatusChanged(OrderStatus.delivered),
            color: OrderStatus.delivered.color,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context: context,
            theme: theme,
            label: S.of(context).cancelled,
            isSelected: selectedStatus == OrderStatus.cancelled,
            onTap: () => onStatusChanged(OrderStatus.cancelled),
            color: OrderStatus.cancelled.color,
          ),
          _buildFilterChip(
            context: context,
            theme: theme,
            label: S.of(context).delivered,
            isSelected: selectedStatus == OrderStatus.delivered,
            onTap: () => onStatusChanged(OrderStatus.delivered),
            color: OrderStatus.delivered.color,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context: context,
            theme: theme,
            label: S.of(context).cancelled,
            isSelected: selectedStatus == OrderStatus.cancelled,
            onTap: () => onStatusChanged(OrderStatus.cancelled),
            color: OrderStatus.cancelled.color,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required ThemeData theme,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    Color? color,
  }) {
    final chipColor = color ?? theme.colorScheme.primary;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
        decoration: BoxDecoration(
          color: isSelected ? chipColor.withValues(alpha: 0.1) : null,
          border: Border.all(
            color: isSelected ? chipColor : theme.colorScheme.outline,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isSelected ? chipColor : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
