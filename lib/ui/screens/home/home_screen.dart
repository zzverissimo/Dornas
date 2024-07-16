import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:dornas_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';

// Pantalla de inicio
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = HomeViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dornas App'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 144, 184, 253),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Georgia'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: 'Historia',
              onPressed: () {
                  viewModel.openURL('https://dornas.es/pdf/historia_dornas.pdf');
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
              fontFamily: 'Inter',
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Guía',
              onPressed: () {
                viewModel.openURL('https://dornas.es/pdf/guia_dornas.pdf');
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
              fontFamily: 'Inter',
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Embarcaciones',
              onPressed: () {
                  viewModel.openURL('https://dornas.es/pdf/embarcaciones_dornas.pdf');
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
              fontFamily: 'Inter',
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Carpintería de ribera',
              onPressed: () {
                  viewModel.openURL('https://dornas.es/pdf/guia_dornas.pdf');
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
              fontFamily: 'Inter',
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Actividades',
              onPressed: () {
                  viewModel.openURL('https://dornas.es/pdf/actividades_dornas.pdf');
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
              fontFamily: 'Inter',
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Enlaces de interés',
              onPressed: () {
                  viewModel.openURL('https://dornas.es/pdf/enlaces_dornas.pdf');
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
              fontFamily: 'Inter',
            ),
          ],
        ),
      ),
    );
  }
}
