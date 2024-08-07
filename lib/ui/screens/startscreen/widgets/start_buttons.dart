import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// Botones de inicio
class StartButtons extends StatelessWidget {
  final VoidCallback onSignInPressed;
  final VoidCallback onRegisterPressed;

  const StartButtons({super.key, required this.onSignInPressed, required this.onRegisterPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        direction: Axis.horizontal,
        runAlignment: WrapAlignment.start,
        verticalDirection: VerticalDirection.down,
        clipBehavior: Clip.none,
        children: [
          CustomButton(
            text: "Iniciar Sesión",
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            onPressed: onSignInPressed,
          ),
          CustomButton(
            text: "Registrarse",
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            onPressed: onRegisterPressed,
          ),
        ],
      ),
    );
  }
}
