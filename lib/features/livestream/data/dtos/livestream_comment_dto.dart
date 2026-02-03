import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/livestream_comment_entity.dart';

part 'livestream_comment_dto.freezed.dart';
part 'livestream_comment_dto.g.dart';

/// Livestream comment DTO for Firebase communication
@freezed
abstract class LivestreamCommentDto with _$LivestreamCommentDto {
  const factory LivestreamCommentDto({
    required String id,
    required num livestreamId,
    required String userId,
    required String userName,
    String? userAvatar,
    required String message,
    required int timestamp,
  }) = _LivestreamCommentDto;

  const LivestreamCommentDto._();

  factory LivestreamCommentDto.fromJson(Map<String, dynamic> json) =>
      _$LivestreamCommentDtoFromJson(json);

  /// Convert DTO to Entity
  LivestreamCommentEntity toEntity() {
    return LivestreamCommentEntity(
      id: id,
      livestreamId: livestreamId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      message: message,
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }

  /// Convert Entity to DTO
  factory LivestreamCommentDto.fromEntity(LivestreamCommentEntity entity) {
    return LivestreamCommentDto(
      id: entity.id,
      livestreamId: entity.livestreamId,
      userId: entity.userId,
      userName: entity.userName,
      userAvatar: entity.userAvatar,
      message: entity.message,
      timestamp: entity.timestamp.millisecondsSinceEpoch,
    );
  }
}

/// Livestream like DTO for Firebase communication
@freezed
abstract class LivestreamLikeDto with _$LivestreamLikeDto {
  const factory LivestreamLikeDto({
    required String id,
    required num livestreamId,
    required String userId,
    String? userName,
    String? userAvatar,
    required int timestamp,
  }) = _LivestreamLikeDto;

  const LivestreamLikeDto._();

  factory LivestreamLikeDto.fromJson(Map<String, dynamic> json) =>
      _$LivestreamLikeDtoFromJson(json);

  /// Convert DTO to Entity
  LivestreamLikeEntity toEntity() {
    return LivestreamLikeEntity(
      id: id,
      livestreamId: livestreamId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }

  /// Convert Entity to DTO
  factory LivestreamLikeDto.fromEntity(LivestreamLikeEntity entity) {
    return LivestreamLikeDto(
      id: entity.id,
      livestreamId: entity.livestreamId,
      userId: entity.userId,
      userName: entity.userName,
      userAvatar: entity.userAvatar,
      timestamp: entity.timestamp.millisecondsSinceEpoch,
    );
  }
}
