import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android and iOS declare native notification/background capability', () {
    final android = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();
    final iosInfo = File('ios/Runner/Info.plist').readAsStringSync();
    final xcode = File(
      'ios/Runner.xcodeproj/project.pbxproj',
    ).readAsStringSync();
    final debugEntitlements = File(
      'ios/Runner/Runner.Debug.entitlements',
    ).readAsStringSync();
    final releaseEntitlements = File(
      'ios/Runner/Runner.Release.entitlements',
    ).readAsStringSync();

    expect(android, contains('android.permission.POST_NOTIFICATIONS'));
    expect(iosInfo, contains('<string>remote-notification</string>'));
    expect(xcode, contains('Runner/Runner.Debug.entitlements'));
    expect(xcode, contains('Runner/Runner.Release.entitlements'));
    expect(debugEntitlements, contains('<string>development</string>'));
    expect(releaseEntitlements, contains('<string>production</string>'));
  });

  test('push sources never log tokens or raw message payloads', () {
    final source = [
      'lib/core/services/push_notification_service.dart',
      'lib/core/services/push/firebase_push_adapters.dart',
      'lib/core/services/push/push_persistence_adapter.dart',
      'lib/main.dart',
    ].map((path) => File(path).readAsStringSync()).join('\n');

    expect(source, isNot(contains('jsonEncode(message.data)')));
    expect(
      source,
      isNot(
        matches(
          RegExp(
            r'(?:debugPrint|AppLogger\.[a-z]+)\([^\n]*(?:token|message\.data)',
            caseSensitive: false,
          ),
        ),
      ),
    );
    expect(source, contains('pushService.wakeSignals.listen'));
    expect(source, contains('customerPushWakeCoordinatorProvider'));
  });
}
