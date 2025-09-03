import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateUserProfileParams {
  final UserEntity user;

  UpdateUserProfileParams({required this.user});
}

class UpdateUserProfileUseCase implements UseCase<UserEntity, UpdateUserProfileParams> {
  final ProfileRepository repository;

  UpdateUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UpdateUserProfileParams params) async {
    // Validate user data
    final validationResult = _validateUserData(params.user);
    if (validationResult != null) {
      return left(ValidationFailure(validationResult));
    }

    // Update profile on remote server
    final result = await repository.updateUserProfile(params.user);
    
    return result.fold(
      (failure) => left(failure),
      (updatedUser) {
        // Cache the updated profile
        repository.cacheUserProfile(updatedUser);
        return right(updatedUser);
      },
    );
  }

  String? _validateUserData(UserEntity user) {
    if (user.email.isEmpty) {
      return 'Email is required';
    }

    if (!_isValidEmail(user.email)) {
      return 'Please enter a valid email address';
    }

    if (user.fullName != null && user.fullName!.length < 2) {
      return 'Full name must be at least 2 characters';
    }

    if (user.phone != null && user.phone!.isNotEmpty && !_isValidPhone(user.phone!)) {
      return 'Please enter a valid phone number';
    }

    if (user.dob != null && user.dob!.isAfter(DateTime.now())) {
      return 'Date of birth cannot be in the future';
    }

    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    // Remove all non-digit characters
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    // Check if it's a valid length (10-15 digits)
    return digitsOnly.length >= 10 && digitsOnly.length <= 15;
  }
}
