import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/livestream_entity.dart';

class LivestreamBottomControls extends StatelessWidget {
  final LivestreamEntity livestream;
  final int likeCount;
  final TextEditingController commentController;
  final VoidCallback onSendComment;
  final VoidCallback onSendLike;
  final VoidCallback onShowProducts;

  const LivestreamBottomControls({
    super.key,
    required this.livestream,
    required this.likeCount,
    required this.commentController,
    required this.onSendComment,
    required this.onSendLike,
    required this.onShowProducts,
  });

  String _formatCount(int count) {
    if (count >= 1000000) {
      final value = (count / 1000000).toStringAsFixed(1);
      return value.endsWith('.0') ? '${count ~/ 1000000}M' : '${value}M';
    } else if (count >= 1000) {
      final value = (count / 1000).toStringAsFixed(1);
      return value.endsWith('.0') ? '${count ~/ 1000}K' : '${value}K';
    }
    return count.toString();
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required int count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22.sp),
            SizedBox(width: 6.w),
            Text(
              _formatCount(count),
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(28.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Comment input
              Expanded(
                child: Container(
                  height: 44.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Viết bình luận...',
                            hintStyle: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onSubmitted: (_) => onSendComment(),
                        ),
                      ),
                      GestureDetector(
                        onTap: onSendComment,
                        child: Icon(
                          Icons.send_rounded,
                          color: theme.colorScheme.primary,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Like button
              _buildControlButton(
                icon: Icons.favorite_rounded,
                color: Colors.red,
                count: likeCount,
                onTap: onSendLike,
              ),

              // Products button
              if (livestream.products != null && livestream.products!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: _buildControlButton(
                    icon: Icons.shopping_bag_rounded,
                    color: theme.colorScheme.primary,
                    count: livestream.products!.length,
                    onTap: onShowProducts,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
