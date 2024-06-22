// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationService {
//   Stream<Position> getCurrentLocationStream() {
//     return Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 10, 
//       ),
//     );
//   }

//   Future<void> updateLocationInFirestore(String userId, Position position) async {
//     await FirebaseFirestore.instance.collection('users').doc(userId).update({
//       'location': {
//         'latitude': position.latitude,
//         'longitude': position.longitude,
//       },
//     });
//   }
// }
