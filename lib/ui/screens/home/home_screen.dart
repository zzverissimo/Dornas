import 'package:dornas_app/ui/screens/home/pdfViewer_screen.dart';
import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:dornas_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homepdf = HomeViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        centerTitle: true, // Centra el título
        automaticallyImplyLeading: false, // Elimina el botón leading
        backgroundColor: Colors.blueGrey, // Cambia el color de la AppBar a gris azulado
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: 'Historia',
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,  // Más ancho
              borderRadius: 8,  // Esquinas más cuadradas
            ),
            const SizedBox(height: 16),  // Más espacio entre botones
            CustomButton(
              text: 'Guía',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PdfViewerScreen(pdfPath: 'assets/documents/guia_dornas.pdf'),
                  ),
                );
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,  // Más ancho
              borderRadius: 8,  // Esquinas más cuadradas
            ),
            const SizedBox(height: 16),  // Más espacio entre botones
            CustomButton(
              text: 'Embarcaciones',
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,  // Más ancho
              borderRadius: 8,  // Esquinas más cuadradas
            ),
            const SizedBox(height: 16),  // Más espacio entre botones
            CustomButton(
              text: 'Carpintería de ribera',
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,  // Más ancho
              borderRadius: 8,  // Esquinas más cuadradas
            ),
            const SizedBox(height: 16),  // Más espacio entre botones
            CustomButton(
              text: 'Actividades',
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,  // Más ancho
              borderRadius: 8,  // Esquinas más cuadradas
            ),
            const SizedBox(height: 16),  // Más espacio entre botones
            CustomButton(
              text: 'Enlaces de interés',
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,  // Más ancho
              borderRadius: 8,  // Esquinas más cuadradas
            ),
          ],
        ),
      ),
    );
  }
}
