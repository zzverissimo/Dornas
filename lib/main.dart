import 'package:dornas_app/model/user_model.dart';
import 'package:dornas_app/providers/providers.dart';
import 'package:dornas_app/routes/routes.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Verifica el estado de inicio de sesión
  // AuthenticationService auth = AuthenticationService();
  // User? user = auth.getCurrentUser();
  // bool isLoggedIn = true;
  // if(user == null) {
  //   isLoggedIn = false;
  // }

  // Verifica el estado de inicio de sesión
   // Verifica el estado de inicio de sesión
  
  bool isLoggedIn = true;
  AuthViewModel auth = AuthViewModel();
  AppUser? user = await auth.getUserSession();
  if(user == null) {
    isLoggedIn = false;
  } 


  print('isLoggedIn: $isLoggedIn');
  print('User: ${user?.email}');
  print('User: ${user?.canCreateEvents}');


  runApp(   
    MultiProvider(
      providers: appProviders,
      child: DornasApp(isLoggedIn: isLoggedIn),
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
      initialRoute: isLoggedIn ? '/main' : '/',
      routes: appRoutes, // Usa las rutas definidas
    );
  }
}
