import 'package:freezed_annotation/freezed_annotation.dart';

part 'flash_sale_campaign_entity.freezed.dart';

/// Domain entity cho Flash Sale Campaign
@freezed
sealed class FlashSaleCampaignEntity with _$FlashSaleCampaignEntity {
  const factory FlashSaleCampaignEntity({
    required int id,
    required String name,
    required bool isRecurring,
    required String startTime,
    required String endTime,
  }) = _FlashSaleCampaignEntity;

  const FlashSaleCampaignEntity._();

  /// Kiểm tra campaign còn hiệu lực không
  bool get isActive {
    final now = DateTime.now();
    final end = DateTime.tryParse(endTime);
    if (end == null) return false;
    return now.isBefore(end);
  }

  /// Tính thời gian còn lại
  Duration get timeRemaining {
    final now = DateTime.now();
    final end = DateTime.tryParse(endTime);
    if (end == null || now.isAfter(end)) return Duration.zero;
    return end.difference(now);
  }
}
