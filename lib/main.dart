import 'package:dornas_app/model/user_model.dart';
import 'package:dornas_app/providers/providers.dart';
import 'package:dornas_app/routes/routes.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// Punto de entrada de la aplicación
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  
  bool isLoggedIn = true;
  AuthViewModel auth = AuthViewModel();
  AppUser? user = await auth.getUserSession();
  if(user == null) {
    isLoggedIn = false;
  } 

  runApp(   
    MultiProvider(
      providers: appProviders,
      child: DornasApp(isLoggedIn: isLoggedIn),
    ),
  );
}

// Clase principal de la aplicación
class DornasApp extends StatelessWidget {
  const DornasApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      initialRoute: isLoggedIn ? '/main' : '/start',
      routes: appRoutes, // Usa las rutas definidas
    );
  }
}
