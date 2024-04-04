// import 'package:firebase_application_1/services/auth.dart';
// import 'package:flutter/material.dart';

// class SignIn extends StatefulWidget {
//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {

//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown[100],
//       appBar: AppBar(
//         backgroundColor: Colors.brown[400],
//         elevation: 0.0,
//         title: Text('Sign in to Brew Crew'),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//         child: ElevatedButton(
//           child: Text('sign in anon'),
//           onPressed: () async {
//             dynamic result = await _auth.signInAnon();
//             if(result == null){
//               print('error signing in');
//             } else {
//               print('signed in');
//               print(result);
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:new_money/services/auth.dart';
import 'package:new_money/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool load = false;
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String error = '';

  @override
  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            backgroundColor: const Color.fromRGBO(215, 204, 200, 1),
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign in to Brew Crew'),
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller:
                          emailController, // supply the email controller
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      controller:
                          passwordController, // supply the password controller
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      // style: ElevatedButton.styleFrom(color: Colors.pink[400]),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Color.fromARGB(255, 17, 7, 7)),
                      ),
                      onPressed: () async {
                        setState(() {
                          load = true;
                        });
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            emailController.text, passwordController.text);

                        if (result == null) {
                          setState(() {
                            error = 'Try again something went wrong';
                            load = false;
                          });
                        } else {
                          print(result);
                          Navigator.pushNamed(context, '/');
                        }
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text('Not Registered yet?'))
                  ],
                ),
              ),
            ),
          );
  }
}
