import 'package:delivery_app/features/auth/services/device_identity_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('persists one device identity across login attempts', () async {
    SharedPreferences.setMockInitialValues({});

    final first = await DeviceIdentityService.getDeviceId();
    final second = await DeviceIdentityService.getDeviceId();

    expect(first, isNotEmpty);
    expect(second, first);
    expect(DeviceIdentityService.deviceType, 'MOBILE');
  });
}
