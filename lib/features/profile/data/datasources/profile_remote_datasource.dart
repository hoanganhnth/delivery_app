import 'package:fpdart/fpdart.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../dtos/user_profile_dto.dart';
import '../dtos/update_profile_request_dto.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Exception, BaseResponseDto<UserProfileDto>>> getUserProfile();
  Future<Either<Exception, BaseResponseDto<UserProfileDto>>> updateUserProfile(
    UpdateProfileRequestDto request,
  );
  Future<Either<Exception, BaseResponseDto<String>>> uploadAvatar(
    String imagePath,
  );
}
