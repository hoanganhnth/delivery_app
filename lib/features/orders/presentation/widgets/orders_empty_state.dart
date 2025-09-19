import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/l10n.dart';

/// Widget hiển thị khi không có orders
class OrdersEmptyState extends StatelessWidget {
  final VoidCallback? onGoToRestaurants;

  const OrdersEmptyState({
    super.key,
    this.onGoToRestaurants,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            SizedBox(height: 24.w),
            Text(
              S.of(context).noOrders,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              S.of(context).noOrdersMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.w),
            ElevatedButton.icon(
              onPressed: onGoToRestaurants,
              icon: const Icon(Icons.restaurant),
              label: Text(S.of(context).restaurants),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
