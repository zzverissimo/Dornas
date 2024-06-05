import 'package:dornas_app/ui/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.emailValidator,
    required this.passwordValidator,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          labelText: "Email",
          validator: emailValidator,
          autofillHints: const [AutofillHints.email],
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          labelText: "Contraseña",
          validator: passwordValidator,
          obscureText: true,
          autofillHints: const [AutofillHints.password],
        ),
      ],
    );
  }
}
