import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier with WidgetsBindingObserver {
  BaseViewModel() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      onPause();
    } else if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }


  void onPause() {
    // Implementa la lógica para manejar el estado al pausar
  }

  void onResume() {
    // Implementa la lógica para manejar el estado al reanudar
  }
}
