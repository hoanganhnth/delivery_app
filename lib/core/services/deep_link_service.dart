import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import '../routing/app_routes.dart';

/// Deep link service for handling incoming deep links
class DeepLinkService {
  static AppLinks? _appLinks;
  static GoRouter? _router;

  /// Initialize deep link handling
  static Future<void> initialize(GoRouter router) async {
    _router = router;

    if (kIsWeb) {
      // Web deep links are handled automatically by go_router
      return;
    }

    try {
      _appLinks = AppLinks();

      // Listen for incoming deep links
      _appLinks!.uriLinkStream.listen(
        (Uri uri) {
          debugPrint('Received deep link: $uri');
          _processDeepLink(uri);
        },
        onError: (err) {
          debugPrint('Deep link error: $err');
        },
      );

      // Get initial deep link if app was opened via deep link
      final Uri? initialUri = await _appLinks!.getInitialLink();
      if (initialUri != null) {
        debugPrint('Initial deep link: $initialUri');
        _processDeepLink(initialUri);
      }
    } catch (e) {
      debugPrint('Deep link initialization error: $e');
    }
  }
  
  /// Process deep link and navigate to appropriate route
  static void _processDeepLink(Uri uri) {
    try {
      debugPrint('Processing deep link: $uri');

      final path = uri.path;
      final queryParams = uri.queryParameters;

      // Handle different deep link patterns
      _handleDeepLinkRoute(path, queryParams);

    } catch (e) {
      debugPrint('Error processing deep link: $e');
      // Fallback to home
      _navigateToRoute(AppRoutes.home);
    }
  }
  
  /// Handle specific deep link routes
  static void _handleDeepLinkRoute(String path, Map<String, String> params) {
    switch (path) {
      // Restaurant deep links
      case '/restaurant':
        final restaurantId = params['id'];
        if (restaurantId != null) {
          _navigateToRoute('/restaurants/$restaurantId');
        } else {
          _navigateToRoute(AppRoutes.restaurants);
        }
        break;
        
      // Menu deep links
      case '/menu':
        final restaurantId = params['restaurant_id'];
        if (restaurantId != null) {
          _navigateToRoute('/restaurants/$restaurantId/menu');
        } else {
          _navigateToRoute(AppRoutes.restaurants);
        }
        break;
        
      // Order deep links
      case '/order':
        final orderId = params['id'];
        if (orderId != null) {
          _navigateToRoute('/orders/$orderId');
        } else {
          _navigateToRoute(AppRoutes.orders);
        }
        break;
        
      // Order tracking deep links
      case '/track':
        final orderId = params['order_id'];
        if (orderId != null) {
          _navigateToRoute('/orders/$orderId/track');
        } else {
          _navigateToRoute(AppRoutes.orders);
        }
        break;
        
      // Promo/discount deep links
      case '/promo':
        final promoCode = params['code'];
        if (promoCode != null) {
          // Navigate to restaurants with promo code
          _navigateToRoute('${AppRoutes.restaurants}?promo=$promoCode');
        } else {
          _navigateToRoute(AppRoutes.restaurants);
        }
        break;
        
      // Share deep links
      case '/share':
        final type = params['type'];
        final id = params['id'];
        
        switch (type) {
          case 'restaurant':
            if (id != null) _navigateToRoute('/restaurants/$id');
            break;
          case 'order':
            if (id != null) _navigateToRoute('/orders/$id');
            break;
          default:
            _navigateToRoute(AppRoutes.home);
        }
        break;
        
      // Auth deep links
      case '/reset-password':
        final token = params['token'];
        if (token != null) {
          _navigateToRoute('${AppRoutes.forgotPassword}?token=$token');
        } else {
          _navigateToRoute(AppRoutes.forgotPassword);
        }
        break;
        
      case '/verify-email':
        final token = params['token'];
        if (token != null) {
          // Handle email verification
          _navigateToRoute('${AppRoutes.home}?verified=true');
        } else {
          _navigateToRoute(AppRoutes.home);
        }
        break;
        
      // Default routes
      case '/':
      case '/home':
        _navigateToRoute(AppRoutes.home);
        break;
        
      case '/login':
        _navigateToRoute(AppRoutes.login);
        break;
        
      case '/register':
        _navigateToRoute(AppRoutes.register);
        break;
        
      default:
        // Try to navigate to the path directly
        if (_isValidRoute(path)) {
          _navigateToRoute(path);
        } else {
          debugPrint('Unknown deep link path: $path');
          _navigateToRoute(AppRoutes.home);
        }
    }
  }
  
  /// Navigate to a specific route
  static void _navigateToRoute(String route) {
    if (_router != null) {
      _router!.go(route);
    } else {
      // Store the route for later navigation if router is not available
      _pendingRoute = route;
    }
  }
  
  /// Check if a route is valid
  static bool _isValidRoute(String path) {
    final validRoutes = [
      AppRoutes.home,
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
      AppRoutes.orders,
      AppRoutes.restaurants,
      AppRoutes.cart,
      AppRoutes.checkout,
      AppRoutes.payment,
      AppRoutes.orderConfirmation,
      AppRoutes.admin,
    ];
    
    return validRoutes.contains(path) || 
           path.startsWith('/restaurants/') ||
           path.startsWith('/orders/');
  }
  
  /// Generate deep link for sharing
  static String generateDeepLink({
    required String baseUrl,
    required String path,
    Map<String, String>? params,
  }) {
    final uri = Uri.parse(baseUrl).replace(
      path: path,
      queryParameters: params,
    );
    return uri.toString();
  }
  
  /// Generate restaurant deep link
  static String generateRestaurantLink(String baseUrl, String restaurantId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/restaurant',
      params: {'id': restaurantId},
    );
  }
  
  /// Generate order deep link
  static String generateOrderLink(String baseUrl, String orderId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/order',
      params: {'id': orderId},
    );
  }
  
  /// Generate order tracking deep link
  static String generateTrackingLink(String baseUrl, String orderId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/track',
      params: {'order_id': orderId},
    );
  }
  
  /// Generate promo deep link
  static String generatePromoLink(String baseUrl, String promoCode) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/promo',
      params: {'code': promoCode},
    );
  }
  
  /// Pending route to navigate to after app initialization
  static String? _pendingRoute;
  
  /// Get and clear pending route
  static String? getPendingRoute() {
    final route = _pendingRoute;
    _pendingRoute = null;
    return route;
  }
}

/// Provider for deep link service
final deepLinkServiceProvider = Provider<DeepLinkService>((ref) {
  return DeepLinkService();
});
