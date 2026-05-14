import 'package:freezed_annotation/freezed_annotation.dart';

part 'flash_sale_campaign_dto.freezed.dart';
part 'flash_sale_campaign_dto.g.dart';

/// DTO cho Flash Sale Campaign (data layer — serialization)
@freezed
sealed class FlashSaleCampaignDto with _$FlashSaleCampaignDto {
  const factory FlashSaleCampaignDto({
    required int id,
    required String name,
    required bool isRecurring,
    required String startTime,
    required String endTime,
  }) = _FlashSaleCampaignDto;

  factory FlashSaleCampaignDto.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleCampaignDtoFromJson(json);
}
