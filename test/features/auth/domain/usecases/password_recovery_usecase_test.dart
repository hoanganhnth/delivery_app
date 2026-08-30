import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/entities/registration_result.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/password_recovery_usecases.dart';
import 'package:delivery_app/features/auth/domain/usecases/social_login_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('requests a password reset only for a valid email', () async {
    final repository = _FakeAuthRepository();
    final result = await RequestPasswordResetUseCase(repository)(
      const RequestPasswordResetParams(email: 'user@example.com'),
    );

    expect(result, const Right<Failure, void>(null));
    expect(repository.resetRequestEmail, 'user@example.com');
  });

  test('rejects malformed password reset email without calling the repository',
      () async {
    final repository = _FakeAuthRepository();
    final result = await RequestPasswordResetUseCase(repository)(
      const RequestPasswordResetParams(email: 'not-an-email'),
    );

    expect(result.isLeft(), isTrue);
    expect(repository.resetRequestEmail, isNull);
  });

  test('resets a password with the backend token contract', () async {
    final repository = _FakeAuthRepository();
    final token = List.filled(32, 't').join();
    final result = await ResetPasswordUseCase(repository)(
      ResetPasswordParams(
        token: token,
        newPassword: 'correct horse battery staple',
      ),
    );

    expect(result, const Right<Failure, void>(null));
    expect(repository.resetToken, token);
  });

  test('rejects a short reset token before making a request', () async {
    final repository = _FakeAuthRepository();
    final result = await ResetPasswordUseCase(repository)(
      const ResetPasswordParams(token: 'short', newPassword: 'password123'),
    );

    expect(result.isLeft(), isTrue);
    expect(repository.resetToken, isNull);
  });
}

class _FakeAuthRepository implements AuthRepository {
  String? resetRequestEmail;
  String? resetToken;

  @override
  Future<Either<Failure, void>> requestPasswordReset(String email) async {
    resetRequestEmail = email;
    return right(null);
  }

  @override
  Future<Either<Failure, void>> resetPassword(String token, String newPassword) async {
    resetToken = token;
    return right(null);
  }

  @override
  Future<Either<Failure, AuthEntity>> login(LoginParams params) => throw UnimplementedError();

  @override
  Future<Either<Failure, AuthEntity>> socialLogin(SocialLoginParams params) => throw UnimplementedError();

  @override
  Future<Either<Failure, RegistrationResult>> register(String? name, String email, String password) => throw UnimplementedError();

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) => throw UnimplementedError();

  @override
  Future<Either<Failure, void>> logout(String refreshToken) => throw UnimplementedError();
}
