import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SettingsLogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingsLogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
        child: CustomButton(
          onPressed: onPressed,
          text: 'Log Out',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          width: 150,
          height: 44,
          borderRadius: 38,
        ),
      ),
    );
  }
}
