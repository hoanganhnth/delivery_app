import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/generated/l10n.dart';

class TrackingNoDataCard extends StatelessWidget {
  final int orderId;
  final bool canTrackingRealtime;
  final VoidCallback? onRetry;

  const TrackingNoDataCard({
    super.key,
    required this.orderId,
    required this.canTrackingRealtime,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
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
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                onPressed: onRetry,
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
