import 'package:json_annotation/json_annotation.dart';

part 'base_response_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponseDto<T> {
  final String status;
  final String message;
  final T? data;

  BaseResponseDto({
    required this.status,
    required this.message,
    this.data,
  });

  factory BaseResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseDtoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseDtoToJson(this, toJsonT);

  bool get isSuccess => status.toLowerCase() == 'success';
  bool get isError => status.toLowerCase() == 'error';
}
