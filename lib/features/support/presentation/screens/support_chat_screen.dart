import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../profile/presentation/providers/providers.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../providers/providers.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input_bar.dart';

/// Support Chat Screen - Stitch Editorial Redesign
/// Features:
/// - Editorial header với gradient
/// - Message bubbles với tail effect
/// - Date divider pills
/// - Typing indicator
/// - Rounded-full input bar
class SupportChatScreen extends ConsumerStatefulWidget {
  const SupportChatScreen({super.key});

  @override
  ConsumerState<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends ConsumerState<SupportChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeChat();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeChat() {
    final profileState = ref.read(profileProvider);
    if (profileState.hasUser) {
      final user = profileState.user!;
      ref
          .read(chatProvider.notifier)
          .initializeChat(user.id ?? user.authId, user.email, user.fullName);
    }
  }

  void _onScroll() {
    final chatState = ref.read(chatProvider);

    // Load more when scroll to top (reverse list)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (chatState.hasMoreMessages && !chatState.isLoadingMore) {
        ref.read(chatProvider.notifier).loadMoreMessages();
      }
    }
  }

  Future<void> _handleSendMessage(String message) async {
    await ref.read(chatProvider.notifier).sendTextMessage(message);
    _scrollToBottom();
  }

  Future<void> _handleAttachImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        await ref
            .read(chatProvider.notifier)
            .sendMediaMessage(image.path, MessageType.image);
        _scrollToBottom();
      }
    } catch (e) {
      _showErrorSnackbar('Không thể chọn ảnh');
    }
  }

  Future<void> _handleAttachVideo() async {
    try {
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 1),
      );

      if (video != null) {
        final file = File(video.path);
        final fileSize = await file.length();
        if (fileSize > 10 * 1024 * 1024) {
          _showErrorSnackbar('Video không được quá 10MB');
          return;
        }

        await ref
            .read(chatProvider.notifier)
            .sendMediaMessage(video.path, MessageType.video);
        _scrollToBottom();
      }
    } catch (e) {
      _showErrorSnackbar('Không thể chọn video');
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0, // Reverse list: 0 is bottom
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showErrorSnackbar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _showCloseConfirmationDialog() async {
    final theme = Theme.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        title: Text(
          'Kết thúc hội thoại',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Bạn có chắc muốn kết thúc hội thoại này? Bạn có thể bắt đầu hội thoại mới bất kỳ lúc nào.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Hủy',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: const Text('Kết thúc'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(chatProvider.notifier).closeConversation();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Đã kết thúc hội thoại'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  Future<void> _startNewConversation() async {
    final profileState = ref.read(profileProvider);
    if (profileState.hasUser) {
      final user = profileState.user!;
      await ref.read(chatProvider.notifier).startNewConversation(
            user.id ?? user.authId,
            user.email,
            user.fullName,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Đã bắt đầu hội thoại mới'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            _buildAppBar(context, theme, chatState),

            // Closed conversation banner
            if (chatState.conversation?.isClosed == true)
              _buildClosedBanner(theme, chatState),

            // Messages
            Expanded(
              child: chatState.isLoading
                  ? _buildLoadingState(theme)
                  : chatState.hasError
                      ? _buildErrorState(theme, chatState)
                      : _buildMessageList(theme, chatState),
            ),

            // Input bar
            if (chatState.hasConversation && chatState.conversation!.isActive)
              ChatInputBar(
                onSendMessage: _handleSendMessage,
                onAttachImage: _handleAttachImage,
                onAttachVideo: _handleAttachVideo,
              ),

            // Closed conversation footer
            if (chatState.hasConversation && chatState.conversation!.isClosed)
              _buildClosedFooter(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ThemeData theme, dynamic chatState) {
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
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
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
                  'Hỗ trợ khách hàng',
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
                      'Đang hoạt động',
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
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
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
                _showCloseConfirmationDialog();
              } else if (value == 'new') {
                _startNewConversation();
              }
            },
            itemBuilder: (context) {
              final conversation = chatState.conversation;

              if (conversation != null && conversation.isActive) {
                return [
                  PopupMenuItem(
                    value: 'close',
                    child: Row(
                      children: [
                        Icon(Icons.close_rounded, color: theme.colorScheme.error),
                        SizedBox(width: 12.w),
                        const Text('Kết thúc hội thoại'),
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
                        const Text('Bắt đầu hội thoại mới'),
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

  Widget _buildClosedBanner(ThemeData theme, dynamic chatState) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.error.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: theme.colorScheme.error,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hội thoại đã kết thúc',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.error,
                  ),
                ),
                if (chatState.conversation?.closeReason != null)
                  Text(
                    chatState.conversation!.closeReason!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: _startNewConversation,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Tạo mới',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: CircularProgressIndicator(
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, dynamic chatState) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 40.sp,
                color: theme.colorScheme.error,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              chatState.errorMessage ?? 'Đã xảy ra lỗi',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            FilledButton.icon(
              onPressed: _initializeChat,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Thử lại'),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(ThemeData theme, dynamic chatState) {
    final messages = chatState.messages as List<ChatMessageEntity>;

    if (messages.isEmpty) {
      return _buildEmptyState(theme);
    }

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: chatState.isLoadingMore ? messages.length + 1 : messages.length,
      itemBuilder: (context, index) {
        // Loading indicator at top (reverse list)
        if (index == messages.length && chatState.isLoadingMore) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            ),
          );
        }

        final messageIndex = messages.length - 1 - index;
        final message = messages[messageIndex];

        // Check if should show date divider
        final showDateDivider = messageIndex == messages.length - 1 ||
            !_isSameDay(
              message.timestamp,
              messages[messageIndex + 1].timestamp,
            );

        // Check if should show avatar (last message in group)
        final showAvatar = index == 0 ||
            messages[messages.length - index].isFromUser != message.isFromUser;

        return Column(
          children: [
            if (showDateDivider) ChatDateDivider(date: message.timestamp),
            ChatMessageBubble(
              message: message,
              showAvatar: showAvatar,
            ),
            SizedBox(height: 4.h),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
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
              'Chào mừng bạn!',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Gửi tin nhắn để bắt đầu cuộc trò chuyện\nvới đội ngũ hỗ trợ',
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

  Widget _buildClosedFooter(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Icon(
              Icons.lock_outline_rounded,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Hội thoại đã kết thúc. Nhấn menu để tạo mới.',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
