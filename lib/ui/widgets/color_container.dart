import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  const ColorContainer({
    required this.width, 
    required this.height, 
    required this.colors,
    required this.begin,
    required this.end,
    required this.stops,
    required this.child,
    super.key}) ;

  final double width;
  final double height;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;
  final List<double> stops;
  final Widget child;

  @override
  Widget build(context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          stops: stops,
          begin: begin,
          end: end,
        )
      ),
      child: child
    );
  }
}

