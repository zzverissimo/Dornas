import 'package:dornas_app/model/user_model.dart';
import 'package:dornas_app/services/auth_service.dart';
import 'package:dornas_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  // AuthViewModel() {
  //   _loadUserSession();
  // }

  final AuthenticationService _authService = AuthenticationService();
  final UserService _userService = UserService();

  AppUser? _currentUser;

  //Me devuelve el app user actual
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

  Future<void> signUp(String email, String password, String displayName, String photoUrl, bool canCreateEvents) async {
    setLoading(true);
    setMessage(null);
    try {
      User? user = await _authService.signUp(email, password);
      if (user != null) {
        AppUser newUser = AppUser(
          id: user.uid,
          email: user.email!,
          displayName: displayName,
          photoUrl: photoUrl,
          canCreateEvents: canCreateEvents,
        );
        await _userService.updateUser(newUser);
        _currentUser = newUser;
        //Guarda la sesión del usuario
        await _saveUserSession(newUser);
        notifyListeners();
      }
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> signIn(String email, String password) async {
    setLoading(true);
    setMessage(null);
    try {
      //Coge el usuario de Firebase
      User? user = await _authService.signIn(email, password);
      if (user != null) {
        //Coge el usuario de Firestore en base al usuario de Firebase
        AppUser? appUser = await _userService.getUser(user.uid);
        if (appUser != null) {
          _currentUser = appUser;
          await _saveUserSession(appUser);
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

  Future<void> resetPassword(String email) async {
    setLoading(true);
    setMessage(null);
    try {
      await _authService.sendPasswordResetEmail(email);
      setMessage('Password reset link sent to your email.');
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

    Future<bool> canUserCreateEvents() async {
    if (_currentUser != null) {
      return await _userService.canUserCreateEvents(_currentUser!.id);
    }
    return false;
  }

  Future<void> _saveUserSession(AppUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('userDisplayName', user.displayName ?? '');
  }

  Future<void> _clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userEmail');
    await prefs.remove('userDisplayName');
  }

  Future<AppUser?> getUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? userEmail = prefs.getString('userEmail');
    String? userDisplayName = prefs.getString('userDisplayName');

    if (userId != null && userEmail != null) {
      return AppUser(
        id: userId,
        email: userEmail,
        displayName: userDisplayName,
      );
    }
    return null;
  }
}
