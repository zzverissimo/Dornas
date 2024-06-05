import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RegisterButtons extends StatelessWidget {
  final VoidCallback onRegisterPressed;

  const RegisterButtons({
    super.key,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomButton(
          onPressed: onRegisterPressed,
          text: "Registrarse",
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          width: width * 0.9,  // Más ancho
        ),
      ],
    );
  }
}
