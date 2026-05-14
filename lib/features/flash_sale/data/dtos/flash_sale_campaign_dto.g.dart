// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_sale_campaign_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlashSaleCampaignDto _$FlashSaleCampaignDtoFromJson(
  Map<String, dynamic> json,
) => _FlashSaleCampaignDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  isRecurring: json['isRecurring'] as bool,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
);

Map<String, dynamic> _$FlashSaleCampaignDtoToJson(
  _FlashSaleCampaignDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'isRecurring': instance.isRecurring,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
};
