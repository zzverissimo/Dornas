import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    required this.width, 
    required this.height, 
    this.color,
    this.borderRadius,
    this.colors,
    this.begin,
    this.end,
    this.stops,
    required this.child,
    super.key,
  });

  final double width;
  final double height;
  final Color? color;
  final BorderRadius? borderRadius;
  final List<Color>? colors;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<double>? stops;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        gradient: colors != null ? LinearGradient(
          colors: colors!,
          stops: stops,
          begin: begin ?? Alignment.centerLeft,
          end: end ?? Alignment.centerRight,
        ) : null,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
