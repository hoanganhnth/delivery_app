import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

/// Main app setup with all necessary provider overrides
/// This ensures that all features use the same Dio instance with proper authentication
class AppSetup {
  /// Initialize Hive and register adapters
  static Future<void> initializeHive() async {
    await Hive.initFlutter();

    // Open boxes
    await Hive.openBox('biometric_credentials');
  }

  /// Get all provider overrides needed for the app
  /// This includes:
  /// - Authenticated Dio provider override
  /// - Any other global overrides
  static List<Override> getProviderOverrides() {
    return [
      // Add other feature overrides here as needed
    ];
  }

  // init mapbox
  static Future<void> initializeMapbox() async {
    // Use environment variable or default token
    const String mapboxToken = String.fromEnvironment(
      'MAPBOX_ACCESS_TOKEN',
      defaultValue: '', // Remove hardcoded token for security
    );

    if (mapboxToken.isNotEmpty) {
      MapboxOptions.setAccessToken(mapboxToken);
    } else {
      // Log warning if no token provided
      debugPrint('Warning: Mapbox access token not provided');
    }
  }

  /// Setup the main app with ProviderScope and overrides
  static Widget setupApp({
    required Widget child,
    List<Override>? additionalOverrides,
  }) {
    final overrides = [...getProviderOverrides(), ...?additionalOverrides];

    return ProviderScope(
      overrides: overrides,
      child: child,
      retry: (retryCount, error) => null,
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
