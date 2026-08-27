import '../../domain/entities/flash_sale_campaign_entity.dart';

final class FlashSaleCampaignModel {
  const FlashSaleCampaignModel({
    required this.id,
    required this.name,
    required this.isRecurring,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  final int id;
  final String name;
  final bool isRecurring;
  final String startTime;
  final String endTime;
  final String status;

  factory FlashSaleCampaignModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final recurring = json['isRecurring'];
    final startTime = json['startTime'];
    final endTime = json['endTime'];
    final status = json['status'];
    if (id is! num ||
        id.toInt() <= 0 ||
        name is! String ||
        name.trim().isEmpty ||
        recurring is! bool ||
        startTime is! String ||
        startTime.trim().isEmpty ||
        endTime is! String ||
        endTime.trim().isEmpty ||
        status is! String ||
        status.trim().isEmpty) {
      throw const FormatException('Invalid flash-sale campaign');
    }
    return FlashSaleCampaignModel(
      id: id.toInt(),
      name: name.trim(),
      isRecurring: recurring,
      startTime: startTime,
      endTime: endTime,
      status: status.trim().toUpperCase(),
    );
  }

  FlashSaleCampaignEntity toEntity() => FlashSaleCampaignEntity(
    id: id,
    name: name,
    isRecurring: isRecurring,
    startTime: startTime,
    endTime: endTime,
    status: status,
  );
}
