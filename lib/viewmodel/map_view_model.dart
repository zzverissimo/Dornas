import 'dart:async';

import 'package:dornas_app/services/map_service.dart';
import 'package:dornas_app/ui/widgets/custom_tileprovider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends ChangeNotifier {
  final MapService _mapService = MapService();

  LatLng? _currentLocation;
  LatLng? get currentLocation => _currentLocation;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  StreamSubscription<Position>? _positionStreamSubscription;

  dynamic _selectedMapType = MapType.normal;
  dynamic get selectedMapType => _selectedMapType;

  final Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  TileOverlay? _openSeaMapTileOverlay;
  TileOverlay? get openSeaMapTileOverlay => _openSeaMapTileOverlay;

  TileOverlay? _baseMapTileOverlay;
  TileOverlay? get baseMapTileOverlay => _baseMapTileOverlay;

  bool _isOpenSeaMap = false;
  bool get isOpenSeaMap => _isOpenSeaMap;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setMapType(dynamic mapType) {
    if (mapType == 'openseamap') {
      _selectedMapType = 'openseamap';
      _openSeaMapTileOverlay = TileOverlay(
        tileOverlayId: const TileOverlayId('openseamap'),
        tileProvider: CustomUrlTileProvider(
          urlTemplate: 'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png',
        ),
      );
      _baseMapTileOverlay = TileOverlay(
        tileOverlayId: const TileOverlayId('openseamap_base'),
        tileProvider: CustomUrlTileProvider(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
      );
      _isOpenSeaMap = true;
    } else {
      _selectedMapType = mapType;
      _openSeaMapTileOverlay = null;
      _baseMapTileOverlay = null;
      _isOpenSeaMap = false;
    }
    notifyListeners();
  }

  void startLocationUpdates() {
    _positionStreamSubscription = _mapService.getCurrentLocationStream().listen(
      (Position position) {
        _currentLocation = LatLng(position.latitude, position.longitude);
        notifyListeners();
      },
      onError: (e) {
        setMessage(e.toString());
      },
    );
  }

  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }

  void addPolyline(List<LatLng> points) {
    final polyline = Polyline(
      polylineId: PolylineId(DateTime.now().toIso8601String()),
      points: points,
      color: Colors.blue,
      width: 5,
    );
    _polylines.add(polyline);
    notifyListeners();
  }

  void clearPolylines() {
    _polylines.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    stopLocationUpdates();
    super.dispose();
  }
}
