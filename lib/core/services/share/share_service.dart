import 'package:flutter/services.dart';
import 'i_share_service.dart';

/// Core implementation of IShareService.
/// Domain-agnostic: handles only the technical act of sharing.
class ShareService implements IShareService {
  ShareService();

  @override
  Future<void> shareText({required String text, String? subject}) async {
    try {
      // TODO: Replace with share_plus when ready
      await Clipboard.setData(ClipboardData(text: text));
    } catch (e) {
      throw Exception('Failed to share text: $e');
    }
  }

  @override
  Future<void> shareLink({
    required String url,
    String? message,
    String? subject,
  }) async {
    try {
      final String content = message != null ? '$message\n$url' : url;
      await Clipboard.setData(ClipboardData(text: content));
    } catch (e) {
      throw Exception('Failed to share link: $e');
    }
  }

  @override
  String generateQRData({required String content}) {
    return content;
  }
}
