import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  
  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.size = const Size(150, 50),
    this.elevation = 2,
    this.borderRadius = 50,
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
  final Size size;
  final double elevation;
  final double borderRadius;
  final BorderSide borderSide;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: size,
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
    );
  }
}
