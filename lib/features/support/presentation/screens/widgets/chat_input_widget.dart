import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../../providers/chat_notifier.dart';

class ChatInputWidget extends ConsumerStatefulWidget {
  const ChatInputWidget({super.key});

  @override
  ConsumerState<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends ConsumerState<ChatInputWidget> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        await ref
            .read(chatNotifierProvider.notifier)
            .sendMediaMessage(image.path, MessageType.image);
      }
    } catch (e) {
      _showError('Không thể chọn ảnh');
    }
  }

  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 1),
      );

      if (video != null) {
        // Check file size (max 10MB)
        final file = File(video.path);
        final fileSize = await file.length();
        if (fileSize > 10 * 1024 * 1024) {
          _showError('Video không được quá 10MB');
          return;
        }

        await ref
            .read(chatNotifierProvider.notifier)
            .sendMediaMessage(video.path, MessageType.video);
      }
    } catch (e) {
      _showError('Không thể chọn video');
    }
  }

  void _showMediaOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 24.h),
              _buildMediaOption(
                icon: Icons.image,
                label: 'Ảnh',
                color: Colors.blue,
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              SizedBox(height: 16.h),
              _buildMediaOption(
                icon: Icons.videocam,
                label: 'Video',
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  _pickVideo();
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(icon, color: color, size: 24.w),
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    ref.read(chatNotifierProvider.notifier).sendTextMessage(text);
    _textController.clear();
    _focusNode.requestFocus();
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatNotifierProvider);
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              // Attach button
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: theme.primaryColor,
                  size: 28.w,
                ),
                onPressed: chatState.isSendingMessage
                    ? null
                    : _showMediaOptions,
              ),

              // Text input
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    enabled: !chatState.isSendingMessage,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      hintStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey.shade500,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                    style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // Send button
              GestureDetector(
                onTap: chatState.isSendingMessage ? null : _sendMessage,
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: chatState.isSendingMessage
                      ? Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(Icons.send, color: Colors.white, size: 20.w),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
