import 'package:dornas_app/providers/providers.dart';
import 'package:dornas_app/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: appProviders,
      child: const DornasApp()
    ),
  );
}

  class DornasApp extends StatelessWidget {
    const DornasApp({super.key});
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        initialRoute: '/',
        routes: appRoutes, // Usa las rutas definidas
      );
    }
  }

