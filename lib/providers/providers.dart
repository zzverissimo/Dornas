import 'package:dornas_app/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => AuthViewModel()),
  // Agrega otros proveedores aquí si los necesitas
];
