import 'package:delivery_app/features/auth/services/device_identity_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class DeviceIdentityPort {
  String get deviceName;
  String get deviceType;
  Future<String> getDeviceId();
}

class DeviceIdentityAdapter implements DeviceIdentityPort {
  const DeviceIdentityAdapter();

  @override
  String get deviceName => DeviceIdentityService.deviceName;

  @override
  String get deviceType => DeviceIdentityService.deviceType;

  @override
  Future<String> getDeviceId() => DeviceIdentityService.getDeviceId();
}

abstract interface class SocialIdentityPort {
  /// Returns null only when the user cancels the provider flow.
  Future<String?> getGoogleIdToken();
}

class GoogleSocialIdentityAdapter implements SocialIdentityPort {
  GoogleSocialIdentityAdapter({GoogleSignIn? googleSignIn})
    : _googleSignIn = googleSignIn ?? GoogleSignIn(scopes: const ['email']);

  final GoogleSignIn _googleSignIn;

  @override
  Future<String?> getGoogleIdToken() async {
    final account = await _googleSignIn.signIn();
    if (account == null) return null;

    final authentication = await account.authentication;
    final idToken = authentication.idToken;
    if (idToken == null || idToken.trim().isEmpty) {
      throw StateError('Google login failed: Empty ID token');
    }
    return idToken;
  }
}

final deviceIdentityPortProvider = Provider<DeviceIdentityPort>((ref) {
  return const DeviceIdentityAdapter();
});

final socialIdentityPortProvider = Provider<SocialIdentityPort>((ref) {
  return GoogleSocialIdentityAdapter();
});
