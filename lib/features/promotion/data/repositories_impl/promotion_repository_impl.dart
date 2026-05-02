import '../../domain/repositories/promotion_repository.dart';
import '../data_sources/promotion_data_source.dart';
import '../dtos/calculate_response_dto.dart';
import '../dtos/cart_context_request_dto.dart';

class PromotionRepositoryImpl implements PromotionRepository {
  final PromotionDataSource _dataSource;

  PromotionRepositoryImpl(this._dataSource);

  @override
  Future<CalculateResponseDto> calculate(CartContextRequestDto request) {
    return _dataSource.calculate(request);
  }

  @override
  Future<void> collectVoucher(String code) {
    return _dataSource.collectVoucher(code);
  }
}
