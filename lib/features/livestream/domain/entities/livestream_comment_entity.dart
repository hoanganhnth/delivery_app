import 'package:freezed_annotation/freezed_annotation.dart';

part 'livestream_comment_entity.freezed.dart';

/// Livestream comment entity
@freezed
abstract class LivestreamCommentEntity with _$LivestreamCommentEntity {
  const factory LivestreamCommentEntity({
    required String id,
    required num livestreamId,
    required String userId,
    required String userName,
    String? userAvatar,
    required String message,
    required DateTime timestamp,
  }) = _LivestreamCommentEntity;

  const LivestreamCommentEntity._();
}

/// Livestream like event entity
@freezed
abstract class LivestreamLikeEntity with _$LivestreamLikeEntity {
  const factory LivestreamLikeEntity({
    required String id,
    required num livestreamId,
    required String userId,
    String? userName,
    String? userAvatar,
    required DateTime timestamp,
  }) = _LivestreamLikeEntity;

  const LivestreamLikeEntity._();
}
