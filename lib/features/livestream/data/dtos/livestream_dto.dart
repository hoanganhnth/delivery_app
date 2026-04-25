import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/livestream_entity.dart';

part 'livestream_dto.freezed.dart';
part 'livestream_dto.g.dart';

/// Livestream DTO for API communication
@freezed
abstract class LivestreamDto with _$LivestreamDto {
  const factory LivestreamDto({
    String? id,
    String? title,
    @JsonKey(name: 'sellerId') num? sellerId,
    @JsonKey(name: 'restaurantId') num? restaurantId,
    String? streamerName,
    String? streamerAvatar,
    String? channelName,
    String? rtcToken,
    int? uid,
    String? description,
    @Default(0) int viewerCount,
    @Default(0) int likeCount,
    String? status,
    String? thumbnailUrl,
    String? coverImageUrl,
    @JsonKey(name: 'startedAt') String? startedAt,
    @JsonKey(name: 'endedAt') String? endedAt,
    @JsonKey(name: 'pinnedProducts') List<LivestreamProductDto>? pinnedProducts,
  }) = _LivestreamDto;

  const LivestreamDto._();

  factory LivestreamDto.fromJson(Map<String, dynamic> json) =>
      _$LivestreamDtoFromJson(json);

  /// Convert DTO to Entity
  LivestreamEntity toEntity() {
    return LivestreamEntity(
      id: id ?? '',
      title: title ?? 'No Title',
      streamerId: sellerId?.toString() ?? '',
      streamerName: streamerName ?? 'Restaurant #$restaurantId',
      streamerAvatar: streamerAvatar,
      channelName: channelName ?? '',
      rtcToken: rtcToken ?? '',
      uid: uid ?? 0,
      description: description ?? '',
      viewerCount: viewerCount,
      likeCount: likeCount,
      status: status?.toLowerCase() ?? 'unknown',
      thumbnailUrl: thumbnailUrl,
      coverImageUrl: coverImageUrl,
      startTime: startedAt != null
          ? DateTime.tryParse(startedAt!) ?? DateTime.now()
          : DateTime.now(),
      endTime: endedAt != null ? DateTime.tryParse(endedAt!) : null,
      products: pinnedProducts?.map((p) => p.toEntity()).toList(),
    );
  }
}

/// Livestream product DTO
@freezed
abstract class LivestreamProductDto with _$LivestreamProductDto {
  const factory LivestreamProductDto({
    num? id,
    String? name,
    double? price,
    String? image,
    num? restaurantId,
    String? restaurantName,
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
      id: id ?? 0,
      name: name ?? 'Product',
      price: price ?? 0.0,
      image: image ?? '',
      restaurantId: restaurantId ?? 0,
      restaurantName: restaurantName ?? '',
      discountPrice: discountPrice,
      description: description,
      stockQuantity: stockQuantity,
    );
  }
}
