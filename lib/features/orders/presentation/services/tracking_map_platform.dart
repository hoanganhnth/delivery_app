import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

/// Native map rendering boundary. Host widget tests replace this adapter with
/// a plain widget while keeping all user actions and map-service calls visible.
abstract interface class TrackingMapPlatformPort {
  Widget buildMap({
    required Key key,
    required CameraOptions cameraOptions,
    required ValueChanged<MapboxMap> onMapCreated,
  });
}

class MapboxTrackingMapPlatformAdapter implements TrackingMapPlatformPort {
  const MapboxTrackingMapPlatformAdapter();

  @override
  Widget buildMap({
    required Key key,
    required CameraOptions cameraOptions,
    required ValueChanged<MapboxMap> onMapCreated,
  }) {
    return MapWidget(
      key: key,
      onMapCreated: onMapCreated,
      cameraOptions: cameraOptions,
      textureView: true,
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
      },
    );
  }
}

final trackingMapPlatformProvider = Provider<TrackingMapPlatformPort>(
  (ref) => const MapboxTrackingMapPlatformAdapter(),
);
