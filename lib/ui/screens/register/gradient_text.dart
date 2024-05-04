// import 'package:dornas_app/ui/screens/register/constants.dart';
// import 'package:dornas_app/ui/widgets/custom_text.dart';
// import 'package:flutter/material.dart';

// class GradientText extends StatelessWidget {

//   final List<Color> colors;
//   final GradientDirection? gradientDirection;
//   final GradientType gradientType;
//   final TextOverflow? overflow;
//   final double radius;
//   final TextStyle? style;
//   final String text;
//   final TextAlign? textAlign;
//   final String fontFamily = 'Rubik';
//   final double fontsize = 20.0;
//   final double letterSpacing = 1.0;

//   const GradientText(
//     this.text, {
//     super.key,
//     required this.colors,
//     this.gradientDirection = GradientDirection.ltr,
//     this.gradientType = GradientType.linear,
//     this.overflow,
//     this.radius = 1.0,
//     this.style,
//     this.textAlign,
//   });

//   @override
//   Widget build(final BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (final Rect bounds) {
//         switch (gradientType) {
//           case GradientType.linear:
//             final Map<String, Alignment> map = {};
//             switch (gradientDirection) {
//               case GradientDirection.rtl:
//                 map['begin'] = Alignment.centerRight;
//                 map['end'] = Alignment.centerLeft;
//                 break;
//               case GradientDirection.ttb:
//                 map['begin'] = Alignment.topCenter;
//                 map['end'] = Alignment.bottomCenter;
//                 break;
//               case GradientDirection.btt:
//                 map['begin'] = Alignment.bottomCenter;
//                 map['end'] = Alignment.topCenter;
//                 break;
//               default:
//                 map['begin'] = Alignment.centerLeft;
//                 map['end'] = Alignment.centerRight;
//                 break;
//             }
//             return LinearGradient(
//               begin: map['begin']!,
//               colors: colors,
//               end: map['end']!,
//             ).createShader(bounds);
//           case GradientType.radial:
//             return RadialGradient(
//               colors: colors,
//               radius: radius,
//             ).createShader(bounds);
//         }
//       },
//       child: StyleText(fontFamily: fontFamily, fontsize: fontsize, letterSpacing: letterSpacing, text: text)
//     );
//   }
// }



