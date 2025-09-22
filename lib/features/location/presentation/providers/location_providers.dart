import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/datasources/location_datasource.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/usecases/location_usecases.dart';
import '../../domain/entities/location_entity.dart';

/// Provider cho LocationDataSource
final locationDataSourceProvider = Provider<LocationDataSource>((ref) {
  return LocationDataSourceImpl();
});

/// Provider cho LocationRepository
final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final dataSource = ref.read(locationDataSourceProvider);
  return LocationRepositoryImpl(dataSource: dataSource);
});

/// Provider cho GetCurrentLocationUseCase
final getCurrentLocationUseCaseProvider = Provider<GetCurrentLocationUseCase>((ref) {
  final repository = ref.read(locationRepositoryProvider);
  return GetCurrentLocationUseCase(repository);
});

/// Provider cho GetAddressFromCoordinatesUseCase
final getAddressFromCoordinatesUseCaseProvider = Provider<GetAddressFromCoordinatesUseCase>((ref) {
  final repository = ref.read(locationRepositoryProvider);
  return GetAddressFromCoordinatesUseCase(repository);
});

/// Provider cho GetCoordinatesFromAddressUseCase
final getCoordinatesFromAddressUseCaseProvider = Provider<GetCoordinatesFromAddressUseCase>((ref) {
  final repository = ref.read(locationRepositoryProvider);
  return GetCoordinatesFromAddressUseCase(repository);
});

/// Provider cho CalculateDistanceUseCase
final calculateDistanceUseCaseProvider = Provider<CalculateDistanceUseCase>((ref) {
  final repository = ref.read(locationRepositoryProvider);
  return CalculateDistanceUseCase(repository);
});

/// StateNotifier để quản lý current location state
class CurrentLocationNotifier extends StateNotifier<AsyncValue<LocationEntity?>> {
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final GetAddressFromCoordinatesUseCase _getAddressFromCoordinatesUseCase;

  CurrentLocationNotifier(
    this._getCurrentLocationUseCase,
    this._getAddressFromCoordinatesUseCase,
  ) : super(const AsyncValue.data(null));

  /// Lấy vị trí hiện tại
  Future<void> getCurrentLocation() async {
    state = const AsyncValue.loading();

    final result = await _getCurrentLocationUseCase.call(const NoParams());
    
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (location) => state = AsyncValue.data(location),
    );
  }

  /// Lấy địa chỉ từ tọa độ
  Future<AddressEntity?> getAddressFromLocation(LocationEntity location) async {
    final result = await _getAddressFromCoordinatesUseCase.call(
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

/// Provider cho CurrentLocationNotifier
final currentLocationProvider = StateNotifierProvider<CurrentLocationNotifier, AsyncValue<LocationEntity?>>((ref) {
  final getCurrentLocationUseCase = ref.read(getCurrentLocationUseCaseProvider);
  final getAddressFromCoordinatesUseCase = ref.read(getAddressFromCoordinatesUseCaseProvider);
  
  return CurrentLocationNotifier(
    getCurrentLocationUseCase,
    getAddressFromCoordinatesUseCase,
  );
});
