import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/network_providers.dart';
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

final cancelOrderUseCaseProvider = Provider<CancelOrderUseCase>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return CancelOrderUseCase(repository);
});

// State Providers
final ordersListProvider = StateNotifierProvider<OrdersListNotifier, OrdersListState>((ref) {
  final getUserOrdersUseCase = ref.read(getUserOrdersUseCaseProvider);
  return OrdersListNotifier(getUserOrdersUseCase);
});

final orderDetailProvider = StateNotifierProvider<OrderDetailNotifier, OrderDetailState>((ref) {
  final getOrderByIdUseCase = ref.read(getOrderByIdUseCaseProvider);
  return OrderDetailNotifier(getOrderByIdUseCase);
});

// Async Providers for Actions
final createOrderProvider = AsyncNotifierProvider<CreateOrderNotifier, OrderEntity?>(
  () => CreateOrderNotifier(),
);

final cancelOrderProvider = AsyncNotifierProvider<CancelOrderNotifier, bool?>(
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
