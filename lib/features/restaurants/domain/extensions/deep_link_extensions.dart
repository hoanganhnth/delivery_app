import 'package:delivery_app/core/services/deep_link/i_deep_link_service.dart';

/// Extension on IDeepLinkService for restaurant-specific deep links.
/// Lives in Feature layer — keeps Core domain-agnostic.
extension RestaurantDeepLinkX on IDeepLinkService {
  /// Generate a restaurant detail deep link
  String generateRestaurantLink(String baseUrl, String restaurantId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/restaurant',
      params: {'id': restaurantId},
    );
  }

  /// Generate a restaurant menu deep link
  String generateMenuLink(String baseUrl, String restaurantId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/menu',
      params: {'restaurant_id': restaurantId},
    );
  }

  /// Generate a promo deep link
  String generatePromoLink(String baseUrl, String promoCode) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/promo',
      params: {'code': promoCode},
    );
  }
}
