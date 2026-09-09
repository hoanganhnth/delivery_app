import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/core/routing/routing.dart';

import '../application/support_coordinator.dart';
import '../di/support_providers.dart';
import '../domain/entities/support_conversation.dart';

class SupportPage extends ConsumerStatefulWidget {
  const SupportPage({super.key});

  @override
  ConsumerState<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends ConsumerState<SupportPage> {
  final TextEditingController _messageController = TextEditingController();
  late Future<SupportState> _stateFuture;
  bool _sending = false;
  String? _markedConversationId;

  @override
  void initState() {
    super.initState();
    _stateFuture = ref.read(supportCoordinatorProvider).load();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.main);
    }
  }

  Future<void> _send(String conversationId) async {
    final content = _messageController.text.trim();
    if (content.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      await ref
          .read(supportCoordinatorProvider)
          .sendTextMessage(conversationId, content);
      _messageController.clear();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _close(String conversationId) async {
    try {
      await ref
          .read(supportCoordinatorProvider)
          .closeConversation(
            conversationId,
            reason: 'Customer closed the support conversation',
          );
      if (!mounted) return;
      setState(() {
        _markedConversationId = null;
        _stateFuture = ref.read(supportCoordinatorProvider).load();
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  void _markReadIfNeeded(String conversationId, List<SupportMessage> messages) {
    final hasUnreadSupportMessage = messages.any(
      (message) =>
          message.sender == SupportMessageSender.support && !message.isRead,
    );
    if (!hasUnreadSupportMessage || _markedConversationId == conversationId) {
      return;
    }
    _markedConversationId = conversationId;
    unawaited(
      ref.read(supportCoordinatorProvider).markConversationRead(conversationId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreviewUi.canvas(context),
      appBar: PreviewPageHeader(
        title: 'Trung tâm Hỗ trợ & CSKH',
        onBack: _goBack,
        onCart: () => context.pushCart(),
      ),
      body: FutureBuilder<SupportState>(
        future: _stateFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final state = snapshot.data;
          final isOpen = state?.status == SupportStatus.open;

          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PreviewSurface(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    leading: const Icon(
                      Icons.headset_mic_outlined,
                      color: PreviewUi.accent,
                    ),
                    title: const Text('Liên hệ CSKH'),
                    subtitle: Text(
                      'Đội ngũ CSKH đang trực tuyến và sẽ phản hồi sớm.',
                      style: TextStyle(
                        color: PreviewUi.lightMuted,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 10),
                  child: Text(
                    'Hỗ trợ trực tuyến',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),

                PreviewSurface(
                  padding: EdgeInsets.zero,
                  child: isOpen
                      ? _SupportChatPanel(
                          conversationId: state!.conversationId,
                          initialMessages: state.messages,
                          messageController: _messageController,
                          sending: _sending,
                          onSend: () {
                            final id = state.conversationId;
                            if (id != null) unawaited(_send(id));
                          },
                          onSubmit: () {
                            final id = state.conversationId;
                            if (id != null) unawaited(_send(id));
                          },
                          onClose: () {
                            final id = state.conversationId;
                            if (id != null) unawaited(_close(id));
                          },
                          stream: state.conversationId == null
                              ? const Stream.empty()
                              : ref
                                    .read(supportCoordinatorProvider)
                                    .watchMessages(state.conversationId!),
                          onMessages: (messages) {
                            final id = state.conversationId;
                            if (id != null) _markReadIfNeeded(id, messages);
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 28,
                            horizontal: 20,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.support_agent_outlined,
                                  size: 44,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  state?.status == SupportStatus.closed
                                      ? 'Cuộc trò chuyện đã đóng'
                                      : 'Support unavailable',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  state?.status == SupportStatus.closed
                                      ? 'Mở lại Trung tâm Hỗ trợ để bắt đầu cuộc trò chuyện mới.'
                                      : 'Please try again later.',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),

                // Common FAQs
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 10),
                  child: Text(
                    'Câu hỏi thường gặp (FAQ)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),

                _FaqAccordion(
                  question: 'Làm thế nào để áp dụng mã giảm giá và Freeship?',
                  answer:
                      'Tại bước Thanh toán (Checkout), bạn có thể chọn hoặc nhập mã tại mục "Ví Voucher & Ưu đãi". Hệ thống hỗ trợ cộng dồn ưu đãi Freeship cùng với Voucher quán ăn.',
                ),
                _FaqAccordion(
                  question: 'Thời gian giao hàng dự kiến là bao lâu?',
                  answer:
                      'Thời gian giao hàng trung bình từ 15 - 30 phút tùy thuộc vào khoảng cách quán ăn đến địa chỉ của bạn và điều kiện thời tiết.',
                ),
                _FaqAccordion(
                  question:
                      'Chính sách hoàn tiền khi hủy đơn hàng như thế nào?',
                  answer:
                      'Nếu đơn hàng bị hủy khi quán chưa chuẩn bị, số tiền thanh toán qua thẻ hoặc ví điện tử sẽ được hoàn lại tự động trong vòng 1 - 3 ngày làm việc.',
                ),
                _FaqAccordion(
                  question: 'Tôi muốn thay đổi địa chỉ nhận món sau khi đặt?',
                  answer:
                      'Vui lòng gọi ngay cho tài xế qua nút "Liên hệ tài xế" trên màn hình theo dõi đơn hoặc liên hệ Hotline 1900 1234 để điều phối viên hỗ trợ.',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SupportChatPanel extends StatelessWidget {
  const _SupportChatPanel({
    required this.conversationId,
    required this.initialMessages,
    required this.messageController,
    required this.sending,
    required this.onSend,
    required this.onSubmit,
    required this.onClose,
    required this.stream,
    required this.onMessages,
  });

  final String? conversationId;
  final List<SupportMessage> initialMessages;
  final TextEditingController messageController;
  final bool sending;
  final VoidCallback onSend;
  final VoidCallback onSubmit;
  final VoidCallback onClose;
  final Stream<List<SupportMessage>> stream;
  final ValueChanged<List<SupportMessage>> onMessages;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SupportMessage>>(
      stream: stream,
      initialData: initialMessages,
      builder: (context, snapshot) {
        final messages = snapshot.data ?? initialMessages;
        if (messages.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onMessages(messages);
          });
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Trao đổi với CSKH',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Đóng cuộc trò chuyện',
                    onPressed: conversationId == null || sending
                        ? null
                        : onClose,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            if (snapshot.connectionState == ConnectionState.waiting &&
                messages.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: CircularProgressIndicator(),
              )
            else if (snapshot.hasError)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: Text(
                  'Không thể đồng bộ tin nhắn realtime. Vui lòng thử lại.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 13,
                  ),
                ),
              )
            else if (messages.isEmpty)
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: Text(
                  'Hãy mô tả vấn đề của bạn, CSKH sẽ phản hồi tại đây.',
                  style: TextStyle(fontSize: 13),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  children: messages
                      .map(
                        (message) => Align(
                          alignment:
                              message.sender == SupportMessageSender.customer
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  message.sender ==
                                      SupportMessageSender.customer
                                  ? PreviewUi.accent
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                              borderRadius: PreviewUi.controlRadius,
                            ),
                            child: Text(
                              message.body,
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    message.sender ==
                                        SupportMessageSender.customer
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      enabled: conversationId != null && !sending,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => onSubmit(),
                      maxLength: 2000,
                      decoration: const InputDecoration(
                        hintText: 'Nhập tin nhắn...',
                        counterText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: sending
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            Icons.send_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    tooltip: 'Gửi tin nhắn',
                    onPressed: conversationId == null || sending
                        ? null
                        : onSend,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FaqAccordion extends StatefulWidget {
  const _FaqAccordion({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  State<_FaqAccordion> createState() => _FaqAccordionState();
}

class _FaqAccordionState extends State<_FaqAccordion> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: const Border(bottom: BorderSide(color: PreviewUi.line)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: _expanded,
          onExpansionChanged: (val) => setState(() => _expanded = val),
          title: Text(
            widget.question,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          childrenPadding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: Text(
                widget.answer,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
