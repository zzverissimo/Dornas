import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  Future<LatLng> getCurrentLocation() async {
    // Implementar lógica para obtener la ubicación actual
    return const LatLng(42.54817461982462, -8.859133265213249); // Praia da Canteira
  }

}
