import 'package:delivery_app/core/utils/validators.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateUserProfileParams {
  final UserEntity user;

  UpdateUserProfileParams({required this.user});
}

class UpdateUserProfileUseCase
    implements UseCase<UserEntity, UpdateUserProfileParams> {
  final ProfileRepository repository;

  UpdateUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(
    UpdateUserProfileParams params,
  ) async {
    // Validate user data

    final user = params.user;
    final validationResult = Validators.validateUserProfile(
      email: user.email,
      fullName: user.fullName,
      phone: user.phone,
      dob: user.dob,
    );
    if (validationResult != null) {
      return left(ValidationFailure(validationResult));
    }

    final result = await repository.updateUserProfile(user);
    return result.fold((failure) => left(failure), (updatedUser) {
      repository.cacheUserProfile(updatedUser);
      return right(updatedUser);
    });
  }

  // Update profile on remote server
}
