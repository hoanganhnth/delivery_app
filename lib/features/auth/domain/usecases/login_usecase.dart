import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    if (!_isEmailValid(params.email)) {
      return left(const ValidationFailure('Invalid email format'));
    }

    if (!_isPasswordValid(params.password)) {
      return left(const ValidationFailure('Password must be at least 6 characters'));
    }

    return await repository.login(params.email, params.password);
  }

  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
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
