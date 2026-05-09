import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/generated/l10n.dart';

class SupportEmptyState extends StatelessWidget {
  final ThemeData theme;

  const SupportEmptyState({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 48.sp,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              s.supportWelcome,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              s.supportWelcomeDesc,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
