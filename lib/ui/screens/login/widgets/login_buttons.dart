import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginButtons extends StatelessWidget {
   const LoginButtons({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    
  });

  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB( 0, 0, 0, 16),
          child:CustomButton(
            onPressed: onPressed,
            text: text,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            ),
          ),
      ),
   );
  }
}
