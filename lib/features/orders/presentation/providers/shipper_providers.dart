import 'package:delivery_app/core/network/dio/authenticated_network_providers.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_remote_datasource.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_remote_datasource_impl.dart';
import 'package:delivery_app/features/orders/data/repositories/shipper_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/repositories/shipper_repository.dart';
import 'package:delivery_app/features/orders/domain/usecases/get_shipper_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shipper_providers.g.dart';

// =============================================================================
// NETWORK PROVIDERS
// =============================================================================

/// Provider cho ShipperApiService
@Riverpod(keepAlive: true)
ShipperApiService shipperApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return ShipperApiService(dio);
}

/// Provider cho ShipperRemoteDataSource
@Riverpod(keepAlive: true)
ShipperRemoteDataSource shipperRemoteDataSource(Ref ref) {
  final apiService = ref.watch(shipperApiServiceProvider);
  return ShipperRemoteDataSourceImpl(apiService);
}

// =============================================================================
// REPOSITORY PROVIDERS
// =============================================================================

/// Provider cho ShipperRepository
@Riverpod(keepAlive: true)
ShipperRepository shipperRepository(Ref ref) {
  final remoteDataSource = ref.watch(shipperRemoteDataSourceProvider);
  return ShipperRepositoryImpl(remoteDataSource);
}

// =============================================================================
// USECASE PROVIDERS
// =============================================================================

/// Provider cho GetShipperByIdUseCase
@Riverpod(keepAlive: true)
GetShipperByIdUseCase getShipperByIdUseCase(Ref ref) {
  final repository = ref.watch(shipperRepositoryProvider);
  return GetShipperByIdUseCase(repository);
}

/// Provider cho GetShippersInAreaUseCase
@Riverpod(keepAlive: true)
GetShippersInAreaUseCase getShippersInAreaUseCase(Ref ref) {
  final repository = ref.watch(shipperRepositoryProvider);
  return GetShippersInAreaUseCase(repository);
}
