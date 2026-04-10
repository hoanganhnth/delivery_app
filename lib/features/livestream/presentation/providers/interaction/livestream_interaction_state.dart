import '../../../domain/entities/livestream_comment_entity.dart';

/// Livestream interaction state — comments and likes
class LivestreamInteractionState {
  final List<LivestreamCommentEntity> comments;
  final List<LivestreamLikeEntity> recentLikes;
  final bool isSendingComment;
  final bool isSendingLike;

  const LivestreamInteractionState({
    this.comments = const [],
    this.recentLikes = const [],
    this.isSendingComment = false,
    this.isSendingLike = false,
  });

  LivestreamInteractionState copyWith({
    List<LivestreamCommentEntity>? comments,
    List<LivestreamLikeEntity>? recentLikes,
    bool? isSendingComment,
    bool? isSendingLike,
  }) {
    return LivestreamInteractionState(
      comments: comments ?? this.comments,
      recentLikes: recentLikes ?? this.recentLikes,
      isSendingComment: isSendingComment ?? this.isSendingComment,
      isSendingLike: isSendingLike ?? this.isSendingLike,
    );
  }
}
