import 'package:dornas_app/viewmodel/login_view_model.dart';
import 'package:dornas_app/viewmodel/navigation_view_model.dart';
import 'package:dornas_app/viewmodel/register_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => AuthViewModel()),
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => NavigationViewModel()),
  // Agrega otros proveedores aquí si los necesitas
];
