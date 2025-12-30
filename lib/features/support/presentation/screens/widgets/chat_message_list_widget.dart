import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../../providers/chat_notifier.dart';

class ChatMessageListWidget extends ConsumerStatefulWidget {
  const ChatMessageListWidget({super.key});

  @override
  ConsumerState<ChatMessageListWidget> createState() =>
      _ChatMessageListWidgetState();
}

class _ChatMessageListWidgetState extends ConsumerState<ChatMessageListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatNotifierProvider);
    final messages = chatState.messages;

    // Auto scroll to bottom when new message arrives
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && messages.isNotEmpty) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64.w,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 16.h),
            Text(
              'Chào mừng bạn đến với hỗ trợ khách hàng',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Hãy gửi tin nhắn để bắt đầu cuộc trò chuyện',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade400),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final showTimestamp =
            index == 0 ||
            messages[index - 1].timestamp
                    .difference(message.timestamp)
                    .inMinutes
                    .abs() >
                5;

        return Column(
          children: [
            if (showTimestamp) _buildTimestamp(message.timestamp),
            _buildMessageBubble(context, message),
            SizedBox(height: 8.h),
          ],
        );
      },
    );
  }

  Widget _buildTimestamp(DateTime timestamp) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(
        timeago.format(timestamp, locale: 'vi'),
        style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, ChatMessageEntity message) {
    final isUser = message.isFromUser;
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isUser) ...[
          CircleAvatar(
            radius: 16.w,
            backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
            child: Icon(
              Icons.support_agent,
              size: 18.w,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(width: 8.w),
        ],
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: 260.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isUser ? theme.primaryColor : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.r),
                topRight: Radius.circular(18.r),
                bottomLeft: Radius.circular(isUser ? 18.r : 4.r),
                bottomRight: Radius.circular(isUser ? 4.r : 18.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.type == MessageType.image)
                  _buildImageContent(message),
                if (message.type == MessageType.video)
                  _buildVideoContent(message),
                if (message.content.isNotEmpty)
                  Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: isUser ? Colors.white : Colors.black87,
                      height: 1.4,
                    ),
                  ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatTime(message.timestamp),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: isUser ? Colors.white70 : Colors.grey.shade500,
                      ),
                    ),
                    if (isUser) ...[
                      SizedBox(width: 4.w),
                      Icon(
                        message.isRead ? Icons.done_all : Icons.done,
                        size: 14.w,
                        color: message.isRead
                            ? Colors.blue.shade300
                            : Colors.white70,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isUser) SizedBox(width: 8.w),
      ],
    );
  }

  Widget _buildImageContent(ChatMessageEntity message) {
    if (message.mediaUrl == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: CachedNetworkImage(
          imageUrl: message.mediaUrl!,
          width: 200.w,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: 200.w,
            height: 150.h,
            color: Colors.grey.shade200,
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            width: 200.w,
            height: 150.h,
            color: Colors.grey.shade200,
            child: const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoContent(ChatMessageEntity message) {
    if (message.mediaUrl == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 200.w,
              height: 150.h,
              color: Colors.black,
              child: message.thumbnailUrl != null
                  ? CachedNetworkImage(
                      imageUrl: message.thumbnailUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.videocam, color: Colors.white, size: 48),
            ),
          ),
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
