import 'package:flutter/services.dart';
import '../deep_link/i_deep_link_service.dart';
import 'i_share_service.dart';

/// Implementation of IShareService
class ShareService implements IShareService {
  final String baseUrl;
  final IDeepLinkService _deepLinkService;
  
  ShareService({
    required this.baseUrl,
    required IDeepLinkService deepLinkService,
  }) : _deepLinkService = deepLinkService;
  
  @override
  Future<void> shareRestaurant(String restaurantId, String restaurantName) async {
    final link = _deepLinkService.generateRestaurantLink(baseUrl, restaurantId);
    final text = 'Check out $restaurantName on our delivery app: $link';
    
    await _shareContent(text);
  }
  
  @override
  Future<void> shareOrder(String orderId) async {
    final link = _deepLinkService.generateOrderLink(baseUrl, orderId);
    final text = 'Track my order: $link';
    
    await _shareContent(text);
  }
  
  @override
  Future<void> shareOrderTracking(String orderId) async {
    final link = _deepLinkService.generateTrackingLink(baseUrl, orderId);
    final text = 'Track this order in real-time: $link';
    
    await _shareContent(text);
  }
  
  @override
  Future<void> sharePromo(String promoCode, String description) async {
    final link = _deepLinkService.generatePromoLink(baseUrl, promoCode);
    final text = 'Use promo code $promoCode for $description: $link';
    
    await _shareContent(text);
  }
  
  @override
  Future<void> shareApp() async {
    final text = 'Download our delivery app: $baseUrl';
    await _shareContent(text);
  }
  
  @override
  Future<void> shareCustom({
    required String path,
    required String message,
    Map<String, String>? params,
  }) async {
    final link = _deepLinkService.generateDeepLink(
      baseUrl: baseUrl,
      path: path,
      params: params,
    );
    final text = '$message: $link';
    
    await _shareContent(text);
  }
  
  Future<void> _shareContent(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
    } catch (e) {
      throw Exception('Failed to share content: $e');
    }
  }
  
  @override
  String generateQRData({
    required String path,
    Map<String, String>? params,
  }) {
    return _deepLinkService.generateDeepLink(
      baseUrl: baseUrl,
      path: path,
      params: params,
    );
  }
}
