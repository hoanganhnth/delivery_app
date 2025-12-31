import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../profile/presentation/providers/profile_providers.dart';
import '../providers/chat_notifier.dart';
import 'widgets/chat_input_widget.dart';
import 'widgets/chat_message_list_widget.dart';

/// Support Chat Screen - giao diện đẹp như Grab/Shopee
class SupportChatScreen extends ConsumerStatefulWidget {
  const SupportChatScreen({super.key});

  @override
  ConsumerState<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends ConsumerState<SupportChatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeChat();
    });
  }

  void _initializeChat() {
    final profileState = ref.read(profileStateProvider);
    if (profileState.hasUser) {
      final user = profileState.user!;
      ref
          .read(chatNotifierProvider.notifier)
          .initializeChat(user.id ?? user.authId, user.email, user.fullName);
    }
  }

  // ✅ Hiển thị dialog xác nhận đóng conversation
  Future<void> _showCloseConfirmationDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Kết thúc hội thoại'),
            content: const Text(
              'Bạn có chắc muốn kết thúc hội thoại này? Bạn có thể bắt đầu hội thoại mới bất kỳ lúc nào.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.error,
                ),
                child: const Text('Kết thúc'),
              ),
            ],
          ),
    );

    if (confirmed == true && mounted) {
      await ref.read(chatNotifierProvider.notifier).closeConversation();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Đã kết thúc hội thoại'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  // ✅ Bắt đầu conversation mới
  Future<void> _startNewConversation() async {
    final profileState = ref.read(profileStateProvider);
    if (profileState.hasUser) {
      final user = profileState.user!;
      await ref
          .read(chatNotifierProvider.notifier)
          .startNewConversation(
            user.id ?? user.authId,
            user.email,
            user.fullName,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã bắt đầu hội thoại mới'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.primaryColor),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Icon(
                Icons.support_agent,
                color: theme.primaryColor,
                size: 24.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hỗ trợ khách hàng',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Chúng tôi luôn sẵn sàng hỗ trợ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.green,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // ✅ Menu actions: Đóng conversation hoặc bắt đầu mới
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onSelected: (value) {
              if (value == 'close') {
                _showCloseConfirmationDialog();
              } else if (value == 'new') {
                _startNewConversation();
              }
            },
            itemBuilder: (context) {
              final conversation = chatState.conversation;

              // Nếu conversation đang active, cho phép đóng
              if (conversation != null && conversation.isActive) {
                return [
                  const PopupMenuItem(
                    value: 'close',
                    child: Row(
                      children: [
                        Icon(Icons.close, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Kết thúc hội thoại'),
                      ],
                    ),
                  ),
                ];
              }

              // Nếu conversation đã đóng, cho phép tạo mới
              if (conversation != null && conversation.isClosed) {
                return [
                  const PopupMenuItem(
                    value: 'new',
                    child: Row(
                      children: [
                        Icon(Icons.add_comment, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Bắt đầu hội thoại mới'),
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
      body: Column(
        children: [
          // ✅ Banner hiển thị khi conversation đã đóng
          if (chatState.conversation?.isClosed == true)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: context.colors.warning.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(
                    color: context.colors.warning.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: context.colors.warning,
                    size: 20.w,
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
                            color: context.colors.warning,
                          ),
                        ),
                        if (chatState.conversation?.closeReason != null)
                          Text(
                            chatState.conversation!.closeReason!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: context.colors.onSurface.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _startNewConversation,
                    icon: const Icon(Icons.add_comment, size: 16),
                    label: const Text('Tạo mới'),
                    style: TextButton.styleFrom(
                      foregroundColor: context.colors.primary,
                    ),
                  ),
                ],
              ),
            ),

          // Messages list
          Expanded(
            child:
                chatState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : chatState.hasError
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64.w,
                            color: Colors.red.shade300,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            chatState.errorMessage ?? 'Đã xảy ra lỗi',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: _initializeChat,
                            child: const Text('Thử lại'),
                          ),
                        ],
                      ),
                    )
                    : const ChatMessageListWidget(),
          ),

          // ✅ Input area - chỉ hiển thị khi conversation đang active
          if (chatState.hasConversation && chatState.conversation!.isActive)
            const ChatInputWidget(),

          // ✅ Thông báo khi conversation đã đóng
          if (chatState.hasConversation && chatState.conversation!.isClosed)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: context.colors.onSurface.withValues(alpha: 0.5),
                    size: 20.w,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Hội thoại đã kết thúc. Nhấn nút menu để bắt đầu hội thoại mới.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: context.colors.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
