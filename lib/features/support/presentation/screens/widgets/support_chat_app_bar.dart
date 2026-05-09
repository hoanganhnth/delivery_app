import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/generated/l10n.dart';

class SupportChatAppBar extends StatelessWidget {
  final ThemeData theme;
  final dynamic conversation;
  final VoidCallback onCloseConversation;
  final VoidCallback onNewConversation;

  const SupportChatAppBar({
    super.key,
    required this.theme,
    required this.conversation,
    required this.onCloseConversation,
    required this.onNewConversation,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Support avatar
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.support_agent_rounded,
              size: 24.sp,
              color: Colors.white,
            ),
          ),

          SizedBox(width: 12.w),

          // Title & status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.supportChatTitle,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      s.supportStatusActive,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Menu button
          PopupMenuButton<String>(
            icon: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                Icons.more_vert_rounded,
                size: 20.sp,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            onSelected: (value) {
              if (value == 'close') {
                onCloseConversation();
              } else if (value == 'new') {
                onNewConversation();
              }
            },
            itemBuilder: (context) {
              if (conversation != null && conversation.isActive) {
                return [
                  PopupMenuItem(
                    value: 'close',
                    child: Row(
                      children: [
                        Icon(Icons.close_rounded, color: theme.colorScheme.error),
                        SizedBox(width: 12.w),
                        Text(s.supportEndConversation),
                      ],
                    ),
                  ),
                ];
              }

              if (conversation != null && conversation.isClosed) {
                return [
                  PopupMenuItem(
                    value: 'new',
                    child: Row(
                      children: [
                        Icon(Icons.add_comment_rounded, color: Colors.green),
                        SizedBox(width: 12.w),
                        Text(s.supportNewConversation),
                      ],
                    ),
                  ),
                ];
              }

              return [];
            },
          ),
        ],
      ),
    );
  }
}
