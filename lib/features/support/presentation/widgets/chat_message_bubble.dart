import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/chat_message_entity.dart';

/// Chat Message Bubble - Stitch Editorial Style
/// Features:
/// - Rounded corners với tail (rounded-tl-none hoặc rounded-tr-none)
/// - Subtle gradient background
/// - Avatar với status indicator
/// - Timestamp inline
class ChatMessageBubble extends StatelessWidget {
  final ChatMessageEntity message;
  final bool showAvatar;
  final VoidCallback? onImageTap;
  final VoidCallback? onVideoTap;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.showAvatar = true,
    this.onImageTap,
    this.onVideoTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isFromUser;

    return Padding(
      padding: EdgeInsets.only(
        left: isUser ? 48.w : 0,
        right: isUser ? 0 : 48.w,
        bottom: 4.h,
      ),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Support avatar (left side)
          if (!isUser && showAvatar) ...[
            _buildSupportAvatar(theme),
            SizedBox(width: 8.w),
          ] else if (!isUser) ...[
            SizedBox(width: 40.w), // Placeholder for alignment
          ],

          // Message bubble
          Flexible(
            child: _buildBubble(context, theme, isUser),
          ),

          // User avatar (right side) - optional
          if (isUser && showAvatar) ...[
            SizedBox(width: 8.w),
            _buildUserAvatar(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildSupportAvatar(ThemeData theme) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
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
        size: 18.sp,
        color: Colors.white,
      ),
    );
  }

  Widget _buildUserAvatar(ThemeData theme) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        Icons.person_rounded,
        size: 18.sp,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildBubble(BuildContext context, ThemeData theme, bool isUser) {
    return Container(
      constraints: BoxConstraints(maxWidth: 280.w),
      decoration: BoxDecoration(
        // User: Primary gradient, Support: Surface color
        gradient: isUser
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withValues(alpha: 0.85),
                ],
              )
            : null,
        color: isUser ? null : theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
          // Tail effect: flatten corner on sender side
          bottomLeft: Radius.circular(isUser ? 20.r : 4.r),
          bottomRight: Radius.circular(isUser ? 4.r : 20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: isUser
            ? null
            : Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                width: 1,
              ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
          bottomLeft: Radius.circular(isUser ? 20.r : 4.r),
          bottomRight: Radius.circular(isUser ? 4.r : 20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Media content
            if (message.type == MessageType.image) _buildImageContent(theme),
            if (message.type == MessageType.video) _buildVideoContent(theme),

            // Text content
            if (message.content.isNotEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 4.h),
                child: Text(
                  message.content,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: isUser
                        ? Colors.white
                        : theme.colorScheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ),

            // Timestamp + Status
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 10.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: isUser
                          ? Colors.white.withValues(alpha: 0.7)
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (isUser) ...[
                    SizedBox(width: 4.w),
                    _buildStatusIcon(theme),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContent(ThemeData theme) {
    if (message.mediaUrl == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: onImageTap,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 200.h,
          maxWidth: 280.w,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: CachedNetworkImage(
            imageUrl: message.mediaUrl!,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              height: 150.h,
              color: theme.colorScheme.surfaceContainerHighest,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            errorWidget: (_, __, ___) => Container(
              height: 100.h,
              color: theme.colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.broken_image_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoContent(ThemeData theme) {
    if (message.mediaUrl == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: onVideoTap,
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Thumbnail placeholder
            if (message.thumbnailUrl != null)
              CachedNetworkImage(
                imageUrl: message.thumbnailUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            // Play button
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(ThemeData theme) {
    // Simple read/unread status based on isRead
    final IconData icon;
    final Color color;

    if (message.isRead) {
      icon = Icons.done_all_rounded;
      color = Colors.lightBlueAccent;
    } else {
      icon = Icons.check_rounded;
      color = Colors.white.withValues(alpha: 0.7);
    }

    return Icon(icon, size: 14.sp, color: color);
  }

  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

/// Date Divider Pill - Editorial style
class ChatDateDivider extends StatelessWidget {
  final DateTime date;

  const ChatDateDivider({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          _formatDate(date),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Hôm nay';
    } else if (messageDate == yesterday) {
      return 'Hôm qua';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
