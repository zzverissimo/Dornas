import 'package:flutter/material.dart';

// Botón personalizado
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.width = double.infinity,
    this.height = 50,
    this.elevation = 2,
    this.borderRadius = 8,  // Cambiado a 8 para esquinas más cuadradas
    this.borderSide = const BorderSide(color: Colors.transparent),
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.fontFamily = 'Plus Jakarta Sans',
    super.key,
  });

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double width;
  final double height;
  final double elevation;
  final double borderRadius;
  final BorderSide borderSide;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: EdgeInsets.zero,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSide,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
