import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_dto.freezed.dart';
part 'page_dto.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class PageDto<T> with _$PageDto<T> {
  const factory PageDto({
    required List<T> items,
    required int page,
    required int size,
    required int totalItems,
    required int totalPages,
    required bool hasNext,
  }) = _PageDto<T>;

  factory PageDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PageDtoFromJson(json, fromJsonT);
}
