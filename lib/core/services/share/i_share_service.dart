abstract class IShareService {
  /// Share a restaurant
  Future<void> shareRestaurant(String restaurantId, String restaurantName);
  
  /// Share an order
  Future<void> shareOrder(String orderId);
  
  /// Share order tracking
  Future<void> shareOrderTracking(String orderId);
  
  /// Share a promo code
  Future<void> sharePromo(String promoCode, String description);
  
  /// Share app download link
  Future<void> shareApp();
  
  /// Share custom content with deep link
  Future<void> shareCustom({
    required String path,
    required String message,
    Map<String, String>? params,
  });

  /// Generate QR code data for sharing
  String generateQRData({
    required String path,
    Map<String, String>? params,
  });
}
