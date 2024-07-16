import 'package:dornas_app/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

// Título de sección de ajustes
class SettingsSectionTitle extends StatelessWidget {
  final String title;

  const SettingsSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 0, 0),
      child: CustomText(
        fontFamily: 'Rubik',
        color: Colors.grey, // Ajusta según el tema
        fontsize: 16,
        letterSpacing: 0,
        text: title,
      ),
    );
  }
}
