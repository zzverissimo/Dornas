import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthViewModel _FirebaseAuth = AuthViewModel();

    return Scaffold(
      body: Center(
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Home Screen'),
            const SizedBox(height: 20),
            IconButton(
              onPressed: (){
               _FirebaseAuth.signOut();
              },
              icon: const Icon(Icons.exit_to_app),
              color: Theme.of(context).colorScheme.secondary,
            )
          ],
        ),
      ),
    );
  }
}
