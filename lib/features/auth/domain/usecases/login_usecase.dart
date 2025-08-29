import 'package:delivery_app/core/utils/validators.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthEntity>> call(LoginParams params) async {
    if (!Validators.isEmailValid(params.email)) {
      return left(const ValidationFailure('Invalid email format'));
    }

    if (!Validators.isPasswordValid(params.password)) {
      return left(
        const ValidationFailure('Password must be at least 6 characters'),
      );
    }

    return await repository.login(params);
  }
}

class LoginParams {
  final String email;
  final String password;
  final String? deviceId;
  final String? deviceName;
  final String? deviceType;
  final String? ipAddress;

  LoginParams({
    required this.email,
    required this.password,
    this.deviceId,
    this.deviceName,
    this.deviceType,
    this.ipAddress,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginParams &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() => 'LoginParams(email: $email, password: [HIDDEN])';
}
