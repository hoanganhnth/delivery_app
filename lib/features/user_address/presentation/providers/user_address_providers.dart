import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio/authenticated_network_providers.dart';
import '../../domain/usecases/user_address_usecases.dart';
import '../../domain/repositories/user_address_repository.dart';
import '../../data/repositories/user_address_repository_impl.dart';
import '../../data/datasources/user_address_remote_datasource.dart';
import '../../data/datasources/user_address_remote_datasource_impl.dart';
import '../../data/datasources/user_address_api_service.dart';
import 'user_address_notifiers.dart';
import 'user_address_state.dart';
import '../../domain/entities/user_address_entity.dart';

/// Network providers
final userAddressApiServiceProvider = Provider<UserAddressApiService>((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return UserAddressApiService(dio);
});

final userAddressRemoteDataSourceProvider = Provider<UserAddressRemoteDataSource>((ref) {
  final apiService = ref.watch(userAddressApiServiceProvider);
  return UserAddressRemoteDataSourceImpl(apiService);
});

/// Repository provider
final userAddressRepositoryProvider = Provider<UserAddressRepository>((ref) {
  final remoteDataSource = ref.watch(userAddressRemoteDataSourceProvider);
  return UserAddressRepositoryImpl(remoteDataSource);
});

/// UseCase providers
final getUserAddressesUseCaseProvider = Provider<GetUserAddressesUseCase>((ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return GetUserAddressesUseCase(repository);
});

final getAddressByIdUseCaseProvider = Provider<GetAddressByIdUseCase>((ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return GetAddressByIdUseCase(repository);
});

final createAddressUseCaseProvider = Provider<CreateAddressUseCase>((ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return CreateAddressUseCase(repository);
});

final updateAddressUseCaseProvider = Provider<UpdateAddressUseCase>((ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return UpdateAddressUseCase(repository);
});

final deleteAddressUseCaseProvider = Provider<DeleteAddressUseCase>((ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return DeleteAddressUseCase(repository);
});

final setDefaultAddressUseCaseProvider = Provider<SetDefaultAddressUseCase>((ref) {
  final repository = ref.watch(userAddressRepositoryProvider);
  return SetDefaultAddressUseCase(repository);
});

/// StateNotifier providers
final userAddressListProvider = StateNotifierProvider<UserAddressListNotifier, UserAddressListState>((ref) {
  final getUserAddressesUseCase = ref.watch(getUserAddressesUseCaseProvider);
  final deleteAddressUseCase = ref.watch(deleteAddressUseCaseProvider);
  final setDefaultAddressUseCase = ref.watch(setDefaultAddressUseCaseProvider);

  return UserAddressListNotifier(
    getUserAddressesUseCase: getUserAddressesUseCase,
    deleteAddressUseCase: deleteAddressUseCase,
    setDefaultAddressUseCase: setDefaultAddressUseCase,
  );
});

final addressFormProvider = StateNotifierProvider.autoDispose<AddressFormNotifier, AsyncValue<UserAddressEntity?>>((ref) {
  final createAddressUseCase = ref.watch(createAddressUseCaseProvider);
  final updateAddressUseCase = ref.watch(updateAddressUseCaseProvider);
  final getAddressByIdUseCase = ref.watch(getAddressByIdUseCaseProvider);

  return AddressFormNotifier(
    createAddressUseCase: createAddressUseCase,
    updateAddressUseCase: updateAddressUseCase,
    getAddressByIdUseCase: getAddressByIdUseCase,
  );
});

/// Helper providers
final defaultAddressProvider = Provider<UserAddressEntity?>((ref) {
  final addressListState = ref.watch(userAddressListProvider);
  return addressListState.defaultAddress;
});

final hasAddressesProvider = Provider<bool>((ref) {
  final addressListState = ref.watch(userAddressListProvider);
  return addressListState.hasAddresses;
});
