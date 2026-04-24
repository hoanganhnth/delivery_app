import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response_dto.freezed.dart';
part 'base_response_dto.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class BaseResponseDto<T> with _$BaseResponseDto<T> {
  const factory BaseResponseDto({
    required int status,
    required String message,
    T? data,
  }) = _BaseResponseDto<T>;

  factory BaseResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseDtoFromJson(json, fromJsonT);
}

extension BaseResponseDtoExtension<T> on BaseResponseDto<T> {
  bool get isSuccess => status == 1;
  bool get isError => status != 1;
}
