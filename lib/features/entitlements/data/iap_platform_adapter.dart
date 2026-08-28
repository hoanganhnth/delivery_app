import '../domain/entities/entitlement.dart';

abstract interface class IapPlatformAdapter {
  Future<StoreReceipt> purchase(String productId);
  Future<List<StoreReceipt>> restore();
}

final class IapPlatformUnavailableException implements Exception {
  const IapPlatformUnavailableException();
}

/// Native StoreKit wiring is intentionally not enabled until the product
/// catalog and backend verification contract are available.
final class IosIapAdapter implements IapPlatformAdapter {
  @override
  Future<StoreReceipt> purchase(String productId) =>
      Future.error(const IapPlatformUnavailableException());

  @override
  Future<List<StoreReceipt>> restore() =>
      Future.error(const IapPlatformUnavailableException());
}

/// Native Google Play Billing wiring is intentionally not enabled until the
/// product catalog and backend verification contract are available.
final class AndroidIapAdapter implements IapPlatformAdapter {
  @override
  Future<StoreReceipt> purchase(String productId) =>
      Future.error(const IapPlatformUnavailableException());

  @override
  Future<List<StoreReceipt>> restore() =>
      Future.error(const IapPlatformUnavailableException());
}
