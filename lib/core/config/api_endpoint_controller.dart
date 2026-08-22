import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'runtime_config.dart';

/// Owns the Gateway origin used by all app HTTP clients.
///
/// The persisted override is intentionally a developer setting. Production
/// code still starts from the build-time [RuntimeConfig] value, while the
/// debug screen can replace it for the current installation.
class ApiEndpointController extends ChangeNotifier {
  ApiEndpointController({
    required String defaultGatewayOrigin,
    SharedPreferences? preferences,
  }) : _preferences = preferences,
       _defaultGatewayOrigin = normalizeGatewayOrigin(defaultGatewayOrigin),
       _gatewayOrigin = _readStoredOrigin(
         defaultGatewayOrigin: defaultGatewayOrigin,
         preferences: preferences,
       );

  factory ApiEndpointController.memory({required String defaultGatewayOrigin}) {
    return ApiEndpointController(defaultGatewayOrigin: defaultGatewayOrigin);
  }

  static const storageKey = 'debug_gateway_origin';

  final SharedPreferences? _preferences;
  final String _defaultGatewayOrigin;
  String _gatewayOrigin;

  String get gatewayOrigin => _gatewayOrigin;
  String get apiBaseUrl => '$gatewayOrigin/api';
  String get defaultGatewayOrigin => _defaultGatewayOrigin;
  bool get hasOverride => gatewayOrigin != defaultGatewayOrigin;

  Future<void> setGatewayOrigin(String value) async {
    final normalized = normalizeGatewayOrigin(value);
    if (_preferences != null) {
      await _preferences.setString(storageKey, normalized);
    }
    if (_gatewayOrigin == normalized) return;
    _gatewayOrigin = normalized;
    notifyListeners();
  }

  Future<void> reset() async {
    if (_preferences != null) {
      await _preferences.remove(storageKey);
    }
    if (_gatewayOrigin == _defaultGatewayOrigin) return;
    _gatewayOrigin = _defaultGatewayOrigin;
    notifyListeners();
  }

  static String normalizeGatewayOrigin(String value) {
    var candidate = value.trim();
    if (candidate.isEmpty) {
      throw const FormatException('Backend URL không được để trống');
    }

    candidate = candidate.replaceFirst(RegExp(r'/api/?$'), '');
    candidate = candidate.replaceFirst(RegExp(r'/+$'), '');
    final parsed = Uri.tryParse(candidate);
    if (parsed == null ||
        parsed.host.isEmpty ||
        (parsed.scheme != 'http' && parsed.scheme != 'https') ||
        parsed.query.isNotEmpty ||
        parsed.fragment.isNotEmpty) {
      throw const FormatException(
        'Backend URL phải là http(s)://host và không có query/fragment',
      );
    }
    return candidate;
  }
}

String _readStoredOrigin({
  required String defaultGatewayOrigin,
  required SharedPreferences? preferences,
}) {
  final stored = preferences?.getString(ApiEndpointController.storageKey);
  if (stored == null || stored.trim().isEmpty) {
    return ApiEndpointController.normalizeGatewayOrigin(defaultGatewayOrigin);
  }
  try {
    return ApiEndpointController.normalizeGatewayOrigin(stored);
  } on FormatException {
    return ApiEndpointController.normalizeGatewayOrigin(defaultGatewayOrigin);
  }
}

final apiEndpointControllerProvider = Provider<ApiEndpointController>((ref) {
  return ApiEndpointController.memory(
    defaultGatewayOrigin: RuntimeConfig.gatewayBaseUrl,
  );
});
