import 'package:dornas_app/viewmodel/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng? _startPosition;
  LatLng? _endPosition;
  bool _shouldUpdateLocation = true;

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
    if (_controller != null && mapViewModel.currentLocation != null && _shouldUpdateLocation) {
      // No actualizar la cámara automáticamente
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

  void _moveCameraToLocation(LatLng location) {
    _controller?.animateCamera(
      CameraUpdate.newLatLngZoom(location, 14.0),
    );
  }

  void _addRoute() {
    final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    if (_startPosition != null && _endPosition != null) {
      mapViewModel.addPolyline([_startPosition!, _endPosition!]);
    }
  }

  void _clearRoutes() {
    final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    mapViewModel.clearPolylines();
    setState(() {
      _startPosition = null;
      _endPosition = null;
    });
  }

  void _onMapTypeChanged(dynamic value) {
    final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    setState(() {
      _shouldUpdateLocation = false; // Desactivar la actualización de la ubicación
    });
    mapViewModel.setMapType(value);
    setState(() {
      _shouldUpdateLocation = true; // Reactivar la actualización de la ubicación
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapViewModel = Provider.of<MapViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          DropdownButton<dynamic>(
            value: mapViewModel.isOpenSeaMap ? 'openseamap' : mapViewModel.selectedMapType,
            items: const [
              DropdownMenuItem(
                value: MapType.normal,
                child: Text("Normal"),
              ),
              DropdownMenuItem(
                value: MapType.satellite,
                child: Text("Satélite"),
              ),
              DropdownMenuItem(
                value: MapType.hybrid,
                child: Text("Híbrido"),
              ),
              DropdownMenuItem(
                value: MapType.terrain,
                child: Text("Orográfico"),
              ),
              DropdownMenuItem(
                value: 'openseamap',
                child: Text("OpenSeaMap"),
              ),
            ],
            onChanged: _onMapTypeChanged,
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearRoutes,
          ),
          IconButton(
            icon: const Icon(Icons.directions),
            onPressed: _addRoute,
          ),
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
              if (mapViewModel.currentLocation != null) {
                _moveCameraToLocation(mapViewModel.currentLocation!);
              }
            },
          ),
        ],
      ),
      body: mapViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: mapViewModel.currentLocation ?? const LatLng(0, 0),
                zoom: 14.0,
              ),
              mapType: mapViewModel.isOpenSeaMap
                  ? MapType.none
                  : mapViewModel.selectedMapType,
              myLocationEnabled: false, // Desactivar el punto azul
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
              polylines: mapViewModel.polylines,
              markers: mapViewModel.markers,
              tileOverlays: {
                if (mapViewModel.baseMapTileOverlay != null)
                  mapViewModel.baseMapTileOverlay!,
                if (mapViewModel.openSeaMapTileOverlay != null)
                  mapViewModel.openSeaMapTileOverlay!,
              },
              onTap: (LatLng position) {
                setState(() {
                  if (_startPosition == null) {
                    _startPosition = position;
                  } else if (_endPosition == null) {
                    _endPosition = position;
                  } else {
                    _startPosition = position;
                    _endPosition = null;
                  }
                });
              },
            ),
    );
  }
}
