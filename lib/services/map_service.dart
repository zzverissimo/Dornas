import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class MapService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Position> getCurrentLocationStream() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 5,
    );
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Future<void> updateUserLocation(String userId, Position position) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'location': GeoPoint(position.latitude, position.longitude),
      });
    } catch (e) {
      throw ('Error al actualizar la ubicación del usuario');
    }
  }
}
