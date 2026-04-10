import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_livestream_dto.freezed.dart';
part 'join_livestream_dto.g.dart';

/// DTO for join livestream API response
/// Maps to JoinLivestreamResponse from backend
@freezed
abstract class JoinLivestreamDto with _$JoinLivestreamDto {
  const factory JoinLivestreamDto({
    required String livestreamId,
    required String channelName,
    required String title,
    required int restaurantId,
    required String token,
    required int uid,
    String? tokenExpiresAt,
    required int sellerId,
    String? startedAt,
    int? currentViewers,
  }) = _JoinLivestreamDto;

  factory JoinLivestreamDto.fromJson(Map<String, dynamic> json) =>
      _$JoinLivestreamDtoFromJson(json);
}
