import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText extends StatelessWidget {
  const StyleText({
    required this.fontFamily,
    required this.color, 
    required this.fontsize,
    required this.letterSpacing,
    required this.fontWeight,
    required this.text,
    super.key,
  });

  final String fontFamily;
  final String text;
  final Color color;
  final double fontsize;
  final double letterSpacing;
  final FontWeight fontWeight;

  @override
  Widget build(context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        fontFamily,
        textStyle: TextStyle(
        color: color,
        fontSize: fontsize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
        )
      ),
    );
  }
}