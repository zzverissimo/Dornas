import 'package:dornas_app/viewmodel/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// Pantalla de mapa
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

  // Solicita permiso de ubicación
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

  // Actualiza la ubicación en el mapa
  void _updateLocation() {
    final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    if (_controller != null && mapViewModel.currentLocation != null && _shouldUpdateLocation) {
      // No actualizar la cámara automáticamente
      // Lo dejo así para el futuro
    }
  }

  // Callback cuando el mapa se ha creado
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

  // Mueve la cámara a una ubicación
  void _moveCameraToLocation(LatLng location) {
    _controller?.animateCamera(
      CameraUpdate.newLatLngZoom(location, 14.0),
    );
  }

// Agrega una linea
  void _addRoute() {
    final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    if (_startPosition != null && _endPosition != null) {
      mapViewModel.addPolyline([_startPosition!, _endPosition!]);
    }
  }

 // Elimina las lineas
  void _clearRoutes() {
    final mapViewModel = Provider.of<MapViewModel>(context, listen: false);
    mapViewModel.clearPolylines();
    setState(() {
      _startPosition = null;
      _endPosition = null;
    });
  }

 // Cambia el tipo de mapa
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
        automaticallyImplyLeading: false,
        title: const Text('Mapa'),
        backgroundColor: const Color.fromARGB(255, 144, 184, 253),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: "Georgia"
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              canvasColor: const Color.fromARGB(255, 144, 184, 253),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<dynamic>(
                value: mapViewModel.isOpenSeaMap ? 'openseamap' : mapViewModel.selectedMapType,
                focusColor: const Color.fromARGB(255, 144, 184, 253),
                dropdownColor: const Color.fromARGB(255, 144, 184, 253),
                style: const TextStyle(color: Colors.white),
                items: const [
                  DropdownMenuItem(
                    value: MapType.normal,
                    child: Text("Normal", style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: MapType.satellite,
                    child: Text("Satélite", style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: MapType.hybrid,
                    child: Text("Híbrido", style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: MapType.terrain,
                    child: Text("Orográfico", style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: 'openseamap',
                    child: Text("OpenSeaMap", style: TextStyle(color: Colors.white)),
                  ),
                ],
                onChanged: _onMapTypeChanged,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: _clearRoutes,
          ),
          IconButton(
            icon: const Icon(Icons.directions, color: Colors.white),
            onPressed: _addRoute,
          ),
          IconButton(
            icon: const Icon(Icons.my_location, color: Colors.white),
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
