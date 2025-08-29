import 'package:json_annotation/json_annotation.dart';
import '../../../../core/data/dtos/base_response_dto.dart';

part 'refresh_token_response_dto.g.dart';

@JsonSerializable()
class RefreshTokenDataDto {
  @JsonKey(name: 'access_token')
  final String accessToken;

  RefreshTokenDataDto({
    required this.accessToken,
  });

  factory RefreshTokenDataDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenDataDtoToJson(this);
}

// Wrapper for the complete response
typedef RefreshTokenResponseDto = BaseResponseDto<RefreshTokenDataDto>;
