import 'package:dornas_app/ui/screens/login/widgets/login_buttons.dart';
import 'package:dornas_app/ui/screens/login/widgets/login_form.dart';
import 'package:dornas_app/ui/widgets/clip_container.dart';
import 'package:dornas_app/ui/widgets/color_container.dart';
import 'package:dornas_app/ui/widgets/custom_clipimage.dart';
import 'package:dornas_app/ui/widgets/custom_validators.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // final _emailKey = GlobalKey<FormState>();
  // final _passwordKey = GlobalKey<FormState>();

  // var _enteredEmail = '';
  // var _enteredPassword = '';

  // final animationsMap = {
  //   'containerOnPageLoadAnimation': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     effects: [
  //       VisibilityEffect(duration: 1.ms),
  //       FadeEffect(
  //         curve: Curves.easeInOut,
  //         delay: 0.ms,
  //         duration: 300.ms,
  //         begin: 0,
  //         end: 1,
  //       ),
  //       ScaleEffect(
  //         curve: Curves.bounceOut,
  //         delay: 0.ms,
  //         duration: 300.ms,
  //         begin: const Offset(0.6, 0.6),
  //         end: const Offset(1, 1),
  //       ),
  //     ],
  //   ),
  //   'columnOnPageLoadAnimation': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     effects: [
  //       FadeEffect(
  //         curve: Curves.easeInOut,
  //         delay: 200.ms,
  //         duration: 400.ms,
  //         begin: 0,
  //         end: 1,
  //       ),
  //       MoveEffect(
  //         curve: Curves.easeInOut,
  //         delay: 200.ms,
  //         duration: 400.ms,
  //         begin: const Offset(0, 60),
  //         end: const Offset(0, 0),
  //       ),
  //       TiltEffect(
  //         curve: Curves.easeInOut,
  //         delay: 200.ms,
  //         duration: 400.ms,
  //         begin: const Offset(-0.349, 0),
  //         end: const Offset(0, 0),
  //       ),
  //     ],
  //   ),
  // };

  // void _submit(){
  //  final isValidEmail = _emailKey.currentState!.validate();
  //  final isValidPassword = _passwordKey.currentState!.validate();

  //  if(isValidEmail){
  //    _emailKey.currentState!.save();
  //    print(_enteredEmail);
  //  }
  //   if(isValidPassword){
  //    _passwordKey.currentState!.save();
  //    print(_enteredPassword);
  //  }

  // }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return MaterialApp(
      /*onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),*/
      home: Scaffold(
        // key: scaffoldKey,
        backgroundColor: Colors.white,
        //SOLUCIONAR LO DEL COLOR y AÑADIRLE LA ANIMACIÓN
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ColorContainer(
              width: double.infinity,
              height: 300,
              colors: const [
                Color(0xFF67A5E6),
                Color(0xFFBDCBE2),
                Color(0xFFB6D0E2)
              ],
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
                              fit: BoxFit.cover)),
                    ]),
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
                          autofillHints: const [AutofillHints.email]),
                      LoginForm(
                          controller: passwordController,
                          textinput: TextInputType.visiblePassword,
                          text: "Contraseña",
                          validator: passwordValidator,
                          obscureText: true,
                          autofillHints: const [AutofillHints.password]),
                      LoginButtons(
                          onPressed: () {
                            authViewModel.signIn(
                                emailController.text, passwordController.text);
                          },
                          text: "Iniciar Sesión",
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white),
                      LoginButtons(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          text: "Registrarse",
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black),
                      LoginButtons(
                        onPressed: () {},
                        text: "Olivdé mi contraseña",
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      // Column(

                      // ),
                    ],
                  )
                  // .animateOnPageLoad(
                  //     animationsMap['columnOnPageLoadAnimation']!),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
