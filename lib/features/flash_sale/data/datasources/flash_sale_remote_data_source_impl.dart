import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/flash_sale_campaign_model.dart';
import '../models/flash_sale_item_model.dart';
import 'flash_sale_remote_data_source.dart';

class FlashSaleRemoteDataSourceImpl implements FlashSaleRemoteDataSource {
  const FlashSaleRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<FlashSaleCampaignModel>> getActiveCampaigns() async {
    final rows = await _getList(ApiConstants.activeFlashSaleCampaigns);
    return rows
        .map(FlashSaleCampaignModel.fromJson)
        .where((campaign) => campaign.status == 'ACTIVE')
        .toList(growable: false);
  }

  @override
  Future<List<FlashSaleItemModel>> getCampaignItems(int campaignId) async {
    if (campaignId <= 0) {
      throw const FormatException('Invalid flash-sale campaign identity');
    }
    final rows = await _getList(
      ApiConstants.flashSaleCampaignItems(campaignId),
    );
    return rows
        .map(
          (json) =>
              FlashSaleItemModel.fromJson(json, fallbackCampaignId: campaignId),
        )
        .toList(growable: false);
  }

  Future<List<Map<String, dynamic>>> _getList(String path) async {
    final response = await _dio.get<Map<String, dynamic>>(path);
    final envelope = response.data;
    if (envelope == null ||
        envelope['status'] != 1 ||
        envelope['data'] is! List) {
      throw const FormatException('Invalid flash-sale catalog envelope');
    }
    return (envelope['data'] as List<dynamic>)
        .map((item) {
          if (item is! Map) {
            throw const FormatException('Invalid flash-sale catalog payload');
          }
          return Map<String, dynamic>.from(item);
        })
        .toList(growable: false);
  }
}
