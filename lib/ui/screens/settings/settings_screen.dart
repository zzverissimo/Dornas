import 'package:dornas_app/ui/screens/settings/widgets/settings_buttons.dart';
import 'package:dornas_app/ui/screens/settings/widgets/settings_header.dart';
import 'package:dornas_app/ui/screens/settings/widgets/settings_options.dart';
import 'package:dornas_app/ui/screens/settings/widgets/settings_title.dart';
import 'package:dornas_app/ui/widgets/custom_text.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenWidgetState();
}

class _SettingsScreenWidgetState extends State<SettingsScreen>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsHeader(),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
              child: CustomText(
                fontFamily: 'Rubik',
                color: Colors.black, // Ajusta según el tema
                fontsize: 24,
                letterSpacing: 0,
                text: 'Andrew D.',
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 16),
              child: CustomText(
                fontFamily: 'Rubik',
                color: Colors.grey, // Ajusta según el tema
                fontsize: 16,
                letterSpacing: 0,
                text: 'andrew@domainname.com',
              ),
            ),
            const SettingsSectionTitle(title: 'Your Account'),
            SettingsOption(
              icon: Icons.account_circle_outlined,
              text: 'Edit Profile',
              onTap: () {
                // Acción para editar perfil
              },
            ),
            SettingsOption(
              icon: Icons.notifications_none,
              text: 'Notification Settings',
              onTap: () {
                // Acción para configuración de notificaciones
              },
            ),
            const SettingsSectionTitle(title: 'App Settings'),
            SettingsOption(
              icon: Icons.help_outline_rounded,
              text: 'Support',
              onTap: () {
                // Acción para soporte
              },
            ),
            SettingsOption(
              icon: Icons.privacy_tip_rounded,
              text: 'Terms of Service',
              onTap: () {
                // Acción para términos de servicio
              },
            ),
            if (authViewModel.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (!authViewModel.isLoading)
              SettingsLogoutButton(
                onPressed: () async {
                  await authViewModel.signOut();
                  if (context.mounted) {
                    if (authViewModel.errorMessage == null) {
                      Navigator.pushReplacementNamed(context, '/start');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(authViewModel.errorMessage ?? 'Error al cerrar sesión')),
                      );
                    }
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
