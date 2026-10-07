import 'package:delivery_app/features/entitlements/data/iap_platform_adapter.dart';
import 'package:delivery_app/features/entitlements/data/unavailable_entitlement_repository.dart';
import 'package:delivery_app/features/entitlements/domain/entities/entitlement.dart';
import 'package:delivery_app/features/entitlements/domain/repositories/entitlement_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('all store operations remain unavailable on both platforms', () async {
    for (final adapter in <IapPlatformAdapter>[
      IosIapAdapter(),
      AndroidIapAdapter(),
    ]) {
      await expectLater(
        adapter.purchase('premium'),
        throwsA(isA<IapPlatformUnavailableException>()),
      );
      await expectLater(
        adapter.restore(),
        throwsA(isA<IapPlatformUnavailableException>()),
      );
    }
  });
  test(
    'repository refuses refresh and receipt submission without backend',
    () async {
      const repository = UnavailableEntitlementRepository();
      await expectLater(
        repository.refresh(),
        throwsA(isA<EntitlementBackendUnavailableException>()),
      );
      for (final platform in StorePlatform.values) {
        await expectLater(
          repository.submit(
            StoreReceipt(
              platform: platform,
              productId: 'premium',
              transactionId: 'tx',
              signedPayload: 'receipt',
            ),
          ),
          throwsA(isA<EntitlementBackendUnavailableException>()),
        );
      }
    },
  );
}
