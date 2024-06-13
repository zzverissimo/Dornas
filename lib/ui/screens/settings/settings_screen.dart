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
    final user = authViewModel.currentUser;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsHeader(),
            if (user != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: user.photoUrl != null
                      ? NetworkImage(user.photoUrl!)
                      : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                ),
              ),
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
