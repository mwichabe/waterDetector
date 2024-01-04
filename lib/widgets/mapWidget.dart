import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_detector_app/screens/models/waterSourceModel.dart';

class MapWidget extends StatelessWidget {
  final List<WaterSource> waterSourceData;

  const MapWidget({super.key, required this.waterSourceData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Sources Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target:
              LatLng(waterSourceData[0].latitude, waterSourceData[0].longitude),
          zoom: 12,
        ),
        markers: _buildMarkers(),
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    return waterSourceData.map((source) {
      return Marker(
        markerId: MarkerId(source.name),
        position: LatLng(source.latitude, source.longitude),
        infoWindow: InfoWindow(title: source.name),
      );
    }).toSet();
  }
}
