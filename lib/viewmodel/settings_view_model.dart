import 'package:dornas_app/model/user_model.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';

// ViewModel para la pantalla de ajustes
class SettingsViewModel extends ChangeNotifier {
  final AuthViewModel authViewModel;

  SettingsViewModel({required this.authViewModel});

  AppUser? get currentUser => authViewModel.currentUser;

  bool get isLoading => authViewModel.isLoading;

  String? get errorMessage => authViewModel.errorMessage;

  Future<void> signOut(BuildContext context) async {
    await authViewModel.signOut();
    if (context.mounted) {
      if (errorMessage == null) {
        Navigator.pushReplacementNamed(context, '/start');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage ?? 'Error al cerrar sesión')),
        );
      }
    }
  }

  // Actualiza el perfil del usuario
  Future<void> updateUserProfile(String? newName, String? newPhotoPath) async {
    await authViewModel.updateUserProfile(newName, newPhotoPath);
    notifyListeners();
  }

  // Elimina la cuenta del usuario
  Future<void> deleteAccount(BuildContext context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar cuenta'),
          content: const Text('¿Estás seguro de que quieres eliminar tu cuenta? Esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
    if (confirm == true) {
      await authViewModel.deleteAccount();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/start');
      }
    }
  }
}
