import 'package:dornas_app/services/map_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends ChangeNotifier {

  final MapService _mapService = MapService();

  LatLng? _currentLocation;
  LatLng? get currentLocation => _currentLocation;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> fetchCurrentLocation() async {
    setLoading(true);
    setMessage(null);
    try {
      _currentLocation = await _mapService.getCurrentLocation();
      notifyListeners();
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
