import 'package:delivery_app/core/network/api_client.dart';
import 'package:delivery_app/core/network/api_endpoints.dart';
import 'package:delivery_app/features/flash_sale/data/models/flash_sale_model.dart';
import 'package:dio/dio.dart';

class FlashSaleRepository {
  final ApiClient _apiClient;

  FlashSaleRepository(this._apiClient);

  Future<List<FlashSaleCampaign>> getActiveCampaigns() async {
    try {
      final response = await _apiClient.dio.get('/api/flashsales/public/campaigns');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((e) => FlashSaleCampaign.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load flash sale campaigns: $e');
    }
  }

  Future<List<FlashSaleItem>> getCampaignItems(int campaignId) async {
    try {
      final response = await _apiClient.dio.get('/api/flashsales/public/campaigns/$campaignId/items');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((e) => FlashSaleItem.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load flash sale items: $e');
    }
  }
}
