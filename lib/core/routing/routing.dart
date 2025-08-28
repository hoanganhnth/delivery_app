/// Routing barrel file
/// Export all routing-related classes and utilities
library;

// Core routing
export 'app_router.dart';
export 'app_routes.dart';
export 'navigation_helper.dart';
export 'route_guards.dart';
export 'router_config.dart';

// GoRouter package
export 'package:go_router/go_router.dart';

/// Example usage:
/// 
/// ```dart
/// import 'package:delivery_app/core/routing/routing.dart';
/// 
/// // In your widget:
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return ElevatedButton(
///       onPressed: () => context.goToHome(),
///       child: Text('Go Home'),
///     );
///   }
/// }
/// 
/// // Or using navigation helper:
/// NavigationHelper.goToOrderDetails(context, 'order123');
/// 
/// // Or using GoRouter directly:
/// context.go(AppRoutes.home);
/// ```
