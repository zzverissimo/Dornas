import 'package:dornas_app/ui/screens/register/constants.dart';
import 'package:dornas_app/ui/screens/register/gradient_text.dart';
import 'package:dornas_app/ui/widgets/clip_container.dart';
import 'package:dornas_app/ui/widgets/color_container.dart';
import 'package:dornas_app/ui/widgets/custom_clipimage.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

   @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {

  // final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => _model.unfocusNode.canRequestFocus
      //     ? FocusScope.of(context).requestFocus(_model.unfocusNode)
      //     : FocusScope.of(context).unfocus(),
      child: Scaffold(
        // key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                      child: GradientText(
                        'Crear cuenta',
                        colors: [//MIRAR BIEN LO DE LOS COLORES
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.emailAddressTextController1,
                          focusNode: _model.emailAddressFocusNode1,
                          autofocus: true,
                          autofillHints: [AutofillHints.email],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  letterSpacing: 0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsets.all(24),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Rubik',
                                    letterSpacing: 0,
                                  ),
                          keyboardType: TextInputType.emailAddress,
                          validator: _model.emailAddressTextController1Validator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          // controller: _model.emailAddressTextController2,
                          // focusNode: _model.emailAddressFocusNode2,
                          autofocus: true,
                          autofillHints: [AutofillHints.email],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  letterSpacing: 0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsets.all(24),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Rubik',
                                    letterSpacing: 0,
                                  ),
                          keyboardType: TextInputType.emailAddress,
                          validator: _model.emailAddressTextController2Validator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.emailAddressTextController3,
                          focusNode: _model.emailAddressFocusNode3,
                          autofocus: true,
                          autofillHints: [AutofillHints.email],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  letterSpacing: 0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsets.all(24),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Rubik',
                                    letterSpacing: 0,
                                  ),
                          keyboardType: TextInputType.emailAddress,
                          validator: _model.emailAddressTextController3Validator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.emailAddressTextController4,
                          focusNode: _model.emailAddressFocusNode4,
                          autofocus: true,
                          autofillHints: [AutofillHints.email],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Repite contraseña',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  letterSpacing: 0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsets.all(24),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Rubik',
                                    letterSpacing: 0,
                                  ),
                          keyboardType: TextInputType.emailAddress,
                          validator: _model.emailAddressTextController4Validator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Registrarse',
                    options: FFButtonOptions(
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Rubik',
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 0,
                              ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
