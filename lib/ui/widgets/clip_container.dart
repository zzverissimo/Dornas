import 'package:flutter/material.dart';

class ClipContainer extends StatelessWidget {
  const ClipContainer({
    required this.width, 
    required this.height, 
    required this.color,
    required this.borderRadius,
    required this.child,
    super.key}) ;

  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;
  final Widget child;

  @override
  Widget build(context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius 
      ),
      child: child
      );
  }
}
