import 'dart:io';

import 'package:dornas_app/ui/screens/register/widgets/gradient_text.dart';
import 'package:dornas_app/ui/screens/register/widgets/register_buttons.dart';
import 'package:dornas_app/ui/widgets/custom_clipimage.dart';
import 'package:dornas_app/ui/widgets/custom_container.dart';
import 'package:dornas_app/ui/widgets/custom_textformfield.dart';
import 'package:dornas_app/ui/widgets/custom_validators.dart';
import 'package:dornas_app/ui/widgets/user_image_picker.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  String? _imageError;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFBDCBE2),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomContainer(
                  width: double.infinity,
                  height: 200,
                  colors: const [
                    Color(0xFF67A5E6),
                    Color(0xFFB6D0E2),
                    Color(0xFFBDCBE2),
                  ],
                  begin: const AlignmentDirectional(0, -1),
                  end: const AlignmentDirectional(0, 1),
                  stops: const [0.0, 0.5, 1.0],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                        width: 80,
                        height: 80,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        child: CustomClip(
                          borderRadius: BorderRadius.circular(16),
                          imagePath: 'assets/images/logo_dorna.jpg',
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: GradientText(
                            'Crear cuenta',
                            colors: [
                              Color.fromARGB(255, 11, 58, 134),
                              Color.fromARGB(255, 9, 119, 236),
                            ],
                            gradientType: GradientType.radial,
                            radius: 3,
                            fontFamily: 'Rubik',
                            fontsize: 32,
                            letterSpacing: 0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: UserImagePicker(onImagePicked: (pickedImage) {
                            setState(() {
                              _selectedImage = pickedImage;
                              _imageError = null; // Clear error message
                            });
                          }),
                        ),
                        if (_imageError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _imageError!,
                              style: const TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: nameController,
                          labelText: 'Nombre',
                          keyboardType: TextInputType.name,
                          autofocus: true,
                          autofillHints: const [AutofillHints.name],
                          validator: nameValidator,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: emailController,
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: emailValidator,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: passwordController,
                          labelText: 'Contraseña',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          autofillHints: const [AutofillHints.password],
                          validator: passwordValidator,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          labelText: 'Repite contraseña',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          autofillHints: const [AutofillHints.password],
                          validator: (value) => confirmPasswordValidator(value, passwordController.text),
                        ),
                        const SizedBox(height: 32),
                        if (authViewModel.isLoading)
                          const Center(child: CircularProgressIndicator()),
                        if (!authViewModel.isLoading)
                          RegisterButtons(
                            onRegisterPressed: () async {
                              if (_formKey.currentState!.validate() && _selectedImage != null) {
                                await authViewModel.signUp(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text,
                                  _selectedImage!.path,
                                  false,
                                );
                                if (context.mounted) {
                                  if (authViewModel.currentUser != null) {
                                    Navigator.pushReplacementNamed(context, '/main');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(authViewModel.errorMessage ?? 'Error al registrar')),
                                    );
                                  }
                                }
                              } else {
                                setState(() {
                                  _imageError = _selectedImage == null ? 'Por favor, añade una imagen.' : null;
                                });
                              }
                            },
                          ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
