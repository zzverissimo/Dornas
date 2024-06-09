import 'package:dornas_app/ui/screens/calendar/calendar_screen.dart';
import 'package:dornas_app/ui/screens/chat/chat_screen.dart';
import 'package:dornas_app/ui/screens/home/home_screen.dart';
import 'package:dornas_app/ui/screens/map/map_screen.dart';
import 'package:dornas_app/ui/screens/settings/settings_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
      tabController.animateTo(newPage);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        // Handling pop behavior. In this case, it does nothing because canPop is false.
        if (didPop) return;
      },
      child: SafeArea(
        child: Scaffold(
          body: TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: const [
              HomeScreen(),
              MapScreen(),
              CalendarScreen(),
              SettingsScreen(),
              ChatScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: changePage,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
