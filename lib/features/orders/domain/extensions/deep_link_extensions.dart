import 'package:delivery_app/core/services/deep_link/i_deep_link_service.dart';

/// Extension on IDeepLinkService for order-specific deep links.
/// Lives in Feature layer — keeps Core domain-agnostic.
extension OrderDeepLinkX on IDeepLinkService {
  /// Generate an order detail deep link
  String generateOrderLink(String baseUrl, String orderId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/order',
      params: {'id': orderId},
    );
  }

  /// Generate an order tracking deep link
  String generateTrackingLink(String baseUrl, String orderId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/track',
      params: {'order_id': orderId},
    );
  }
}
