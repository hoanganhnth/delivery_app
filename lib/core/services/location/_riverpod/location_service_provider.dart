import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../i_location_service.dart';
import '../geolocator_location_service.dart';

part 'location_service_provider.g.dart';

@Riverpod(keepAlive: true)
ILocationService locationService(Ref ref) {
  return GeolocatorLocationService();
}
