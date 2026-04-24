import 'package:flutter/foundation.dart';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_routes.dart';
import 'i_deep_link_service.dart';

/// Implementation of IDeepLinkService using app_links package
class DeepLinkService implements IDeepLinkService {
  AppLinks? _appLinks;
  GoRouter? _router;
  String? _pendingRoute;

  @override
  Future<void> initialize(GoRouter router) async {
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
  
  @override
  String? getPendingRoute() {
    final route = _pendingRoute;
    _pendingRoute = null;
    return route;
  }

  void _processDeepLink(Uri uri) {
    try {
      debugPrint('Processing deep link: $uri');

      final path = uri.path;
      final queryParams = uri.queryParameters;

      _handleDeepLinkRoute(path, queryParams);

    } catch (e) {
      debugPrint('Error processing deep link: $e');
      _navigateToRoute(AppRoutes.home);
    }
  }
  
  void _handleDeepLinkRoute(String path, Map<String, String> params) {
    switch (path) {
      case '/restaurant':
        final restaurantId = params['id'];
        if (restaurantId != null) {
          _navigateToRoute('/restaurants/$restaurantId');
        } else {
          _navigateToRoute(AppRoutes.restaurants);
        }
        break;
        
      case '/menu':
        final restaurantId = params['restaurant_id'];
        if (restaurantId != null) {
          _navigateToRoute('/restaurants/$restaurantId/menu');
        } else {
          _navigateToRoute(AppRoutes.restaurants);
        }
        break;
        
      case '/order':
        final orderId = params['id'];
        if (orderId != null) {
          _navigateToRoute('/orders/$orderId');
        } else {
          _navigateToRoute(AppRoutes.orders);
        }
        break;
        
      case '/track':
        final orderId = params['order_id'];
        if (orderId != null) {
          _navigateToRoute('/orders/$orderId/track');
        } else {
          _navigateToRoute(AppRoutes.orders);
        }
        break;
        
      case '/promo':
        final promoCode = params['code'];
        if (promoCode != null) {
          _navigateToRoute('${AppRoutes.restaurants}?promo=$promoCode');
        } else {
          _navigateToRoute(AppRoutes.restaurants);
        }
        break;
        
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
          _navigateToRoute('${AppRoutes.home}?verified=true');
        } else {
          _navigateToRoute(AppRoutes.home);
        }
        break;
        
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
        if (_isValidRoute(path)) {
          _navigateToRoute(path);
        } else {
          debugPrint('Unknown deep link path: $path');
          _navigateToRoute(AppRoutes.home);
        }
    }
  }
  
  void _navigateToRoute(String route) {
    if (_router != null) {
      _router!.go(route);
    } else {
      _pendingRoute = route;
    }
  }
  
  bool _isValidRoute(String path) {
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
  
  @override
  String generateDeepLink({
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
  
  @override
  String generateRestaurantLink(String baseUrl, String restaurantId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/restaurant',
      params: {'id': restaurantId},
    );
  }
  
  @override
  String generateOrderLink(String baseUrl, String orderId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/order',
      params: {'id': orderId},
    );
  }
  
  @override
  String generateTrackingLink(String baseUrl, String orderId) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/track',
      params: {'order_id': orderId},
    );
  }
  
  @override
  String generatePromoLink(String baseUrl, String promoCode) {
    return generateDeepLink(
      baseUrl: baseUrl,
      path: '/promo',
      params: {'code': promoCode},
    );
  }
}
