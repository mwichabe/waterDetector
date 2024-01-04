import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:water_detector_app/screens/models/waterSourceModel.dart';

class MapWidget extends StatefulWidget {
  final List<WaterSource> waterSourceData;

  const MapWidget({super.key, required this.waterSourceData});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late Position _currentPosition;
  LatLng? _currentLatLng;
  final MapController _mapController = MapController();
  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _currentLatLng =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    setState(() {});
  }

  Set<Marker> _buildMarkers() {
    return widget.waterSourceData.map((source) {
      return Marker(
        point: LatLng(source.latitude, source.longitude),
        child: Text(source.name),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Sources Map'),
      ),
      body: Center(
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: _currentLatLng,
            zoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: _currentLatLng != null
                  ? [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: _currentLatLng!,
                        child: const Icon(Icons.location_on),
                      ),
                      ..._buildMarkers(),
                    ]
                  : [],
            ),
          ],
        ),
      ),
    );
  }
}
