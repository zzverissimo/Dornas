import 'package:dornas_app/ui/screens/calendar/calendar_screen.dart';
import 'package:dornas_app/ui/screens/chat/chat_screen.dart';
import 'package:dornas_app/ui/screens/home/home_screen.dart';
import 'package:dornas_app/ui/screens/map/map_screen.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  final Map<String, Widget> tabs = {
    'home_page': const HomeScreen(),
    'calendar_page': const CalendarScreen(),
    'map_page': const MapScreen(),
    'chat_page': const ChatScreen(),
  };
  String _currentPageName = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentPageName],
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: tabs.keys.toList().indexOf(_currentPageName),
        onTap: (index) {
          setState(() {
            _currentPageName = tabs.keys.toList()[index];
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color(0x9FD1C3C3),
        selectedBackgroundColor: const Color(0x00000000),
        borderRadius: 15.0,
        itemBorderRadius: 8.0,
        margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
        width: 300.0,
        elevation: 0.0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_filled,
                  color: _currentPageName == 'home_page' ? Colors.black : const Color(0x9FD1C3C3),
                  size: 20.0,
                ),
                const Text(
                  'Menú',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 10.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  color: _currentPageName == 'calendar_page' ? Colors.black : const Color(0x9FD1C3C3),
                  size: 20.0,
                ),
                const Text(
                  'Calendario',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 10.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  color: _currentPageName == 'map_page' ? Colors.black : const Color(0x9FD1C3C3),
                  size: 20.0,
                ),
                const Text(
                  'Mapa',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 10.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat,
                  color: _currentPageName == 'chat_page' ? Colors.black : const Color(0x9FD1C3C3),
                  size: 20.0,
                ),
                const Text(
                  'Chat',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 10.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
