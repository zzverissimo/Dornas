import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/user_model.dart';
import 'package:dornas_app/services/auth_service.dart';
import 'package:dornas_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticationService _authService = AuthenticationService();
  final UserService _userService = UserService();
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

  Future<String> _uploadImage(String filePath, String userId) async {
    File file = File(filePath);
    try {
      await _storage.ref('user_images/$userId.jpg').putFile(file);
      return await _storage.ref('user_images/$userId.jpg').getDownloadURL();
    } catch (e) {
      throw Exception('Error uploading image: $e');
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

  Future<void> _saveUserSession(AppUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('userDisplayName', user.displayName ?? '');
    await prefs.setString('userPhotoUrl', user.photoUrl ?? '');
    await prefs.setBool('userCanCreateEvents', user.canCreateEvents ?? false);
  }

  Future<void> _clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

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

  Future<bool> canUserCreateEvents() async {
    if (_currentUser != null) {
      return _currentUser!.canCreateEvents ?? false;
    }
    return false;
  }
}
