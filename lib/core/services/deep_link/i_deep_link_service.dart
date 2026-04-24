import 'package:go_router/go_router.dart';

/// Callback type for when a deep link URI is received.
typedef DeepLinkHandler = void Function(Uri uri);

/// Core interface for deep link handling.
/// Domain-agnostic: does not know about restaurants, orders, promos, etc.
/// Reusable across any app without modification.
abstract class IDeepLinkService {
  /// Initialize deep link listening with a router and a handler callback.
  /// The [onLinkReceived] callback is where Feature layer decides routing.
  Future<void> initialize(
    GoRouter router, {
    DeepLinkHandler? onLinkReceived,
  });

  /// Get and clear any pending route (from cold start deep link)
  String? getPendingRoute();

  /// Generate a generic deep link URL from path + query params
  String generateDeepLink({
    required String baseUrl,
    required String path,
    Map<String, String>? params,
  });
}
