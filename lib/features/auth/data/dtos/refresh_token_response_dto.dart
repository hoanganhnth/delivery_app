import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/data/dtos/base_response_dto.dart';

part 'refresh_token_response_dto.freezed.dart';
part 'refresh_token_response_dto.g.dart';

@freezed
abstract class RefreshTokenDataDto with _$RefreshTokenDataDto {
  const factory RefreshTokenDataDto({
    required String accessToken,
  }) = _RefreshTokenDataDto;

  factory RefreshTokenDataDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDataDtoFromJson(json);
}

// Wrapper for the complete response
typedef RefreshTokenResponseDto = BaseResponseDto<RefreshTokenDataDto>;
