import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio/authenticated_network_providers.dart';
import '../../domain/usecases/user_address_usecases.dart';
import '../../domain/repositories/user_address_repository.dart';
import '../../data/repositories/user_address_repository_impl.dart';
import '../../data/datasources/user_address_remote_datasource.dart';
import '../../data/datasources/user_address_remote_datasource_impl.dart';
import '../../data/datasources/user_address_api_service.dart';
import 'user_address_notifiers.dart';
import '../../domain/entities/user_address_entity.dart';

part 'user_address_providers.g.dart';

/// Network providers
@riverpod
UserAddressApiService userAddressApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return UserAddressApiService(dio);
}

@riverpod
UserAddressRemoteDataSource userAddressRemoteDataSource(Ref ref) {
  final apiService = ref.watch(userAddressApiServiceProvider);
  return UserAddressRemoteDataSourceImpl(apiService);
}

/// Repository provider
@riverpod
UserAddressRepository userAddressRepository(Ref ref) {
  final remoteDataSource = ref.watch(userAddressRemoteDataSourceProvider);
  return UserAddressRepositoryImpl(remoteDataSource);
}

/// UseCase providers
@riverpod
GetUserAddressesUseCase getUserAddressesUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return GetUserAddressesUseCase(repository);
}

@riverpod
GetAddressByIdUseCase getAddressByIdUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return GetAddressByIdUseCase(repository);
}

@riverpod
CreateAddressUseCase createAddressUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return CreateAddressUseCase(repository);
}

@riverpod
UpdateAddressUseCase updateAddressUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return UpdateAddressUseCase(repository);
}

@riverpod
DeleteAddressUseCase deleteAddressUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return DeleteAddressUseCase(repository);
}

@riverpod
SetDefaultAddressUseCase setDefaultAddressUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return SetDefaultAddressUseCase(repository);
}

/// Helper providers
@riverpod
UserAddressEntity? defaultAddress(Ref ref) {
  final addressListState = ref.watch(userAddressListProvider);
  return addressListState.defaultAddress;
}

@riverpod
bool hasAddresses(Ref ref) {
  final addressListState = ref.watch(userAddressListProvider);
  return addressListState.hasAddresses;
}
