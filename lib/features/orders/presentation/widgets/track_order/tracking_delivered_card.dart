import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/generated/l10n.dart';

class TrackingDeliveredCard extends StatelessWidget {
  const TrackingDeliveredCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green.withValues(alpha: 0.05),
        ),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 64,
              color: Colors.green[600],
            ),
            SizedBox(height: 12.w),
            Text(
              S.of(context).deliveredSuccess,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 4.w),
            Text(
              S.of(context).deliveredSuccessMessage,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
