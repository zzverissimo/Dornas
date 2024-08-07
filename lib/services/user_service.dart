import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // comprueba si hay usuarios en la base de datos
  Future<bool> hasUser(String userId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
      return snapshot.exists;
    } catch (e) {
      throw ('Error al comprobar si existe el usuario');
    }
  }

  // Coge el usuario de la base de datos
  Future<AppUser?> getUser(String userId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        return AppUser.fromFirestore(snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw ('Error al obtener datos del usuario');
    }
    return null;
  }

  // Actualiza los datos del usuario en la base de datos
  Future<void> updateUser(AppUser user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap(), SetOptions(merge: true));
  }

  // Verifica si el usuario puede crear eventos
  Future<bool> canUserCreateEvents(String userId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        return (snapshot.data() as Map<String, dynamic>)['canCreateEvents'] as bool;
      }
    } catch (e) {
      throw ('Error al verificar permisos del usuario');
    }
    return false;
  }

  // Obtiene la URL de la imagen de perfil del usuario
  Future<String?> getUserProfileImageUrl(String userId) async {
    try {
      return await _storage.ref('user_images/$userId.jpg').getDownloadURL();
    } catch (e) {
      throw ('Error al obtener la URL de la imagen del usuario');
    }
  }

  // Elimina un usuario
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      await _storage.ref('user_images/$userId.jpg').delete();
    } catch (e) {
      throw ('Error al eliminar el usuario');
    }
  }
}
