import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/livestream_comment_entity.dart';

part 'livestream_comment_dto.freezed.dart';
part 'livestream_comment_dto.g.dart';

int? _timestampFromJson(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) return value.millisecondsSinceEpoch;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}

dynamic _timestampToJson(int? value) {
  if (value == null) return null;
  return Timestamp.fromMillisecondsSinceEpoch(value);
}

/// Livestream comment DTO for Firebase communication
@freezed
sealed class LivestreamCommentDto with _$LivestreamCommentDto {
  const factory LivestreamCommentDto({
    String? id,
    String? livestreamId,
    String? userId,
    String? userName,
    String? userAvatar,
    String? message,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) int? timestamp,
  }) = _LivestreamCommentDto;

  const LivestreamCommentDto._();

  factory LivestreamCommentDto.fromJson(Map<String, dynamic> json) =>
      _$LivestreamCommentDtoFromJson(json);

  /// Convert DTO to Entity
  LivestreamCommentEntity toEntity() {
    return LivestreamCommentEntity(
      id: id ?? '',
      livestreamId: livestreamId ?? '',
      userId: userId ?? '',
      userName: userName ?? 'Unknown',
      userAvatar: userAvatar,
      message: message ?? '',
      timestamp: timestamp != null 
          ? DateTime.fromMillisecondsSinceEpoch(timestamp!)
          : DateTime.now(),
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
sealed class LivestreamLikeDto with _$LivestreamLikeDto {
  const factory LivestreamLikeDto({
    String? id,
    String? livestreamId,
    String? userId,
    String? userName,
    String? userAvatar,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) int? timestamp,
  }) = _LivestreamLikeDto;

  const LivestreamLikeDto._();

  factory LivestreamLikeDto.fromJson(Map<String, dynamic> json) =>
      _$LivestreamLikeDtoFromJson(json);

  /// Convert DTO to Entity
  LivestreamLikeEntity toEntity() {
    return LivestreamLikeEntity(
      id: id ?? '',
      livestreamId: livestreamId ?? '',
      userId: userId ?? '',
      userName: userName ?? 'Unknown',
      userAvatar: userAvatar,
      timestamp: timestamp != null 
          ? DateTime.fromMillisecondsSinceEpoch(timestamp!)
          : DateTime.now(),
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
