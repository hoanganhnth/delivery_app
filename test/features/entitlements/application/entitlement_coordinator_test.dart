import 'package:delivery_app/features/entitlements/application/entitlement_coordinator.dart';
import 'package:delivery_app/features/entitlements/domain/entities/entitlement.dart';
import 'package:delivery_app/features/entitlements/domain/repositories/entitlement_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('purchase receipt remains pending when the server boundary is unavailable', () async {
    final coordinator = EntitlementCoordinator(
      _UnavailableEntitlementRepository(),
    );

    final state = await coordinator.submitReceipt(
      const StoreReceipt(
        platform: StorePlatform.android,
        productId: 'premium.monthly',
        transactionId: 'transaction-1',
        signedPayload: 'signed-receipt',
      ),
    );

    expect(state.status, EntitlementStatus.pending);
    expect(state.confirmedProductIds, isEmpty);
  });

  test('only a server-confirmed snapshot grants an entitlement', () async {
    final coordinator = EntitlementCoordinator(
      _ConfirmedEntitlementRepository(),
    );

    final state = await coordinator.refresh();

    expect(state.status, EntitlementStatus.active);
    expect(state.confirmedProductIds, {'premium.monthly'});
  });

  test('a revoked server snapshot removes previously confirmed access', () async {
    final coordinator = EntitlementCoordinator(
      _RevokedEntitlementRepository(),
    );

    final state = await coordinator.refresh();

    expect(state.status, EntitlementStatus.revoked);
    expect(state.confirmedProductIds, isEmpty);
  });

  test('malformed receipts never reach the entitlement boundary', () async {
    final repository = _RecordingEntitlementRepository();
    final coordinator = EntitlementCoordinator(repository);

    final state = await coordinator.submitReceipt(
      const StoreReceipt(
        platform: StorePlatform.ios,
        productId: '',
        transactionId: 'transaction-1',
        signedPayload: 'signed-receipt',
      ),
    );

    expect(state.status, EntitlementStatus.unavailable);
    expect(repository.submissions, isEmpty);
  });
}

final class _UnavailableEntitlementRepository implements EntitlementRepository {
  @override
  Future<EntitlementSnapshot> refresh() =>
      Future.error(const EntitlementBackendUnavailableException());

  @override
  Future<EntitlementSnapshot> submit(StoreReceipt receipt) =>
      Future.error(const EntitlementBackendUnavailableException());
}

final class _ConfirmedEntitlementRepository implements EntitlementRepository {
  @override
  Future<EntitlementSnapshot> refresh() async => const EntitlementSnapshot.active(
    {'premium.monthly'},
  );

  @override
  Future<EntitlementSnapshot> submit(StoreReceipt receipt) => refresh();
}

final class _RevokedEntitlementRepository implements EntitlementRepository {
  @override
  Future<EntitlementSnapshot> refresh() async => const EntitlementSnapshot.revoked();

  @override
  Future<EntitlementSnapshot> submit(StoreReceipt receipt) => refresh();
}

final class _RecordingEntitlementRepository implements EntitlementRepository {
  final submissions = <StoreReceipt>[];

  @override
  Future<EntitlementSnapshot> refresh() async =>
      const EntitlementSnapshot.unavailable();

  @override
  Future<EntitlementSnapshot> submit(StoreReceipt receipt) async {
    submissions.add(receipt);
    return const EntitlementSnapshot.pending();
  }
}
