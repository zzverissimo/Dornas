import 'package:dornas_app/ui/screens/startscreen/widgets/start_buttons.dart';
import 'package:dornas_app/ui/screens/startscreen/widgets/widget_pageview.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);  // Inicializa el PageController
  }

  @override
  void dispose() {
    _pageController.dispose();  // Libera el PageController cuando el estado se destruya
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Evita que el usuario pueda hacer marcha atrás
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: WidgetPageView(controller: _pageController),
              ),
              StartButtons(
                onSignInPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                onRegisterPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
