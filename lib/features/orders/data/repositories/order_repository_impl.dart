import 'package:delivery_app/core/error/error_mapper.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/order_creation_command.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../dtos/order_dto.dart';
import '../dtos/create_order_request_dto.dart';

/// Implementation của OrderRepository
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final pageDto = await _remoteDataSource.getUserOrders(page, size);
      final dtos = pageDto.items;
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      return Right(entities);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Không thể tải danh sách đơn hàng'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(num orderId) async {
    try {
      final dto = await _remoteDataSource.getOrderById(orderId);
      return right(dto.toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Không thể tải thông tin đơn hàng'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> createOrder(
    OrderCreationCommand request,
  ) async {
    try {
      final dto = await _remoteDataSource.createOrderWithDto(_toDto(request));
      return right(dto.toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Không thể tạo đơn hàng'));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelOrder(
    int orderId, {
    String? reason,
  }) async {
    try {
      final success = await _remoteDataSource.cancelOrder(
        orderId,
        reason: reason,
      );
      return right(success);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Không thể hủy đơn hàng'));
    }
  }

  CreateOrderRequestDto _toDto(OrderCreationCommand command) =>
      CreateOrderRequestDto(
        restaurantId: command.restaurantId,
        deliveryAddress: command.deliveryAddress,
        deliveryLat: command.deliveryLat,
        deliveryLng: command.deliveryLng,
        customerName: command.customerName,
        customerPhone: command.customerPhone,
        paymentMethod: command.paymentMethod,
        notes: command.notes,
        voucherIds: command.voucherIds,
        items: command.items
            .map(
              (item) => OrderItemRequest(
                menuItemId: item.menuItemId,
                quantity: item.quantity,
                notes: item.notes,
                flashSaleItemId: item.flashSaleItemId,
              ),
            )
            .toList(growable: false),
      );
}
