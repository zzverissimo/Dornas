import 'package:geolocator/geolocator.dart';

class MapService {
  Stream<Position> getCurrentLocationStream() {
    // Configura las opciones de Geolocator
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, // Establece la precisión
      distanceFilter: 10, // Establece el filtro de distancia
    );

    // Devuelve el stream de posiciones
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}
