import 'package:dio/dio.dart';
import '../dtos/calculate_response_dto.dart';
import '../dtos/cart_context_request_dto.dart';

class PromotionDataSource {
  final Dio _dio;

  PromotionDataSource(this._dio);

  Future<CalculateResponseDto> calculate(CartContextRequestDto request) async {
    try {
      final response = await _dio.post(
        '/promotions/calculate',
        data: request.toJson(),
      );
      return CalculateResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to calculate promotions: $e');
    }
  }

  Future<void> collectVoucher(String code) async {
    try {
      await _dio.post('/promotions/collect/$code');
    } catch (e) {
      throw Exception('Failed to collect voucher: $e');
    }
  }
}
