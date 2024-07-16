import 'package:dornas_app/ui/screens/startscreen/widgets/item_pageview.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart' as smooth_page_indicator;

// Vista de página de widgets
class WidgetPageView extends StatelessWidget {
  final PageController controller;

  const WidgetPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
          child: PageView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            children: const [
             ItemPageView(imagePath: 'assets/images/foto_dorna.jpg', text1: 'Dornas', text2: 'Sin rumbo, sin preocupaciones.'),
             ItemPageView(imagePath: 'assets/images/atardecer_dorna.jpg', text1: 'Atardeceres', text2:  'A Illa de arousa tiene puestas de sol de ensueño'),
             ItemPageView(imagePath: 'assets/images/tradicion_dorna.jpg', text1: 'Tradición', text2: 'En el pasado se hacía uso de estas embarcaciones para pescar.'),
             ItemPageView(imagePath: 'assets/images/regatas_dorna.jpg', text1: 'Regatas', text2: 'Realizamos regatas alrededor de la isla'),
             ItemPageView(imagePath: 'assets/images/cursos_dorna.jpg', text1: 'Cursos', text2: 'Realizamos cursos de reparación de dornas e carpintería'),
             ItemPageView(imagePath: 'assets/images/somos_dorna.jpg', text1: 'Quiénes somos', text2: 'Somos una asociación sin  ánimo de lucro que se dedica a recuperar embarcaciones y navegar por la ría de Arousa.'),
            ],
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, 1),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: smooth_page_indicator.SmoothPageIndicator(
              controller: controller,
              count: 6,
              axisDirection: Axis.horizontal,
              effect: const smooth_page_indicator.ExpandingDotsEffect(
                expansionFactor: 2,
                spacing: 8,
                radius: 16,
                dotWidth: 16,
                dotHeight: 4,
                dotColor: Color(0xFFE0E3E7),
                activeDotColor: Color(0xFF101213),
                paintStyle: PaintingStyle.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
