import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Coge el usuario de la base de datos
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

  //Actualiza los datos del usuario en la base de datos
  Future<void> updateUser(AppUser user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap(), SetOptions(merge: true));
  }

  //Verifica si el usuario puede crear eventos
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
