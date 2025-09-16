import 'package:delivery_app/core/network/dio/authenticated_network_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/mock_order_service.dart';
import '../../data/datasources/order_api_service.dart';
import '../../data/datasources/order_remote_datasource.dart';
import '../../data/datasources/order_remote_datasource_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/orders_usecases.dart';
import 'order_async_notifiers.dart';
import 'order_detail_notifier.dart';
import 'order_states.dart';
import 'orders_list_notifier.dart';

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

// State Providers
final ordersListProvider = StateNotifierProvider<OrdersListNotifier, OrdersListState>((ref) {
  final getUserOrdersUseCase = ref.watch(getUserOrdersUseCaseProvider);
  return OrdersListNotifier(getUserOrdersUseCase);
});

final orderDetailProvider = StateNotifierProvider.autoDispose<OrderDetailNotifier, OrderDetailState>((ref) {
  final getOrderByIdUseCase = ref.watch(getOrderByIdUseCaseProvider);
  return OrderDetailNotifier(getOrderByIdUseCase);
});

// Async Providers for Actions
final createOrderProvider = AsyncNotifierProvider.autoDispose<CreateOrderNotifier, OrderEntity?>(
  () => CreateOrderNotifier(),
);

final cancelOrderProvider = AsyncNotifierProvider.autoDispose<CancelOrderNotifier, bool?>(
  () => CancelOrderNotifier(),
);

// Convenience providers for specific order details
final orderByIdProvider = Provider.family<AsyncValue<OrderEntity>, int>((ref, orderId) {
  // This will trigger the orderDetailProvider to fetch the order
  final detailNotifier = ref.read(orderDetailProvider.notifier);
  detailNotifier.getOrderById(orderId);
  
  final detailState = ref.watch(orderDetailProvider);
  
  if (detailState.isLoading) {
    return const AsyncValue.loading();
  } else if (detailState.errorMessage != null) {
    return AsyncValue.error(detailState.errorMessage!, StackTrace.current);
  } else if (detailState.order != null) {
    return AsyncValue.data(detailState.order!);
  } else {
    return const AsyncValue.loading();
  }
});
