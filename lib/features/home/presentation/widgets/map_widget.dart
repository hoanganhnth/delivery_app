import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMap? mapboxMap;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }
  @override
  void initState() {
     final token = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
     if (token.isNotEmpty) {
       MapboxOptions.setAccessToken(token);
     }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: MapWidget(
           cameraOptions: CameraOptions(
      center: Point(coordinates: Position(105.780716,21.038412)),
      zoom: 14.0),
      key: ValueKey("mapWidget"),
      onMapCreated: _onMapCreated,
    ));
  }
}