import 'package:dornas_app/model/user_model.dart';
import 'package:dornas_app/services/auth_service.dart';
import 'package:dornas_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
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
        AppUser newUser =
            AppUser(id: user.uid, email: user.email!, displayName: displayName);
        await _userService.updateUser(newUser);
        _currentUser = newUser;
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
          notifyListeners();
        }
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
}
