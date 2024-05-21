import 'package:dornas_app/ui/screens/register/widgets/constants.dart';
import 'package:dornas_app/ui/screens/register/widgets/gradient_text.dart';
import 'package:dornas_app/ui/screens/register/widgets/register_form.dart';
import 'package:dornas_app/ui/widgets/clip_container.dart';
import 'package:dornas_app/ui/widgets/color_container.dart';
import 'package:dornas_app/ui/widgets/custom_button.dart';
import 'package:dornas_app/ui/widgets/custom_clipimage.dart';
import 'package:dornas_app/ui/widgets/custom_validators.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorContainer(
              width: double.infinity,
              height: 300,
              colors: const [Color(0xFF67A5E6), Color(0xFFBDCBE2), Color(0xFFB6D0E2)],
              begin: const AlignmentDirectional(0.1, -1),
              end: const AlignmentDirectional(-0.1, 1),
              stops: const [0, 0.5, 1],
              child: ColorContainer(
                width: 100,
                height: 100,
                colors: const [Color(0x4c2797ff), Colors.white],
                begin: const AlignmentDirectional(0, -1),
                end: const AlignmentDirectional(0, -1),
                stops: const [0, 1],
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipContainer(
                      width: 100,
                      height: 100,
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
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                      child: GradientText(
                        'Crear cuenta',
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).secondaryHeaderColor,
                        ],
                        gradientType: GradientType.radial,
                        radius: 3,
                        fontFamily: 'Rubik',
                        fontsize: 32,
                        letterSpacing: 0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: RegisterForm(
                        controller: nameController,
                        width: double.infinity,
                        labelText: 'Nombre',
                        keyboardType: TextInputType.name,
                        autofocus: true,
                        autofillHints: [AutofillHints.name],
                        obscureText: false,
                        fontFamily: 'Rubik',
                        validator: nameValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: RegisterForm(
                        controller: emailController,
                        width: double.infinity,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        autofillHints: const [AutofillHints.email],
                        obscureText: false,
                        fontFamily: 'Rubik',
                        validator: emailValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: RegisterForm(
                        controller: passwordController,
                        width: double.infinity,
                        labelText: 'Contraseña',
                        keyboardType: TextInputType.visiblePassword,
                        autofocus: false,
                        autofillHints: const [AutofillHints.password],
                        obscureText: true,
                        fontFamily: 'Rubik',
                        validator: passwordValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: RegisterForm(
                        controller: confirmPasswordController,
                        width: double.infinity,
                        labelText: 'Repite contraseña',
                        keyboardType: TextInputType.visiblePassword,
                        autofocus: false,
                        autofillHints: const [AutofillHints.password],
                        obscureText: true,
                        fontFamily: 'Rubik',
                        validator: passwordValidator,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () async {
                      if (passwordController.text == confirmPasswordController.text) {
                        await authViewModel.signUp(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                        );
                        if (authViewModel.currentUser != null && mounted) {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      } else {
                        authViewModel.setMessage('Passwords do not match');
                      }
                    },
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    text: 'Registrarse',
                  ),
                ],
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
