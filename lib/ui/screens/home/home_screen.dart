import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:dornas_app/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Home Screen'),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Cerrar sesión',
              onPressed: () async {
                await authViewModel.signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
