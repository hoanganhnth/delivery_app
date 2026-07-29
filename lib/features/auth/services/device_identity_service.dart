import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceIdentityService {
  DeviceIdentityService._();

  static const _deviceIdKey = 'auth.device_id';
  static const deviceName = 'Delivery Mobile';
  static const deviceType = 'MOBILE';

  static Future<String> getDeviceId() async {
    final preferences = await SharedPreferences.getInstance();
    final existing = preferences.getString(_deviceIdKey);
    if (existing != null && existing.isNotEmpty) return existing;

    final generated = const Uuid().v4();
    await preferences.setString(_deviceIdKey, generated);
    return generated;
  }
}
