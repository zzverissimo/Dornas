import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:dornas_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = HomeViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
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
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
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
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Embarcaciones',
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Carpintería de ribera',
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Actividades',
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Enlaces de interés',
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * 0.9,
              borderRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}
