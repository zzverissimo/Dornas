import 'package:dornas_app/viewmodel/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapViewModel = Provider.of<MapViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: mapViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: mapViewModel.currentLocation ?? const LatLng(0, 0),
                zoom: 14.0,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapViewModel.fetchCurrentLocation();
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
