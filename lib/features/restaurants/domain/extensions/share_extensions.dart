import 'package:delivery_app/core/services/share/i_share_service.dart';

/// Extension on IShareService for restaurant-specific sharing.
/// Lives in Feature layer — keeps Core domain-agnostic.
extension RestaurantShareX on IShareService {
  /// Share a restaurant with a deep link
  Future<void> shareRestaurant({
    required String restaurantId,
    required String restaurantName,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/restaurant?id=$restaurantId';
    final message = 'Check out $restaurantName on our delivery app!';

    await shareLink(
      url: url,
      message: message,
      subject: restaurantName,
    );
  }

  /// Share a promo code
  Future<void> sharePromo({
    required String promoCode,
    required String description,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/promo?code=$promoCode';
    final message = 'Use promo code $promoCode for $description';

    await shareLink(
      url: url,
      message: message,
      subject: 'Promo: $promoCode',
    );
  }

  /// Share app download link
  Future<void> shareAppDownload({required String baseUrl}) async {
    await shareLink(
      url: baseUrl,
      message: 'Download our delivery app!',
    );
  }
}
