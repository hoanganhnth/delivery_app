import 'package:flutter/foundation.dart';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'i_deep_link_service.dart';

/// Core implementation of IDeepLinkService using app_links package.
/// Domain-agnostic: does not reference AppRoutes, restaurants, orders, etc.
/// Routing logic is delegated to the Feature layer via [DeepLinkHandler].
class DeepLinkService implements IDeepLinkService {
  AppLinks? _appLinks;
  GoRouter? _router;
  String? _pendingRoute;
  DeepLinkHandler? _onLinkReceived;

  @override
  Future<void> initialize(
    GoRouter router, {
    DeepLinkHandler? onLinkReceived,
  }) async {
    _router = router;
    _onLinkReceived = onLinkReceived;

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
          _dispatchLink(uri);
        },
        onError: (err) {
          debugPrint('Deep link error: $err');
        },
      );

      // Get initial deep link if app was opened via deep link
      final Uri? initialUri = await _appLinks!.getInitialLink();
      if (initialUri != null) {
        debugPrint('Initial deep link: $initialUri');
        _dispatchLink(initialUri);
      }
    } catch (e) {
      debugPrint('Deep link initialization error: $e');
    }
  }

  /// Dispatch the URI to the handler or navigate directly
  void _dispatchLink(Uri uri) {
    if (_onLinkReceived != null) {
      // Delegate routing decision to Feature layer
      _onLinkReceived!(uri);
    } else {
      // Fallback: navigate directly using the URI path
      _navigateToRoute(uri.path);
    }
  }

  void _navigateToRoute(String route) {
    if (_router != null) {
      _router!.go(route);
    } else {
      _pendingRoute = route;
    }
  }

  @override
  String? getPendingRoute() {
    final route = _pendingRoute;
    _pendingRoute = null;
    return route;
  }

  @override
  String generateDeepLink({
    required String baseUrl,
    required String path,
    Map<String, String>? params,
  }) {
    final uri = Uri.parse(baseUrl).replace(
      path: path,
      queryParameters: params?.isNotEmpty == true ? params : null,
    );
    return uri.toString();
  }
}
