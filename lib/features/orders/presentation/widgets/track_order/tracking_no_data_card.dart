import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/orders/presentation/providers/providers.dart';
import 'package:delivery_app/generated/l10n.dart';

class TrackingNoDataCard extends ConsumerWidget {
  final int orderId;
  final bool canTrackingRealtime;

  const TrackingNoDataCard({
    super.key,
    required this.orderId,
    required this.canTrackingRealtime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_searching, size: 64, color: Colors.grey[400]),
              SizedBox(height: 16.w),
              Text(
                S.of(context).noTrackingInfo,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: ref.colors.textSecondary,
                ),
              ),
              SizedBox(height: 8.w),
              Text(
                S.of(context).shipperNotStarted,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.w),
              ElevatedButton.icon(
                onPressed: () {
                  ref
                      .read(deliveryTrackingProvider.notifier)
                      .startTrackingOrderSafe(
                        orderId,
                        trackingRealtime: canTrackingRealtime,
                      );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Thử lại'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
