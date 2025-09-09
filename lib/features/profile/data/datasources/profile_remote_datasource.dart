import '../../../../core/data/dtos/base_response_dto.dart';
import '../dtos/user_profile_dto.dart';
import '../dtos/update_profile_request_dto.dart';

abstract class ProfileRemoteDataSource {
  Future<BaseResponseDto<UserProfileDto>> getUserProfile();
  Future<BaseResponseDto<UserProfileDto>> updateUserProfile(
    UpdateProfileRequestDto request,
  );
  Future<BaseResponseDto<String>> uploadAvatar(
    String imagePath,
  );
}
