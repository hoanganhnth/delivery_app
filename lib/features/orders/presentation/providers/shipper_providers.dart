import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio/authenticated_network_providers.dart';
import '../../data/datasources/shipper_remote_datasource_impl.dart';
import '../../data/repositories/shipper_repository_impl.dart';
import '../../domain/usecases/get_shipper_usecase.dart';

// =============================================================================
// NETWORK PROVIDERS
// =============================================================================

/// Provider cho ShipperApiService
final shipperApiServiceProvider = Provider<ShipperApiService>((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return ShipperApiService(dio);
});

/// Provider cho ShipperRemoteDataSource
final shipperRemoteDataSourceProvider = Provider<ShipperRemoteDataSourceImpl>((ref) {
  final apiService = ref.watch(shipperApiServiceProvider);
  return ShipperRemoteDataSourceImpl(apiService);
});

// =============================================================================
// REPOSITORY PROVIDERS
// =============================================================================

/// Provider cho ShipperRepository
final shipperRepositoryProvider = Provider<ShipperRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(shipperRemoteDataSourceProvider);
  return ShipperRepositoryImpl(remoteDataSource);
});

// =============================================================================
// USECASE PROVIDERS
// =============================================================================

/// Provider cho GetShipperByIdUseCase
final getShipperByIdUseCaseProvider = Provider<GetShipperByIdUseCase>((ref) {
  final repository = ref.watch(shipperRepositoryProvider);
  return GetShipperByIdUseCase(repository);
});

/// Provider cho GetShippersInAreaUseCase
final getShippersInAreaUseCaseProvider = Provider<GetShippersInAreaUseCase>((ref) {
  final repository = ref.watch(shipperRepositoryProvider);
  return GetShippersInAreaUseCase(repository);
});
