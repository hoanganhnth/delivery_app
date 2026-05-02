import '../../data/dtos/calculate_response_dto.dart';
import '../../data/dtos/cart_context_request_dto.dart';

abstract class PromotionRepository {
  Future<CalculateResponseDto> calculate(CartContextRequestDto request);
  Future<void> collectVoucher(String code);
}
