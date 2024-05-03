import 'package:flutter/material.dart';

class CustomClip extends StatelessWidget {
  const CustomClip({
    required this.borderRadius,
    required this.imagePath,
    required this.width,
    required this.height,
    required this.fit,
    super.key}) ;

  final BorderRadius borderRadius;
  final String imagePath;
  final BoxFit fit;
  final double width;
  final double height;

  @override
  Widget build(context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit
      )
    );
  }
}
