import 'package:dornas_app/providers/providers.dart';
import 'package:dornas_app/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Verifica el estado de inicio de sesión
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: appProviders,
      child: DornasApp(isLoggedIn: isLoggedIn)
    ),
  );
}

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
        initialRoute: isLoggedIn ? '/home' : '/',
        routes: appRoutes, // Usa las rutas definidas
      );
    }
  }

