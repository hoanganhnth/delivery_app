import 'package:freezed_annotation/freezed_annotation.dart';

part 'livestream_entity.freezed.dart';

/// Livestream entity representing a live streaming session
@freezed
abstract class LivestreamEntity with _$LivestreamEntity {
  const factory LivestreamEntity({
    required num id,
    required String title,
    required String streamerId,
    required String streamerName,
    String? streamerAvatar,
    required String channelName,
    required String rtcToken,
    required int uid,
    required String description,
    required int viewerCount,
    required int likeCount,
    required String status, // 'live', 'upcoming', 'ended'
    String? thumbnailUrl,
    String? coverImageUrl,
    required DateTime startTime,
    DateTime? endTime,
    List<LivestreamProductEntity>? products,
  }) = _LivestreamEntity;

  const LivestreamEntity._();

  bool get isLive => status == 'live';
  bool get isUpcoming => status == 'upcoming';
  bool get hasEnded => status == 'ended';
}

/// Livestream product entity
@freezed
abstract class LivestreamProductEntity with _$LivestreamProductEntity {
  const factory LivestreamProductEntity({
    required num id,
    required String name,
    required double price,
    required String image,
    required num restaurantId,
    required String restaurantName,
    double? discountPrice,
    String? description,
    int? stockQuantity,
  }) = _LivestreamProductEntity;

  const LivestreamProductEntity._();

  bool get hasDiscount => discountPrice != null && discountPrice! < price;
  double get finalPrice => discountPrice ?? price;
  int get discountPercent =>
      hasDiscount ? (((price - discountPrice!) / price) * 100).round() : 0;
}
