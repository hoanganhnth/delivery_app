import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coordinator = ref.watch(supportCoordinatorProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Trung tâm Hỗ trợ & CSKH',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2C3E50),
      ),
      body: FutureBuilder<SupportState>(
        future: coordinator.load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final state = snapshot.data;
          final isOpen = state?.status == SupportStatus.open;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 24/7 Hotline Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00A38C), Color(0xFF007A68)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00A38C).withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.headset_mic_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hotline CSKH 24/7',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '1900 1234 (Miễn phí cuộc gọi)',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Đang kết nối tới tổng đài 1900 1234...'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF00A38C),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Gọi ngay',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Live Chat Status / Messages Card
                const Text(
                  'Hỗ trợ trực tuyến',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: isOpen
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: state!.messages
                                    .map(
                                      (message) => Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF1F3F5),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          message.body,
                                          style: const TextStyle(fontSize: 14),
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
                                      controller: _messageController,
                                      decoration: const InputDecoration(
                                        hintText: 'Nhập tin nhắn hỗ trợ...',
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 12),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.send_rounded,
                                      color: Color(0xFF00A38C),
                                    ),
                                    onPressed: () {
                                      _messageController.clear();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.support_agent_outlined,
                                  size: 44,
                                  color: Color(0xFF95A5A6),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Support unavailable',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Please try again later.',
                                  style: TextStyle(
                                    color: Color(0xFF7F8C8D),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),

                const SizedBox(height: 24),

                // Common FAQs
                const Text(
                  'Câu hỏi thường gặp (FAQ)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 10),

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
                  question: 'Chính sách hoàn tiền khi hủy đơn hàng như thế nào?',
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAECEF)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: _expanded,
          onExpansionChanged: (val) => setState(() => _expanded = val),
          title: Text(
            widget.question,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: Text(
                widget.answer,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF555555),
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
