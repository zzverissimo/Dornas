import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginButtons extends StatelessWidget {
  final VoidCallback onSignInPressed;
  final VoidCallback onRegisterPressed;
  final VoidCallback onForgotPassPressed;

  const LoginButtons({
    super.key,
    required this.onSignInPressed,
    required this.onRegisterPressed,
    required this.onForgotPassPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16), 
        CustomButton(
          onPressed: onSignInPressed,
          text: "Iniciar Sesión",
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          width: MediaQuery.of(context).size.width * 0.9,  // Más ancho
          borderRadius: 8,  // Esquinas más cuadradas
        ),
        const SizedBox(height: 16),  // Más espacio entre botones
        CustomButton(
          onPressed: onRegisterPressed,
          text: "Registrarse",
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          width: MediaQuery.of(context).size.width * 0.9,  // Más ancho
          borderRadius: 8,  // Esquinas más cuadradas
        ),
        const SizedBox(height: 16),  // Más espacio entre botones
        TextButton(
          onPressed: onForgotPassPressed,
          child: const Text(
            "Olvidé mi contraseña",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
