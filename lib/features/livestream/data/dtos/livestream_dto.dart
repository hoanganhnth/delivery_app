import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/livestream_entity.dart';

part 'livestream_dto.freezed.dart';
part 'livestream_dto.g.dart';

/// Livestream DTO for API communication
@freezed
abstract class LivestreamDto with _$LivestreamDto {
  const factory LivestreamDto({
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
    required String status,
    String? thumbnailUrl,
    String? coverImageUrl,
    required String startTime,
    String? endTime,
    List<LivestreamProductDto>? products,
  }) = _LivestreamDto;

  const LivestreamDto._();

  factory LivestreamDto.fromJson(Map<String, dynamic> json) =>
      _$LivestreamDtoFromJson(json);

  /// Convert DTO to Entity
  LivestreamEntity toEntity() {
    return LivestreamEntity(
      id: id,
      title: title,
      streamerId: streamerId,
      streamerName: streamerName,
      streamerAvatar: streamerAvatar,
      channelName: channelName,
      rtcToken: rtcToken,
      uid: uid,
      description: description,
      viewerCount: viewerCount,
      likeCount: likeCount,
      status: status,
      thumbnailUrl: thumbnailUrl,
      coverImageUrl: coverImageUrl,
      startTime: DateTime.parse(startTime),
      endTime: endTime != null ? DateTime.parse(endTime!) : null,
      products: products?.map((p) => p.toEntity()).toList(),
    );
  }
}

/// Livestream product DTO
@freezed
abstract class LivestreamProductDto with _$LivestreamProductDto {
  const factory LivestreamProductDto({
    required num id,
    required String name,
    required double price,
    required String image,
    required num restaurantId,
    required String restaurantName,
    double? discountPrice,
    String? description,
    int? stockQuantity,
  }) = _LivestreamProductDto;

  const LivestreamProductDto._();

  factory LivestreamProductDto.fromJson(Map<String, dynamic> json) =>
      _$LivestreamProductDtoFromJson(json);

  /// Convert DTO to Entity
  LivestreamProductEntity toEntity() {
    return LivestreamProductEntity(
      id: id,
      name: name,
      price: price,
      image: image,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      discountPrice: discountPrice,
      description: description,
      stockQuantity: stockQuantity,
    );
  }
}
