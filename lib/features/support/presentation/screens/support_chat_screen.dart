import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: chatState.isLoading
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

          // Input area
          if (chatState.hasConversation) const ChatInputWidget(),
        ],
      ),
    );
  }
}
