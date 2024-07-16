import 'package:dornas_app/ui/screens/calendar/allevents_screen.dart';
import 'package:dornas_app/ui/screens/calendar/calendar_screen.dart';
import 'package:dornas_app/ui/screens/chat/chat_screen.dart';
import 'package:dornas_app/ui/screens/home/home_screen.dart';
import 'package:dornas_app/ui/screens/login/login_screen.dart';
import 'package:dornas_app/ui/screens/main/main_screen.dart';
import 'package:dornas_app/ui/screens/map/map_screen.dart';
import 'package:dornas_app/ui/screens/register/register_screen.dart';
import 'package:dornas_app/ui/screens/settings/settings_screen.dart';
import 'package:dornas_app/ui/screens/startscreen/start_screen.dart';
import 'package:flutter/material.dart';

// Define las rutas de la aplicación
final Map<String, WidgetBuilder> appRoutes = {
  '/start': (context) => const StartScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/main': (context) => const MainScreen(),
  '/home': (context) => const HomeScreen(),
  '/map': (context) => const MapScreen(),
  '/calendar': (context) => const CalendarScreen(),
  '/settings': (context) => const SettingsScreen(),
  '/chat': (context) => const ChatScreen(),
  '/events': (context) => const AllEventsScreen(),

};
