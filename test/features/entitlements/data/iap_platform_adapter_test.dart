import 'package:delivery_app/features/entitlements/data/iap_platform_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android adapter stays unavailable until native store wiring is configured', () async {
    final adapter = AndroidIapAdapter();

    expect(
      () => adapter.purchase('premium.monthly'),
      throwsA(isA<IapPlatformUnavailableException>()),
    );
  });

  test('iOS adapter stays unavailable until native store wiring is configured', () async {
    final adapter = IosIapAdapter();

    expect(
      () => adapter.restore(),
      throwsA(isA<IapPlatformUnavailableException>()),
    );
  });
}
