import 'package:dornas_app/ui/screens/initialscreen/start_screen.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( Provider<AuthViewModel>(
      create: (_) => AuthViewModel(),
      child: MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.blue
    ),
    home: const StartScreen()
    ),
  ) 
  );
}

