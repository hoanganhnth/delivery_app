import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/socket/providers/tracking_service_providers.dart';
import '../../domain/usecases/tracking_usecases.dart';
import '../../domain/entities/shipper_location_entity.dart';
import '../../domain/entities/delivery_tracking_entity.dart';

/// UseCase providers
final trackShipperLocationUseCaseProvider = Provider<TrackShipperLocationUseCase>((ref) {
  final repository = ref.watch(shipperLocationRepositoryProvider);
  return TrackShipperLocationUseCase(repository);
});

final trackDeliveryUseCaseProvider = Provider<TrackDeliveryUseCase>((ref) {
  final repository = ref.watch(deliveryTrackingRepositoryProvider);
  return TrackDeliveryUseCase(repository);
});

/// UI Stream Providers - Đơn giản hóa để dễ sử dụng cho Widget
final shipperLocationStreamProvider = StreamProvider.family<ShipperLocationEntity, int>((ref, shipperId) async* {
  final useCase = ref.read(trackShipperLocationUseCaseProvider);
  
  final result = await useCase(TrackShipperParams(shipperId: shipperId));
  
  yield* result.fold(
    (failure) => Stream<ShipperLocationEntity>.error(failure),
    (stream) => stream,
  );
});

final deliveryTrackingStreamProvider = StreamProvider.family<DeliveryTrackingEntity, int>((ref, orderId) async* {
  final useCase = ref.read(trackDeliveryUseCaseProvider);
  
  final result = await useCase(TrackDeliveryParams(orderId: orderId));
  
  yield* result.fold(
    (failure) => Stream<DeliveryTrackingEntity>.error(failure),
    (stream) => stream,
  );
});
