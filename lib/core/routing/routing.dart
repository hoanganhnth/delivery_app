/// Routing barrel file
/// Export all routing-related classes and utilities
library;

// Constants (Pure string constants)
export 'constants/app_routes.dart';

// Models & Interfaces (Pure Dart — no framework dependency)
export 'models/app_router_config.dart';
export 'models/i_auth_checker.dart';

// Guards (Logic — depends only on IAuthChecker)
export 'guards/guard_manager.dart';
export 'guards/route_guards.dart';

// Helpers (UI/Extensions — depends on Flutter + GoRouter)
export 'helpers/navigation_helper.dart';

// Core Router Factory (Pure Dart — root of routing layer)
export 'app_router.dart';

// Riverpod Wiring (Infrastucture/DI — isolated here)
export 'providers/riverpod_auth_notifier.dart';
export 'providers/router_provider.dart';
export 'providers/router_config.dart';

// GoRouter package
export 'package:go_router/go_router.dart';
