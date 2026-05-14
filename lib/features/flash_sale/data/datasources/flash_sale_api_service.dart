import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/features/flash_sale/data/models/flash_sale_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'flash_sale_api_service.g.dart';

@RestApi()
abstract class FlashSaleApiService {
  factory FlashSaleApiService(Dio dio) = _FlashSaleApiService;

  @GET(ApiConstants.getActiveCampaigns)
  Future<BaseResponseDto<List<FlashSaleCampaign>>> getActiveCampaigns();

  @GET(ApiConstants.getCampaignItems)
  Future<BaseResponseDto<List<FlashSaleItem>>> getCampaignItems(
    @Path('id') int campaignId,
  );
}
