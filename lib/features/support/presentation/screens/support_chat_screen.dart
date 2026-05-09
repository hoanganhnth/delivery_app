import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:delivery_app/generated/l10n.dart';
import '../../../profile/presentation/providers/providers.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../providers/providers.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input_bar.dart';

import 'widgets/support_chat_app_bar.dart';
import 'widgets/support_closed_banner.dart';
import 'widgets/support_empty_state.dart';

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
    final s = S.of(context);
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
      _showErrorSnackbar(s.supportAttachmentError);
    }
  }

  Future<void> _handleAttachVideo() async {
    final s = S.of(context);
    try {
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 1),
      );

      if (video != null) {
        final file = File(video.path);
        final fileSize = await file.length();
        if (fileSize > 10 * 1024 * 1024) {
          _showErrorSnackbar(s.supportVideoSizeError);
          return;
        }

        await ref
            .read(chatProvider.notifier)
            .sendMediaMessage(video.path, MessageType.video);
        _scrollToBottom();
      }
    } catch (e) {
      _showErrorSnackbar(s.supportAttachmentError);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
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
    final s = S.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        title: Text(
          s.supportEndConfirmationTitle,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Text(s.supportEndConfirmationDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              s.supportCancel,
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
            child: Text(s.supportEnd),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(chatProvider.notifier).closeConversation();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s.supportConversationEnded),
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
    final s = S.of(context);
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
            content: Text(s.supportNewConversationStarted),
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
            SupportChatAppBar(
              theme: theme,
              conversation: chatState.conversation,
              onCloseConversation: _showCloseConfirmationDialog,
              onNewConversation: _startNewConversation,
            ),

            if (chatState.conversation?.isClosed == true)
              SupportClosedBanner(
                theme: theme,
                closeReason: chatState.conversation!.closeReason,
                onNewConversation: _startNewConversation,
              ),

            Expanded(
              child: chatState.isLoading
                  ? _buildLoadingState(theme)
                  : chatState.hasError
                      ? _buildErrorState(theme, chatState)
                      : _buildMessageList(theme, chatState),
            ),

            if (chatState.hasConversation && chatState.conversation!.isActive)
              ChatInputBar(
                onSendMessage: _handleSendMessage,
                onAttachImage: _handleAttachImage,
                onAttachVideo: _handleAttachVideo,
              ),

            if (chatState.hasConversation && chatState.conversation!.isClosed)
              _buildClosedFooter(theme),
          ],
        ),
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
    final s = S.of(context);
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
              chatState.errorMessage ?? s.supportErrorTitle,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            FilledButton.icon(
              onPressed: _initializeChat,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(s.supportRetry),
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
      return SupportEmptyState(theme: theme);
    }

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: chatState.isLoadingMore ? messages.length + 1 : messages.length,
      itemBuilder: (context, index) {
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

        final showDateDivider = messageIndex == messages.length - 1 ||
            !_isSameDay(
              message.timestamp,
              messages[messageIndex + 1].timestamp,
            );

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

  Widget _buildClosedFooter(ThemeData theme) {
    final s = S.of(context);
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
                s.supportFooterClosed,
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

