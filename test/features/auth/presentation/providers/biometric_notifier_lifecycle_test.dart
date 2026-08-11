import 'dart:async';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/entities/biometric_entity.dart';
import 'package:delivery_app/features/auth/domain/repositories/biometric_repository.dart';
import 'package:delivery_app/features/auth/application/biometric/biometric_notifier.dart';
import 'package:delivery_app/features/auth/di/biometric_di_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  test('availability result is ignored after notifier disposal', () async {
    final repository = _DelayedBiometricRepository();
    final container = ProviderContainer(
      overrides: [biometricRepositoryProvider.overrideWithValue(repository)],
    );
    final notifier = container.read(biometricProvider.notifier);

    final operation = notifier.checkBiometricAvailability();
    await repository.availabilityRequested.future;
    container.dispose();
    repository.availability.complete(const Right(false));

    await expectLater(operation, completes);
  });
}

class _DelayedBiometricRepository implements BiometricRepository {
  final availability = Completer<Either<Failure, bool>>();
  final availabilityRequested = Completer<void>();

  @override
  Future<Either<Failure, bool>> isBiometricAvailable() {
    availabilityRequested.complete();
    return availability.future;
  }

  @override
  Future<Either<Failure, bool>> authenticate(String reason) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, void>> clearAuthSession() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, List<BiometricType>>> getAvailableBiometrics() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, AuthEntity?>> getAuthSession() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, bool>> isBiometricEnabled() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, void>> saveAuthSession({
    required String accessToken,
    String? refreshToken,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, void>> setBiometricEnabled(bool enabled) =>
      throw UnimplementedError();
}
