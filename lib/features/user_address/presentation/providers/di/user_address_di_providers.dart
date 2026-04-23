import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/network/dio/authenticated_network_providers.dart';
import '../../../domain/usecases/user_address_usecases.dart';
import '../../../domain/repositories/user_address_repository.dart';
import '../../../data/repositories/user_address_repository_impl.dart';
import '../../../data/datasources/user_address_remote_datasource.dart';
import '../../../data/datasources/user_address_remote_datasource_impl.dart';
import '../../../data/datasources/user_address_api_service.dart';
import '../list/user_address_list_notifier.dart';
import '../../../domain/entities/user_address_entity.dart';

part 'user_address_di_providers.g.dart';

/// Network providers
@Riverpod(keepAlive: true)
UserAddressApiService userAddressApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return UserAddressApiService(dio);
}

@Riverpod(keepAlive: true)
UserAddressRemoteDataSource userAddressRemoteDataSource(Ref ref) {
  final apiService = ref.watch(userAddressApiServiceProvider);
  return UserAddressRemoteDataSourceImpl(apiService);
}

/// Repository provider
@Riverpod(keepAlive: true)
UserAddressRepository userAddressRepository(Ref ref) {
  final remoteDataSource = ref.watch(userAddressRemoteDataSourceProvider);
  return UserAddressRepositoryImpl(remoteDataSource);
}

/// UseCase providers
@Riverpod(keepAlive: true)
GetUserAddressesUseCase getUserAddressesUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return GetUserAddressesUseCase(repository);
}

@Riverpod(keepAlive: true)
GetAddressByIdUseCase getAddressByIdUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return GetAddressByIdUseCase(repository);
}

@Riverpod(keepAlive: true)
CreateAddressUseCase createAddressUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return CreateAddressUseCase(repository);
}

@Riverpod(keepAlive: true)
UpdateAddressUseCase updateAddressUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return UpdateAddressUseCase(repository);
}

@Riverpod(keepAlive: true)
DeleteAddressUseCase deleteAddressUseCase(Ref ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return DeleteAddressUseCase(repository);
}

@Riverpod(keepAlive: true)
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
