import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';
import '../../data/dtos/create_order_request_dto.dart';

/// Use case cho tạo order mới
class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call(CreateOrderRequestDto request) async {
    // Validate dữ liệu đầu vào
    if (request.customerName.trim().isEmpty) {
      return left(const ValidationFailure('Tên khách hàng không được để trống'));
    }
    
    if (request.customerPhone.trim().isEmpty) {
      return left(const ValidationFailure('Số điện thoại không được để trống'));
    }
    
    if (request.deliveryAddress.trim().isEmpty) {
      return left(const ValidationFailure('Địa chỉ giao hàng không được để trống'));
    }
    
    if (request.items.isEmpty) {
      return left(const ValidationFailure('Đơn hàng phải có ít nhất 1 món'));
    }
    
    // if (request.totalAmount <= 0) {
    //   return left(const ValidationFailure('Tổng tiền phải lớn hơn 0'));
    // }

    // Gọi repository với CreateOrderRequestDto
    return await repository.createOrder(request);
  }
}
