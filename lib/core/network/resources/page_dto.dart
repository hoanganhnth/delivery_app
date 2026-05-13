import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_dto.freezed.dart';
part 'page_dto.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class PageDto<T> with _$PageDto<T> {
  const factory PageDto({
    required List<T> content,
    required int totalPages,
    required int totalElements,
    required int size,
    required int number,
  }) = _PageDto<T>;

  factory PageDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PageDtoFromJson(json, fromJsonT);
}
