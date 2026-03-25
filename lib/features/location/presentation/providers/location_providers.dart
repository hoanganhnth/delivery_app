import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/datasources/location_datasource.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/usecases/location_usecases.dart';
import '../../domain/entities/location_entity.dart';

part 'location_providers.g.dart';

/// Provider cho LocationDataSource
@riverpod
LocationDataSource locationDataSource(Ref ref) {
  return LocationDataSourceImpl();
}

/// Provider cho LocationRepository
@riverpod
LocationRepository locationRepository(Ref ref) {
  final dataSource = ref.read(locationDataSourceProvider);
  return LocationRepositoryImpl(dataSource: dataSource);
}

/// Provider cho GetCurrentLocationUseCase
@riverpod
GetCurrentLocationUseCase getCurrentLocationUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return GetCurrentLocationUseCase(repository);
}

/// Provider cho GetAddressFromCoordinatesUseCase
@riverpod
GetAddressFromCoordinatesUseCase getAddressFromCoordinatesUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return GetAddressFromCoordinatesUseCase(repository);
}

/// Provider cho GetCoordinatesFromAddressUseCase
@riverpod
GetCoordinatesFromAddressUseCase getCoordinatesFromAddressUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return GetCoordinatesFromAddressUseCase(repository);
}

/// Provider cho CalculateDistanceUseCase
@riverpod
CalculateDistanceUseCase calculateDistanceUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return CalculateDistanceUseCase(repository);
}

/// StateNotifier để quản lý current location state
@riverpod
class CurrentLocationNotifier extends _$CurrentLocationNotifier {
  @override
  AsyncValue<LocationEntity?> build() {
    return const AsyncValue.data(null);
  }

  /// Lấy vị trí hiện tại
  Future<void> getCurrentLocation() async {
    state = const AsyncValue.loading();
    final getCurrentLocationUseCase = ref.read(getCurrentLocationUseCaseProvider);
    final result = await getCurrentLocationUseCase.call(const NoParams());
    
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (location) => state = AsyncValue.data(location),
    );
  }

  /// Lấy địa chỉ từ tọa độ
  Future<AddressEntity?> getAddressFromLocation(LocationEntity location) async {
    final getAddressFromCoordinatesUseCase = ref.read(getAddressFromCoordinatesUseCaseProvider);
    final result = await getAddressFromCoordinatesUseCase.call(
      GetAddressFromCoordinatesParams(
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );

    return result.fold(
      (failure) => null,
      (address) => address,
    );
  }

  /// Reset state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
