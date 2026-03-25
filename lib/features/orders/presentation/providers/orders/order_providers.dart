import 'package:delivery_app/core/network/dio/authenticated_network_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/datasources/mock_order_service.dart';
import '../../../data/datasources/order_api_service.dart';
import '../../../data/datasources/order_remote_datasource.dart';
import '../../../data/datasources/order_remote_datasource_impl.dart';
import '../../../data/repositories/order_repository_impl.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../../domain/usecases/orders_usecases.dart';

// Data Source Providers
final orderApiServiceProvider = Provider<OrderApiService>((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return OrderApiService(dio);
});

final orderRemoteDataSourceProvider = Provider<OrderRemoteDataSource>((ref) {
  final apiService = ref.watch(orderApiServiceProvider);
  return OrderRemoteDataSourceImpl(apiService);
});

// Mock Service Provider
final mockOrderServiceProvider = Provider<MockOrderService>((ref) {
  return MockOrderService();
});

// Repository Provider
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final remoteDataSource = ref.watch(orderRemoteDataSourceProvider);
  final mockOrderService = ref.watch(mockOrderServiceProvider);
  return OrderRepositoryImpl(remoteDataSource, mockOrderService);
});

// UseCase Providers
final getUserOrdersUseCaseProvider = Provider<GetUserOrdersUseCase>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return GetUserOrdersUseCase(repository);
});

final getOrderByIdUseCaseProvider = Provider<GetOrderByIdUseCase>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrderByIdUseCase(repository);
});

final createOrderUseCaseProvider = Provider<CreateOrderUseCase>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return CreateOrderUseCase(repository);
});

final cancelOrderUseCaseProvider = Provider<CancelOrderUseCase>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return CancelOrderUseCase(repository);
});

// Since CreateOrder and CancelOrder are now generated, we can remove the explicit ones
