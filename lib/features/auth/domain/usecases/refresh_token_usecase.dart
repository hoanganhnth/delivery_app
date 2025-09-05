
import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase extends UseCase<AuthEntity, RefreshTokenParams> {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(RefreshTokenParams params) async {
    if (params.refreshToken.isEmpty) {
      return left(const ValidationFailure('Refresh token cannot be empty'));
    }

    return await repository.refreshToken(params.refreshToken);
  }
}

class RefreshTokenParams {
  final String refreshToken;

  RefreshTokenParams({
    required this.refreshToken,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RefreshTokenParams && other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => refreshToken.hashCode;

  @override
  String toString() => 'RefreshTokenParams(refreshToken: [HIDDEN])';
}
