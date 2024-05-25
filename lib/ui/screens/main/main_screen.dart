import 'package:dornas_app/ui/screens/calendar/calendar_screen.dart';
import 'package:dornas_app/ui/screens/chat/chat_screen.dart';
import 'package:dornas_app/ui/screens/home/home_screen.dart';
import 'package:dornas_app/ui/screens/map/map_screen.dart';
import 'package:dornas_app/viewmodel/navigation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationViewModel = Provider.of<NavigationViewModel>(context);
    final List<Widget> screens = [
      const HomeScreen(),
      const ChatScreen(),
      const MapScreen(),
      const CalendarScreen(),
    ];

    return Scaffold(
      body: screens[navigationViewModel.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationViewModel.currentIndex,
        onTap: (index) {
          navigationViewModel.setIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }
}