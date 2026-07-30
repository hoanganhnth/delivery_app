import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/profile/domain/entities/user_entity.dart';
import 'package:delivery_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/fulfilment_builders.dart';

void main() {
  test('profile load failure is observable and retry converges', () async {
    final repository = _FakeProfileRepository()
      ..profileResult = const Left(NetworkFailure('Mất kết nối hồ sơ'));
    final container = _container(repository);
    addTearDown(container.dispose);
    final notifier = container.read(profileProvider.notifier);

    final first = notifier.getUserProfile(forceRefresh: true);
    expect(container.read(profileProvider).isLoading, isTrue);
    await first;
    expect(container.read(profileProvider).errorMessage, 'Mất kết nối hồ sơ');

    repository.profileResult = Right(buildProfile());
    await notifier.getUserProfile(forceRefresh: true);
    expect(container.read(profileProvider).user?.authId, 501);
    expect(container.read(profileProvider).failure, isNull);
  });

  test('profile update preserves old data on failure then caches successful retry', () async {
    final repository = _FakeProfileRepository();
    final container = _container(repository);
    addTearDown(container.dispose);
    final notifier = container.read(profileProvider.notifier);
    await notifier.getUserProfile(forceRefresh: true);

    repository.updateResult = const Left(ServerFailure('Số điện thoại đã dùng'));
    await notifier.updateUserProfile(
      name: 'Customer Updated',
      phone: '0900000002',
    );
    expect(container.read(profileProvider).user?.fullName, 'Customer Test');
    expect(container.read(profileProvider).errorMessage, 'Số điện thoại đã dùng');

    repository.updateResult = Right(buildProfile(fullName: 'Customer Updated'));
    await notifier.updateUserProfile(
      name: 'Customer Updated',
      phone: '0900000002',
    );
    expect(container.read(profileProvider).user?.fullName, 'Customer Updated');
    expect(repository.cachedProfile?.fullName, 'Customer Updated');
  });

  test('clear cache resets profile only after repository success', () async {
    final repository = _FakeProfileRepository();
    final container = _container(repository);
    addTearDown(container.dispose);
    final notifier = container.read(profileProvider.notifier);
    await notifier.getUserProfile(forceRefresh: true);

    repository.clearResult = const Left(CacheFailure('Không thể xóa cache'));
    await notifier.clearProfileCache();
    expect(container.read(profileProvider).user, isNotNull);

    repository.clearResult = const Right(null);
    await notifier.clearProfileCache();
    expect(container.read(profileProvider).user, isNull);
  });
}

ProviderContainer _container(_FakeProfileRepository repository) {
  return ProviderContainer(
    overrides: [profileRepositoryProvider.overrideWithValue(repository)],
  );
}

class _FakeProfileRepository implements ProfileRepository {
  Either<Failure, UserEntity> profileResult = Right(buildProfile());
  Either<Failure, UserEntity> updateResult = Right(buildProfile());
  Either<Failure, void> clearResult = const Right(null);
  UserEntity? cachedProfile;

  @override
  Future<Either<Failure, UserEntity>> getUserProfile() async => profileResult;

  @override
  Future<Either<Failure, UserEntity?>> getCachedUserProfile() async =>
      Right(cachedProfile);

  @override
  Future<Either<Failure, UserEntity>> updateUserProfile(UserEntity user) async =>
      updateResult;

  @override
  Future<Either<Failure, void>> cacheUserProfile(UserEntity user) async {
    cachedProfile = user;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> clearCachedUserProfile() async {
    if (clearResult.isRight()) cachedProfile = null;
    return clearResult;
  }
}
