import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Botones de inicio de sesión
class LoginButtons extends StatelessWidget {
  final VoidCallback onSignInPressed;
  final VoidCallback onRegisterPressed;
  final VoidCallback onForgotPassPressed;
  final VoidCallback onGoogleSignInPressed;

  const LoginButtons({
    super.key,
    required this.onSignInPressed,
    required this.onRegisterPressed,
    required this.onForgotPassPressed,
    required this.onGoogleSignInPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onSignInPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Iniciar Sesión"),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRegisterPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.black),
            ),
          ),
          child: const Text("Registrarse"),
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: onGoogleSignInPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.black),
            ),
          ),
          icon: const FaIcon(FontAwesomeIcons.google, color: Colors.black),
          label: const Text(
            "Iniciar sesión con Google",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
