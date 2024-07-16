import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Crea un usuario con correo electrónico y contraseña en Firebase y lo devuelve
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Manejo específico de excepciones de Firebase
      if (e.code == 'email-already-in-use') {
        throw ('El correo electrónico ya está en uso.');
      } else if (e.code == 'weak-password') {
        throw ('La contraseña es demasiado débil.');
      } else if (e.code == 'invalid-email') {
        throw ('El correo electrónico no es válido.');
      } else {
        throw ('Error registrando usuario: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error registrando usuario: $e');
    }
  }

  // Inicia sesión con correo electrónico y contraseña en Firebase y devuelve el usuario
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Manejo específico de excepciones de Firebase
      if (e.code == 'invalid-credential') {
        throw ('Las credenciales son incorrectas.');
      } else if (e.code == 'too-many-requests') {
        throw ('Demasiados intentos de inicio de sesión fallidos. Intente más tarde.');
      }
    } catch (e) {
      throw ('Las credenciales proporcionadas son incorrectas.');
    }
    return null;
  }

  // Cierra la sesión del usuario actual
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Envía un correo electrónico de restablecimiento de contraseña a un usuario
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // Manejo específico de excepciones de Firebase
      if (e.code == 'invalid-email') {
        throw ('El correo electrónico no es válido.');
      } else {
        throw ('Error enviando el correo de restablecimiento de contraseña');
      }
    } catch (e) {
      throw ('Error enviando el correo de restablecimiento de contraseña');
    }
  }

  // Obtener el usuario actualmente autenticado
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Inicia sesión con Google y devuelve el usuario
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw ('Error al iniciar sesión con Google');
    }
  }

  // Elimina el usuario autenticado actualmente
  Future<void> deleteCurrentUser() async {
    try {
      await _firebaseAuth.currentUser!.delete();
    } catch (e) {
      throw ('Error al eliminar el usuario');
    }
  }
}
