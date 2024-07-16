import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/user_model.dart';
import 'package:dornas_app/services/auth_service.dart';
import 'package:dornas_app/services/event_service.dart';
import 'package:dornas_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ViewModel para la autenticación
class AuthViewModel extends ChangeNotifier {
  final AuthenticationService _authService = AuthenticationService();
  final UserService _userService = UserService();
  final EventService _eventService = EventService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

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

  // Registro de un nuevo usuario
  Future<void> signUp(String email, String password, String displayName, String photoPath, bool canCreateEvents) async {
    setLoading(true);
    setMessage(null);
    try {
      User? user = await _authService.signUp(email, password);
      if (user != null) {
        String photoUrl = await _uploadImage(photoPath, user.uid);

        AppUser newUser = AppUser(
          id: user.uid,
          email: user.email!,
          displayName: displayName,
          photoUrl: photoUrl,
          canCreateEvents: canCreateEvents,
        );

        await _userService.updateUser(newUser);
        _currentUser = newUser;
        await _saveUserSession(newUser);
        _listenToUserChanges(user.uid);
        notifyListeners();
      }
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Subir imagen a Firebase Storage
  Future<String> _uploadImage(String filePath, String userId) async {
    File file = File(filePath);
    try {
      await _storage.ref('user_images/$userId.jpg').putFile(file);
      return await _storage.ref('user_images/$userId.jpg').getDownloadURL();
    } catch (e) {
      throw ('Error cargando imagen');
    }
  }

  // Iniciar sesión con correo electrónico y contraseña
  Future<void> signIn(String email, String password) async {
    setLoading(true);
    setMessage(null);
    try {
      User? user = await _authService.signIn(email, password);
      if (user != null) {
        AppUser? appUser = await _userService.getUser(user.uid);
        if (appUser != null) {
          _currentUser = appUser;
          await _saveUserSession(appUser);
          _listenToUserChanges(user.uid);
          notifyListeners();
        } else {
          setMessage('Usuario no encontrado en Firestore.');
        }
      } else {
        setMessage('Las credenciales proporcionadas son incorrectas.');
      }
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    setLoading(true);
    try {
      await _authService.signOut();
      _currentUser = null;
      await _clearUserSession();
      notifyListeners();
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Restablecer contraseña
  Future<void> resetPassword(String email) async {
    setLoading(true);
    setMessage(null);
    try {
      await _authService.sendPasswordResetEmail(email);
      setMessage('Revise su correo para restablecer la contraseña.');
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Guardar la sesión del usuario en SharedPreferences
  Future<void> _saveUserSession(AppUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('userDisplayName', user.displayName ?? '');
    await prefs.setString('userPhotoUrl', user.photoUrl ?? '');
    await prefs.setBool('userCanCreateEvents', user.canCreateEvents ?? false);
  }

  // Limpiar la sesión del usuario en SharedPreferences
  Future<void> _clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Obtener la sesión del usuario guardada en SharedPreferences
  Future<AppUser?> getUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? userEmail = prefs.getString('userEmail');
    String? userDisplayName = prefs.getString('userDisplayName');
    String? userPhotoUrl = prefs.getString('userPhotoUrl');
    bool? userCanCreateEvents = prefs.getBool('userCanCreateEvents');

    if (userId != null && userEmail != null) {
      bool userExists = await _userService.hasUser(userId);
      if (!userExists) {
        await _clearUserSession();
        return null;
      }
      
      _currentUser = AppUser(
        id: userId,
        email: userEmail,
        displayName: userDisplayName,
        photoUrl: userPhotoUrl,
        canCreateEvents: userCanCreateEvents ?? false,
      );
      _listenToUserChanges(userId);
      return _currentUser;
    }
    return null;
  }

  // Escuchar cambios en los datos del usuario
  void _listenToUserChanges(String userId) {
    _firestore.collection('users').doc(userId).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        _currentUser = AppUser(
          id: _currentUser!.id,
          email: _currentUser!.email,
          displayName: data['displayName'],
          photoUrl: data['photoUrl'],
          canCreateEvents: data['canCreateEvents'] ?? false,
        );
        notifyListeners();
      }
    });
  }

  // Verificar si el usuario puede crear eventos
  Future<bool> canUserCreateEvents() async {
    if (_currentUser != null) {
      return _currentUser!.canCreateEvents ?? false;
    }
    return false;
  }

  // Iniciar sesión con Google
  Future<void> signInWithGoogle() async {
    setLoading(true);
    setMessage(null);
    try {
      User? user = await _authService.signInWithGoogle();
      if (user != null) {
        AppUser? appUser = await _userService.getUser(user.uid);
        if (appUser == null) {
          appUser = AppUser(id: user.uid, email: user.email!, displayName: user.displayName, photoUrl: user.photoURL);
          await _userService.updateUser(appUser);
        }
        _currentUser = appUser;
        await _saveUserSession(appUser);
        _listenToUserChanges(user.uid);
        notifyListeners();
      } else {
        setMessage('Error al iniciar sesión con Google.');
      }
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Actualizar el perfil del usuario
  Future<void> updateUserProfile(String? newName, String? newPhotoPath) async {
    setLoading(true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? photoUrl;

        if (newPhotoPath != null) {
          photoUrl = await _uploadImage(newPhotoPath, user.uid);
        }

        final userData = {
          'displayName': newName,
          'photoUrl': photoUrl,
        };

        userData.removeWhere((key, value) => value == null);

        await FirebaseFirestore.instance.collection('users').doc(user.uid).update(userData);

        final updatedUser = AppUser(
          id: user.uid,
          email: user.email!,
          displayName: newName ?? currentUser?.displayName,
          photoUrl: photoUrl ?? currentUser?.photoUrl,
        );

        _currentUser = updatedUser;
        await _saveUserSession(updatedUser);
        notifyListeners();
      }
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Eliminar la cuenta del usuario
  Future<void> deleteAccount() async {
    setLoading(true);
    setMessage(null);
    try {
      if (_currentUser != null) {
        await _eventService.removeUserFromAllEvents(_currentUser!.id);
        await _userService.deleteUser(_currentUser!.id);
        await _authService.deleteCurrentUser();
        _currentUser = null;
        await _clearUserSession();
        notifyListeners();
      }
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
