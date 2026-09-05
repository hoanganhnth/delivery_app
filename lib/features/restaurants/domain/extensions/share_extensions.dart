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
    final message =
        'Khám phá quán ăn $restaurantName trên ứng dụng giao đồ ăn!';

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
    final message = 'Sử dụng mã khuyến mãi $promoCode để nhận $description';

    await shareLink(
      url: url,
      message: message,
      subject: 'Khuyến mãi: $promoCode',
    );
  }

  /// Share app download link
  Future<void> shareAppDownload({required String baseUrl}) async {
    await shareLink(
      url: baseUrl,
      message: 'Tải ngay ứng dụng giao đồ ăn!',
    );
  }
}
