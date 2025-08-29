import 'package:json_annotation/json_annotation.dart';
import 'base_response_dto.dart';

part 'simple_response_dto.g.dart';

/// For responses that only contain status and message, no data
@JsonSerializable()
class EmptyDataDto {
  EmptyDataDto();

  factory EmptyDataDto.fromJson(Map<String, dynamic> json) =>
      _$EmptyDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyDataDtoToJson(this);
}

typedef SimpleResponseDto = BaseResponseDto<EmptyDataDto?>;

/// Helper to create simple responses
class SimpleResponseHelper {
  static SimpleResponseDto fromJson(Map<String, dynamic> json) {
    return BaseResponseDto<EmptyDataDto?>(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] != null ? EmptyDataDto.fromJson({}) : null,
    );
  }
}
