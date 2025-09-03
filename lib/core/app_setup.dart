import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../features/auth/presentation/providers/auth_network_providers.dart';
import '../features/profile/data/models/user_model.dart';

/// Main app setup with all necessary provider overrides
/// This ensures that all features use the same Dio instance with proper authentication
class AppSetup {
  /// Initialize Hive and register adapters
  static Future<void> initializeHive() async {
    await Hive.initFlutter();

    // Register Hive adapters
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());
    }
  }
  /// Get all provider overrides needed for the app
  /// This includes:
  /// - Authenticated Dio provider override
  /// - Any other global overrides
  static List<Override> getProviderOverrides() {
    return [
      ...getAppProviderOverrides(),
      // Add other feature overrides here as needed
    ];
  }

  /// Setup the main app with ProviderScope and overrides
  static Widget setupApp({
    required Widget child,
    List<Override>? additionalOverrides,
  }) {
    final overrides = [
      ...getProviderOverrides(),
      ...?additionalOverrides,
    ];

    return ProviderScope(
      overrides: overrides,
      child: child,
    );
  }
}

/// Example of how to use in main.dart:
/// 
/// ```dart
/// void main() {
///   runApp(
///     AppSetup.setupApp(
///       child: MyApp(),
///     ),
///   );
/// }
/// 
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       title: 'Delivery App',
///       home: HomeScreen(),
///     );
///   }
/// }
/// ```
/// 
/// Or for testing with additional overrides:
/// 
/// ```dart
/// void main() {
///   runApp(
///     AppSetup.setupApp(
///       child: MyApp(),
///       additionalOverrides: [
///         // Test-specific overrides
///         dioProvider.overrideWith((ref) => mockDio),
///       ],
///     ),
///   );
/// }
/// ```
