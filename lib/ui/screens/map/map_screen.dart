import 'package:dornas_app/viewmodel/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
      mapViewModel.startLocationUpdates();
      mapViewModel.addListener(_updateLocation);
    } else if (status.isDenied || status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  void _updateLocation() {
    final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    if (_controller != null && mapViewModel.currentLocation != null) {
      _controller?.animateCamera(
        CameraUpdate.newLatLngZoom(mapViewModel.currentLocation!, 14.0),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _updateLocation();
  }

  @override
  void dispose() {
    _controller?.dispose();
    final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    mapViewModel.stopLocationUpdates();
    mapViewModel.removeListener(_updateLocation);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapViewModel = Provider.of<MapViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        leading: const SizedBox.shrink(),
      ),
      body: mapViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: mapViewModel.currentLocation ?? const LatLng(0, 0),
                zoom: 14.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
            ),
    );
  }
}
