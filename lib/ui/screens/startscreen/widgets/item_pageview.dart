import 'package:dornas_app/ui/widgets/custom_clipimage.dart';
import 'package:dornas_app/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

// Vista de página de artículo
class ItemPageView extends StatelessWidget {
  const ItemPageView({
    required this.imagePath,
    required this.text1, 
    required this.text2,
    this.borderRadius = 12,
    this.text1FontSize = 32,
    this.text1FontWeight = FontWeight.w600,
    this.text1Color = const Color(0xFF101213),
    this.text2FontSize = 16,
    this.text2FontWeight = FontWeight.w500,
    this.text2Color = const Color(0xFF57636C),
    this.text1FontFamily = 'Urbanist',
    this.text2FontFamily = 'Plus Jakarta Sans',
    this.text1LetterSpacing = 0,
    this.text2LetterSpacing = 0,
    super.key,
  });

  final String imagePath;
  final String text1;
  final String text2;
  final double borderRadius;
  final String text1FontFamily;
  final String text2FontFamily;
  final double text1FontSize;
  final double text2FontSize;
  final FontWeight text1FontWeight;
  final FontWeight text2FontWeight;
  final Color text1Color;
  final Color text2Color;
  final double text1LetterSpacing;
  final double text2LetterSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
              child: CustomClip(
                borderRadius: BorderRadius.circular(borderRadius),
                imagePath: imagePath,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
            child: CustomText(
              fontFamily: text1FontFamily, 
              color: text1Color, 
              fontsize: text1FontSize, 
              letterSpacing: text1LetterSpacing, 
              fontWeight: text1FontWeight, 
              text: text1
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
            child: CustomText(
              fontFamily: text2FontFamily,
              color: text2Color,
              fontsize: text2FontSize,
              letterSpacing: text2LetterSpacing,
              fontWeight: text2FontWeight,
              text: text2
            ),
          ),
        ],
      ),
    );
  }
}
