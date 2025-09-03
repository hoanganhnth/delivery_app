import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class UploadAvatarParams {
  final String imagePath;

  UploadAvatarParams({required this.imagePath});
}

class UploadAvatarUseCase implements UseCase<String, UploadAvatarParams> {
  final ProfileRepository repository;

  UploadAvatarUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(UploadAvatarParams params) async {
    // Validate image path
    if (params.imagePath.isEmpty) {
      return left(const ValidationFailure('Image path is required'));
    }

    // Check if file exists and is valid image
    final validationResult = _validateImageFile(params.imagePath);
    if (validationResult != null) {
      return left(ValidationFailure(validationResult));
    }

    // Upload avatar
    return await repository.uploadAvatar(params.imagePath);
  }

  String? _validateImageFile(String imagePath) {
    // Check file extension
    final allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
    final extension = imagePath.toLowerCase().split('.').last;
    
    if (!allowedExtensions.any((ext) => ext.contains(extension))) {
      return 'Please select a valid image file (JPG, PNG, GIF, WebP)';
    }

    return null;
  }
}
