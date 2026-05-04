import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/resources/base_response_dto.dart';
import '../dtos/restaurant_rating_request_dto.dart';

part 'restaurant_rating_api_service.g.dart';

@RestApi()
abstract class RestaurantRatingApiService {
  factory RestaurantRatingApiService(Dio dio, {String baseUrl}) = _RestaurantRatingApiService;

  @POST('${ApiConstants.getRestaurant}/{restaurantId}/ratings')
  Future<BaseResponseDto<dynamic>> submitRating(
    @Path('restaurantId') int restaurantId,
    @Body() RestaurantRatingRequestDto request,
  );
}
