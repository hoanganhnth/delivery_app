import 'package:delivery_app/core/services/share/i_share_service.dart';

/// Extension on IShareService for order-specific sharing.
/// Lives in Feature layer — keeps Core domain-agnostic.
extension OrderShareX on IShareService {
  /// Share an order link
  Future<void> shareOrder({
    required String orderId,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/order?id=$orderId';
    final message = 'Track my order #$orderId';

    await shareLink(url: url, message: message);
  }

  /// Share order tracking link
  Future<void> shareOrderTracking({
    required String orderId,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/track?order_id=$orderId';
    final message = 'Track this order in real-time';

    await shareLink(url: url, message: message);
  }
}
