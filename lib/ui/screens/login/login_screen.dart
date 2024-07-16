import 'package:dornas_app/ui/screens/login/widgets/login_buttons.dart';
import 'package:dornas_app/ui/widgets/custom_clipimage.dart';
import 'package:dornas_app/ui/widgets/custom_container.dart';
import 'package:dornas_app/ui/widgets/custom_textformfield.dart';
import 'package:dornas_app/ui/widgets/custom_validators.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pantalla de inicio de sesión
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              children: [
                CustomContainer(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: "Email",
                        validator: emailValidator,
                        autofillHints: const [AutofillHints.email],
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: "Contraseña",
                        validator: passwordValidator,
                        obscureText: true,
                        autofillHints: const [AutofillHints.password],
                      ),
                      const SizedBox(height: 16),
                      if (authViewModel.isLoading)
                        const Center(child: CircularProgressIndicator()),
                      if (!authViewModel.isLoading)
                        LoginButtons(
                          onSignInPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await authViewModel.signIn(
                                emailController.text,
                                passwordController.text,
                              );
                              if (context.mounted) {
                                if (authViewModel.currentUser != null) {
                                  Navigator.pushReplacementNamed(context, '/main');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(authViewModel.errorMessage ?? 'Error al iniciar sesión')),
                                  );
                                }
                              }
                            }
                          },
                          onRegisterPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          onForgotPassPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                final TextEditingController resetEmailController = TextEditingController();
                                return AlertDialog(
                                  title: const Text("Recuperar contraseña"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: resetEmailController,
                                        decoration: const InputDecoration(labelText: "Correo electrónico"),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        await authViewModel.resetPassword(resetEmailController.text);
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(authViewModel.errorMessage ?? 'Revise su correo para restablecer la contraseña.')),
                                          );
                                        }
                                      },
                                      child: const Text("Enviar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },   
                          onGoogleSignInPressed: () async {
                            await authViewModel.signInWithGoogle();
                            if (context.mounted) {
                              if (authViewModel.currentUser != null) {
                                Navigator.pushReplacementNamed(context, '/main');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(authViewModel.errorMessage ?? 'Error al iniciar sesión con Google')),
                                );
                              }
                            }
                          },
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
