import 'package:delivery_app/core/error/dio_exception_handler.dart';
import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import 'package:delivery_app/features/flash_sale/data/datasources/flash_sale_api_service.dart';
import 'package:delivery_app/features/flash_sale/data/models/flash_sale_model.dart';
import 'package:dio/dio.dart';

class FlashSaleRepository {
  final FlashSaleApiService _apiService;

  FlashSaleRepository(this._apiService);

  Future<List<FlashSaleCampaign>> getActiveCampaigns() async {
    try {
      AppLogger.d('Getting active flash sale campaigns');
      final response = await _apiService.getActiveCampaigns();
      
      if (response.isSuccess && response.data != null) {
        AppLogger.i('Successfully retrieved ${response.data!.length} campaigns');
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get active campaigns', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting active campaigns', e);
      rethrow;
    }
  }

  Future<List<FlashSaleItem>> getCampaignItems(int campaignId) async {
    try {
      AppLogger.d('Getting items for campaign $campaignId');
      final response = await _apiService.getCampaignItems(campaignId);
      
      if (response.isSuccess && response.data != null) {
        AppLogger.i('Successfully retrieved ${response.data!.length} items for campaign $campaignId');
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get campaign items', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting campaign items', e);
      rethrow;
    }
  }
}
