import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/network_providers.dart';
import '../../data/datasources/order_api_service.dart';
import '../../data/datasources/order_remote_datasource.dart';
import '../../data/datasources/order_remote_datasource_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/orders_usecases.dart';
import 'orders_provider.dart';

// Data Source Providers
final orderApiServiceProvider = Provider<OrderApiService>((ref) {
  final dio = ref.read(dioProvider);
  return OrderApiService(dio);
});

final orderRemoteDataSourceProvider = Provider<OrderRemoteDataSource>((ref) {
  final apiService = ref.read(orderApiServiceProvider);
  return OrderRemoteDataSourceImpl(apiService);
});

// Repository Provider
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final remoteDataSource = ref.read(orderRemoteDataSourceProvider);
  return OrderRepositoryImpl(remoteDataSource);
});

// UseCase Providers
final getUserOrdersUseCaseProvider = Provider<GetUserOrdersUseCase>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return GetUserOrdersUseCase(repository);
});

final getOrderByIdUseCaseProvider = Provider<GetOrderByIdUseCase>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return GetOrderByIdUseCase(repository);
});

final createOrderUseCaseProvider = Provider<CreateOrderUseCase>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return CreateOrderUseCase(repository);
});

final updateOrderStatusUseCaseProvider = Provider<UpdateOrderStatusUseCase>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return UpdateOrderStatusUseCase(repository);
});

final cancelOrderUseCaseProvider = Provider<CancelOrderUseCase>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return CancelOrderUseCase(repository);
});

final getOrdersByStatusUseCaseProvider = Provider<GetOrdersByStatusUseCase>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return GetOrdersByStatusUseCase(repository);
});

final getOrderHistoryUseCaseProvider = Provider<GetOrderHistoryUseCase>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return GetOrderHistoryUseCase(repository);
});

// Main Orders Provider
final ordersProvider = StateNotifierProvider<OrdersNotifier, OrdersState>((ref) {
  return OrdersNotifier(
    getUserOrdersUseCase: ref.read(getUserOrdersUseCaseProvider),
    getOrderByIdUseCase: ref.read(getOrderByIdUseCaseProvider),
    createOrderUseCase: ref.read(createOrderUseCaseProvider),
    updateOrderStatusUseCase: ref.read(updateOrderStatusUseCaseProvider),
    cancelOrderUseCase: ref.read(cancelOrderUseCaseProvider),
    getOrdersByStatusUseCase: ref.read(getOrdersByStatusUseCaseProvider),
    getOrderHistoryUseCase: ref.read(getOrderHistoryUseCaseProvider),
  );
});
