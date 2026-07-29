import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_remote_datasource_impl.dart';
import 'package:delivery_app/features/orders/data/repositories/delivery_tracking_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/repositories/delivery_tracking_repository.dart';
import 'package:delivery_app/features/orders/domain/usecases/get_current_delivery_usecase.dart';

/// Network providers
final deliveryTrackingApiServiceProvider = Provider((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return DeliveryTrackingApiService(dio);
});

final deliveryTrackingRemoteDataSourceProvider = Provider((ref) {
  final apiService = ref.watch(deliveryTrackingApiServiceProvider);
  return DeliveryTrackingRemoteDataSourceImpl(apiService);
});

/// Repository Provider - Di chuyển từ core về feature
final deliveryTrackingRepositoryProvider = Provider<DeliveryTrackingRepository>(
  (ref) {
    final remoteDataSource = ref.watch(
      deliveryTrackingRemoteDataSourceProvider,
    );
    return DeliveryTrackingRepositoryImpl(remoteDataSource);
  },
);

final getCurrentDeliveryUseCaseProvider = Provider<GetCurrentDeliveryUseCase>((
  ref,
) {
  final repository = ref.watch(deliveryTrackingRepositoryProvider);
  return GetCurrentDeliveryUseCase(repository);
});
