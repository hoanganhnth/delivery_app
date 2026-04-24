/// Core interface for sharing content.
/// Domain-agnostic: only accepts primitive types (String, Map).
/// Reusable across any app without modification.
abstract class IShareService {
  /// Share plain text content
  Future<void> shareText({
    required String text,
    String? subject,
  });

  /// Share a link with optional message
  Future<void> shareLink({
    required String url,
    String? message,
    String? subject,
  });

  /// Generate QR data string from content
  String generateQRData({required String content});
}
