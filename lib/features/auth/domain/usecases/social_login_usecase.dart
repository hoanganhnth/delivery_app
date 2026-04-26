import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class SocialLoginUseCase extends UseCase<AuthEntity, SocialLoginParams> {
  final AuthRepository repository;

  SocialLoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(SocialLoginParams params) async {
    return await repository.socialLogin(params);
  }
}

class SocialLoginParams {
  final String provider;
  final String token;
  final String? role;
  final String? deviceId;
  final String? deviceName;
  final String? deviceType;
  final String? ipAddress;

  SocialLoginParams({
    required this.provider,
    required this.token,
    this.role,
    this.deviceId,
    this.deviceName,
    this.deviceType,
    this.ipAddress,
  });
}
