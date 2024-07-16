import 'package:dornas_app/ui/screens/settings/editProfile_screen.dart';
import 'package:dornas_app/ui/screens/settings/widgets/settings_buttons.dart';
import 'package:dornas_app/ui/screens/settings/widgets/settings_header.dart';
import 'package:dornas_app/ui/screens/settings/widgets/settings_options.dart';
import 'package:dornas_app/ui/screens/settings/widgets/settings_title.dart';
import 'package:dornas_app/ui/widgets/custom_text.dart';
import 'package:dornas_app/viewmodel/home_view_model.dart';
import 'package:dornas_app/viewmodel/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pantalla de ajustes
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenWidgetState();
}

class _SettingsScreenWidgetState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final settingsViewModel = Provider.of<SettingsViewModel>(context);
    final user = settingsViewModel.currentUser;
    final HomeViewModel viewModel = HomeViewModel();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsHeader(photoUrl: user?.photoUrl),
            if (user != null) ...[
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                child: CustomText(
                  fontFamily: 'Rubik',
                  color: Colors.black,
                  fontsize: 24,
                  letterSpacing: 0,
                  text: user.displayName ?? 'Usuario',
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 0, 16),
                child: CustomText(
                  fontFamily: 'Rubik',
                  color: Colors.grey,
                  fontsize: 16,
                  letterSpacing: 0,
                  text: user.email,
                ),
              ),
            ],
            const SettingsSectionTitle(title: 'Tu cuenta'),
            SettingsOption(
              icon: Icons.account_circle_outlined,
              text: 'Editar Perfil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfileScreen()),
                );
              },
            ),
            const SettingsSectionTitle(title: 'Ajustes'),
            SettingsOption(
              icon: Icons.help_outline_rounded,
              text: 'Soporte',
              onTap: () {
                  viewModel.openURL('https://dornas.es/pdf/soporte_dornas.pdf');
              },
            ),
            SettingsOption(
              icon: Icons.privacy_tip_rounded,
              text: 'Términos de Servicio',
              onTap: () {
                  viewModel.openURL('https://dornas.es/pdf/terminos_dornas.pdf');
              },
            ),
            SettingsLogoutButton(
              onPressed: () => settingsViewModel.signOut(context),
            ),
            SettingsDeleteAccountButton(
              onPressed: () => settingsViewModel.deleteAccount(context),
            ),
          ],
        ),
      ),
    );
  }
}
