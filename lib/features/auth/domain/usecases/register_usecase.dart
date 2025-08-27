import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    if (!_isEmailValid(params.email)) {
      return left(const ValidationFailure('Invalid email format'));
    }

    if (!_isPasswordValid(params.password)) {
      return left(const ValidationFailure('Password must be at least 6 characters'));
    }

    if (params.password != params.confirmPassword) {
      return left(const ValidationFailure('Passwords do not match'));
    }

    return await repository.register(params.email, params.password);
  }

  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String confirmPassword;
  final String? name;

  RegisterParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RegisterParams &&
        other.email == email &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.name == name;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        name.hashCode;
  }

  @override
  String toString() => 'RegisterParams(email: $email, name: $name, password: [HIDDEN])';
}
