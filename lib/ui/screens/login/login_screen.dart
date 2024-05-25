import 'package:dornas_app/ui/screens/login/widgets/login_buttons.dart';
import 'package:dornas_app/ui/screens/login/widgets/login_form.dart';
import 'package:dornas_app/ui/screens/register/register_screen.dart';
import 'package:dornas_app/ui/widgets/clip_container.dart';
import 'package:dornas_app/ui/widgets/color_container.dart';
import 'package:dornas_app/ui/widgets/custom_clipimage.dart';
import 'package:dornas_app/ui/widgets/custom_validators.dart';
import 'package:dornas_app/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        backgroundColor: const Color(0xFFBDCBE2),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ColorContainer(
                  width: double.infinity,
                  height: 300,
                  colors: const [
                    Color(0xFF67A5E6),
                    Color(0xFFB6D0E2),
                    Color(0xFFBDCBE2),
                  ],
                  begin: const AlignmentDirectional(0, -1),
                  end: const AlignmentDirectional(0, 1),
                  stops: const [0.0, 0.5, 1.0],
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
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginForm(
                          controller: emailController,
                          textinput: TextInputType.emailAddress,
                          text: "Email",
                          validator: emailValidator,
                          obscureText: false,
                          autofillHints: const [AutofillHints.email],
                        ),
                        LoginForm(
                          controller: passwordController,
                          textinput: TextInputType.visiblePassword,
                          text: "Contraseña",
                          validator: passwordValidator,
                          obscureText: true,
                          autofillHints: const [AutofillHints.password],
                        ),
                        LoginButtons(
                          onPressed: () {
                            authViewModel.signIn(
                                emailController.text, passwordController.text);
                          },
                          text: "Iniciar Sesión",
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        LoginButtons(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            );
                          },
                          text: "Registrarse",
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        LoginButtons(
                          onPressed: () {},
                          text: "Olivdé mi contraseña",
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
