import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:dornas_app/viewmodel/calendar_view_model.dart';
import 'package:dornas_app/viewmodel/chat_view_model.dart';
import 'package:dornas_app/viewmodel/map_view_model.dart';
import 'package:dornas_app/viewmodel/navigation_view_model.dart';
import 'package:dornas_app/viewmodel/settings_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// Define una lista de proveedores para la aplicación
final List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => AuthViewModel()),
  ChangeNotifierProvider(create: (_) => NavigationViewModel()),
  ChangeNotifierProvider(create: (_) => CalendarViewModel()),
  ChangeNotifierProvider(create: (_) => MapViewModel()),
  ChangeNotifierProvider(create: (_) => ChatViewModel()),
  ChangeNotifierProxyProvider<AuthViewModel, SettingsViewModel>(
    create: (context) => SettingsViewModel(authViewModel: Provider.of<AuthViewModel>(context, listen: false)),
    update: (context, authViewModel, settingsViewModel) =>
        settingsViewModel ?? SettingsViewModel(authViewModel: authViewModel),
  ),
];
