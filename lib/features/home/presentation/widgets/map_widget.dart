import 'package:flutter/material.dart';
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
     MapboxOptions.setAccessToken("pk.eyJ1IjoiaG9hbmdhbmhudGgyazMiLCJhIjoiY21kZTdwYWhzMDZseDJvcHZtZXd0NTVmciJ9.y0pYbmhi7oS7_eZ57_uEgA");
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