import 'package:dornas_app/ui/widgets/custom_container.dart';
import 'package:dornas_app/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

// Opción de ajustes
class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const SettingsOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: GestureDetector(
        onTap: onTap,
        child: CustomContainer(
          width: double.infinity,
          height: 60,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(icon, size: 24),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: CustomText(
                    fontFamily: 'Rubik',
                    color: Colors.black, // Ajusta según el tema
                    fontsize: 16,
                    letterSpacing: 0,
                    text: text,
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.9, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
