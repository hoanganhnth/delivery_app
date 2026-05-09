import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/generated/l10n.dart';

class TrackingConnectionStatusBadge extends StatelessWidget {
  final bool isConnected;
  final bool isLoading;

  const TrackingConnectionStatusBadge({
    super.key,
    required this.isConnected,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = isConnected ? Colors.green : Colors.red;
    String statusText = isConnected ? S.of(context).connected : S.of(context).disconnected;
    IconData statusIcon = isConnected ? Icons.wifi : Icons.wifi_off;

    if (isLoading) {
      statusColor = Colors.orange;
      statusText = S.of(context).connecting;
      statusIcon = Icons.sync;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 14),
          SizedBox(width: 4.w),
          Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
