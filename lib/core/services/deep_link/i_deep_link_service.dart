import 'package:go_router/go_router.dart';

abstract class IDeepLinkService {
  /// Initialize deep link handling
  Future<void> initialize(GoRouter router);
  
  /// Get and clear pending route
  String? getPendingRoute();

  /// Generate deep link for sharing
  String generateDeepLink({
    required String baseUrl,
    required String path,
    Map<String, String>? params,
  });

  /// Generate restaurant deep link
  String generateRestaurantLink(String baseUrl, String restaurantId);

  /// Generate order deep link
  String generateOrderLink(String baseUrl, String orderId);

  /// Generate order tracking deep link
  String generateTrackingLink(String baseUrl, String orderId);

  /// Generate promo deep link
  String generatePromoLink(String baseUrl, String promoCode);
}
