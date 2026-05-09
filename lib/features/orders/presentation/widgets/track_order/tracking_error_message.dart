import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TrackingErrorMessage extends StatelessWidget {
  final String error;
  final VoidCallback onClear;

  const TrackingErrorMessage({
    super.key,
    required this.error,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              error,
              style: TextStyle(color: Colors.red.shade800, fontSize: 14.sp),
            ),
          ),
          IconButton(
            onPressed: onClear,
            icon: Icon(Icons.close, color: Colors.red.shade600, size: 20),
          ),
        ],
      ),
    );
  }
}
