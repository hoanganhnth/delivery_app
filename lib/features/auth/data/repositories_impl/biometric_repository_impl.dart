import 'package:fpdart/fpdart.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/biometric_entity.dart';
import '../../domain/repositories/biometric_repository.dart';
import '../datasources/biometric_local_datasource.dart';
import '../models/token_model.dart';

/// Implementation of BiometricRepository
class BiometricRepositoryImpl implements BiometricRepository {
  final BiometricLocalDataSource localDataSource;

  BiometricRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, bool>> isBiometricAvailable() async {
    try {
      final result = await localDataSource.canCheckBiometrics();
      return right(result);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const CacheFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<BiometricType>>> getAvailableBiometrics() async {
    try {
      final result = await localDataSource.getAvailableBiometrics();
      return right(result);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const CacheFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> authenticate(String reason) async {
    try {
      final result = await localDataSource.authenticate(reason);
      return right(result);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const CacheFailure('Biometric authentication failed'));
    }
  }

  @override
  Future<Either<Failure, void>> saveAuthSession({
    required String accessToken,
    String? refreshToken,
  }) async {
    try {
      await localDataSource.saveAuthSession(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      return right(null);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const CacheFailure('Failed to save auth session'));
    }
  }

  @override
  Future<Either<Failure, TokenModel?>> getAuthSession() async {
    try {
      final result = await localDataSource.getAuthSession();
      return right(result);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const CacheFailure('Failed to get auth session'));
    }
  }

  @override
  Future<Either<Failure, void>> clearAuthSession() async {
    try {
      await localDataSource.clearSession();
      return right(null);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const CacheFailure('Failed to clear auth session'));
    }
  }

  @override
  Future<Either<Failure, bool>> isBiometricEnabled() async {
    try {
      final result = await localDataSource.isBiometricEnabled();
      return right(result);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const CacheFailure('Failed to check biometric status'));
    }
  }

  @override
  Future<Either<Failure, void>> setBiometricEnabled(bool enabled) async {
    try {
      await localDataSource.setBiometricEnabled(enabled);
      return right(null);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const CacheFailure('Failed to set biometric status'));
    }
  }
}
