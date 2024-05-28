import 'package:dornas_app/model/user_model.dart';
import 'package:dornas_app/services/auth_service.dart';
import 'package:dornas_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthViewModel extends ChangeNotifier {
  AuthViewModel() {
    _loadUserSession();
  }
  final AuthenticationService _authService = AuthenticationService();
  final UserService _userService = UserService();

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

  Future<void> signUp(String email, String password, String displayName) async {
    setLoading(true);
    setMessage(null);
    try {
      User? user = await _authService.signUp(email, password);
      if (user != null) {
        AppUser newUser = AppUser(
          id: user.uid,
          email: user.email!,
          displayName: displayName,
          // canCreateEvents: false, // Por defecto, no puede crear eventos
        );
        await _userService.updateUser(newUser);
        _currentUser = newUser;
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
    User? user = await _authService.signIn(email, password);
    if (user != null) {
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
    // await prefs.setBool('canCreateEvents', user.canCreateEvents);
  }

  Future<void> _clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userEmail');
    await prefs.remove('userDisplayName');
    await prefs.remove('canCreateEvents');
  }

  Future<void> _loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? userEmail = prefs.getString('userEmail');
    String? userDisplayName = prefs.getString('userDisplayName');
    // bool? canCreateEvents = prefs.getBool('canCreateEvents');
    if (userId != null && userEmail != null) {
      _currentUser = AppUser(
        id: userId,
        email: userEmail,
        displayName: userDisplayName,
        // canCreateEvents: canCreateEvents ?? false,
      );
      notifyListeners();
    }
  }
}
