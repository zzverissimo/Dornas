import 'package:dornas_app/ui/screens/home/home_screen.dart';
import 'package:dornas_app/ui/screens/initialscreen/start_screen.dart';
import 'package:dornas_app/ui/screens/login/login_screen.dart';
import 'package:dornas_app/ui/screens/register/register_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const StartScreen(),
  '/home': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
};
