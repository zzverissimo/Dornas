import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AppUser?> getUser(String userId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        return AppUser.fromFirestore(snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw Exception('Error al obtener datos del usuario: $e');
    }
    return null;
  }

  Future<void> updateUser(AppUser user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap(), SetOptions(merge: true));
  }

  Future<bool> canUserCreateEvents(String userId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        return (snapshot.data() as Map<String, dynamic>)['canCreateEvents'] as bool;
      }
    } catch (e) {
      throw Exception('Error al verificar permisos del usuario: $e');
    }
    return false;
  }
}
