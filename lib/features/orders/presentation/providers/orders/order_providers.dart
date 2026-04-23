import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/orders/data/datasources/mock_order_service.dart';
import 'package:delivery_app/features/orders/data/datasources/order_api_service.dart';
import 'package:delivery_app/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:delivery_app/features/orders/data/datasources/order_remote_datasource_impl.dart';
import 'package:delivery_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/repositories/order_repository.dart';
import 'package:delivery_app/features/orders/domain/usecases/orders_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_providers.g.dart';

// Data Source Providers
@Riverpod(keepAlive: true)
OrderApiService orderApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return OrderApiService(dio);
}

@Riverpod(keepAlive: true)
OrderRemoteDataSource orderRemoteDataSource(Ref ref) {
  final apiService = ref.watch(orderApiServiceProvider);
  return OrderRemoteDataSourceImpl(apiService);
}

// Mock Service Provider
@Riverpod(keepAlive: true)
MockOrderService mockOrderService(Ref ref) {
  return MockOrderService();
}

// Repository Provider
@Riverpod(keepAlive: true)
OrderRepository orderRepository(Ref ref) {
  final remoteDataSource = ref.watch(orderRemoteDataSourceProvider);
  final mockOrderService = ref.watch(mockOrderServiceProvider);
  return OrderRepositoryImpl(remoteDataSource, mockOrderService);
}

// UseCase Providers
@Riverpod(keepAlive: true)
GetUserOrdersUseCase getUserOrdersUseCase(Ref ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return GetUserOrdersUseCase(repository);
}

@Riverpod(keepAlive: true)
GetOrderByIdUseCase getOrderByIdUseCase(Ref ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrderByIdUseCase(repository);
}

@Riverpod(keepAlive: true)
CreateOrderUseCase createOrderUseCase(Ref ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return CreateOrderUseCase(repository);
}

@Riverpod(keepAlive: true)
CancelOrderUseCase cancelOrderUseCase(Ref ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return CancelOrderUseCase(repository);
}
