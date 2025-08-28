import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'deep_link_service.dart';
import '../routing/router_config.dart';

/// Service for sharing content with deep links
class ShareService {
  final String baseUrl;
  
  ShareService(this.baseUrl);
  
  /// Share a restaurant
  Future<void> shareRestaurant(String restaurantId, String restaurantName) async {
    final link = DeepLinkService.generateRestaurantLink(baseUrl, restaurantId);
    final text = 'Check out $restaurantName on our delivery app: $link';
    
    await _shareContent(text);
  }
  
  /// Share an order
  Future<void> shareOrder(String orderId) async {
    final link = DeepLinkService.generateOrderLink(baseUrl, orderId);
    final text = 'Track my order: $link';
    
    await _shareContent(text);
  }
  
  /// Share order tracking
  Future<void> shareOrderTracking(String orderId) async {
    final link = DeepLinkService.generateTrackingLink(baseUrl, orderId);
    final text = 'Track this order in real-time: $link';
    
    await _shareContent(text);
  }
  
  /// Share a promo code
  Future<void> sharePromo(String promoCode, String description) async {
    final link = DeepLinkService.generatePromoLink(baseUrl, promoCode);
    final text = 'Use promo code $promoCode for $description: $link';
    
    await _shareContent(text);
  }
  
  /// Share app download link
  Future<void> shareApp() async {
    final text = 'Download our delivery app: $baseUrl';
    await _shareContent(text);
  }
  
  /// Share custom content with deep link
  Future<void> shareCustom({
    required String path,
    required String message,
    Map<String, String>? params,
  }) async {
    final link = DeepLinkService.generateDeepLink(
      baseUrl: baseUrl,
      path: path,
      params: params,
    );
    final text = '$message: $link';
    
    await _shareContent(text);
  }
  
  /// Internal method to share content
  Future<void> _shareContent(String text) async {
    try {
      // Copy to clipboard as fallback
      await Clipboard.setData(ClipboardData(text: text));
      
      // Try to use native sharing if available
      // This would require platform-specific implementation
      // For now, we'll just copy to clipboard
      
    } catch (e) {
      throw ShareException('Failed to share content: $e');
    }
  }
  
  /// Generate QR code data for sharing
  String generateQRData({
    required String path,
    Map<String, String>? params,
  }) {
    return DeepLinkService.generateDeepLink(
      baseUrl: baseUrl,
      path: path,
      params: params,
    );
  }
}

/// Exception for sharing errors
class ShareException implements Exception {
  final String message;
  ShareException(this.message);
  
  @override
  String toString() => 'ShareException: $message';
}

/// Provider for share service
final shareServiceProvider = Provider<ShareService>((ref) {
  final config = ref.watch(routerConfigProvider);
  return ShareService(config.baseUrl ?? 'https://deliveryapp.com');
});
