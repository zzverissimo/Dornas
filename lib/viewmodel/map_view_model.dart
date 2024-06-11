import 'dart:async';

import 'package:dornas_app/services/map_service.dart';
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

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setMessage(String? message) {
    _errorMessage = message;
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

  @override
  void dispose() {
    stopLocationUpdates();
    super.dispose();
  }
}
