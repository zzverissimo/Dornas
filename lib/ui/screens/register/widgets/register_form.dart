import 'package:dornas_app/ui/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    this.width = double.infinity,
    this.height,
    this.controller,
    required this.labelText,
    this.fontFamily = 'Rubik',
    required this.keyboardType,
    this.validator,
    this.onSaved,
    this.focusNode,
    this.autofocus = false,
    this.autofillHints,
    this.obscureText = false,
    super.key,
  });

  final double width;
  final double? height;
  final TextEditingController? controller;
  final String labelText;
  final String fontFamily;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final FocusNode? focusNode;
  final bool autofocus;
  final Iterable<String>? autofillHints;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomTextFormField(
        controller: controller,
        labelText: labelText,
        fontFamily: fontFamily,
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
        focusNode: focusNode,
        autofocus: autofocus,
        autofillHints: autofillHints,
        obscureText: obscureText,
      ),
    );
  }
}
