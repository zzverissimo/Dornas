import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

@override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

  class _AuthScreenState extends State<AuthScreen> {

    var _isLogin = true;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    left: 20,
                    right: 20
                    ),
                    width: 200,
                    child: Image.asset('assets/images/foto_dornas.jpg') ,
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email Address'),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Password'),
                                keyboardType: TextInputType.visiblePassword,
                               obscureText: true ,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                
                              },
                              child: Text(_isLogin ? 'Login' : 'Sign Up'),
                            ),
                            TextButton(
                              onPressed: () {
                                _isLogin = !_isLogin;
                              },
                              child: Text(_isLogin ? 'Create an account' : 'I already have an account'),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                )
              ]
            ),
          ),
        ),
      );
    }
  }
