import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<Either<Failure, String>> call(RefreshTokenParams params) async {
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
