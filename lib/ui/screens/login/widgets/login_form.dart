
import 'package:dornas_app/ui/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.textinput,
    required this.text,
    required this.validator,
    required this.obscureText,
    required this.autofillHints,
    super.key});

  final TextInputType textinput;
  final String text;
  final String? Function(String?) validator;
  final bool obscureText;
  final List<String> autofillHints;


  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
       child: SizedBox(
        width: double.infinity,
        child: CustomTextFormField(
          labelText: text,
          obscureText: obscureText,
          keyboardType: textinput,
          autofillHints: autofillHints,
          validator: validator,
        ),
      ),
    );
  }
}
