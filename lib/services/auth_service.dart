import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Manejo específico de excepciones de Firebase
      if (e.code == 'email-already-in-use') {
        throw Exception('El correo electrónico ya está en uso.');
      } else if (e.code == 'weak-password') {
        throw Exception('La contraseña es demasiado débil.');
      } else if (e.code == 'invalid-email') {
        throw Exception('El correo electrónico no es válido.');
      } else {
        throw Exception('Error registrando usuario: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error registrando usuario: $e');
    }
  }

    Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Manejo específico de excepciones de Firebase
      if (e.code == 'user-not-found') {
        throw Exception('No existe una cuenta con este correo electrónico.');
      } else if (e.code == 'wrong-password') {
        throw Exception('La contraseña es incorrecta.');
      } else if (e.code == 'invalid-email') {
        throw Exception('El correo electrónico no es válido.');
      } else {
        throw Exception('Error iniciando sesión: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error iniciando sesión: $e');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

 Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // Manejo específico de excepciones de Firebase
      if (e.code == 'user-not-found') {
        throw Exception('No existe una cuenta con este correo electrónico.');
      } else if (e.code == 'invalid-email') {
        throw Exception('El correo electrónico no es válido.');
      } else {
        throw Exception('Error enviando el correo de restablecimiento de contraseña: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error enviando el correo de restablecimiento de contraseña: $e');
    }
  }
}
