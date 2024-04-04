import 'package:flutter/material.dart';
import 'package:new_money/components/my_text_field.dart';
import 'package:new_money/screens/dummy.dart';
import 'package:new_money/services/auth.dart';
import 'package:new_money/shared/loading.dart';

class LoginEmail extends StatefulWidget {
  LoginEmail({super.key});

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  bool load = false;
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String error = '';
  @override
  Widget build(BuildContext context) {
    double figmaScreenWidth = 428.0;
    double figmaScreenHeight = 926.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double ws = screenWidth / figmaScreenWidth;
    double hs = screenHeight / figmaScreenHeight;

    return load
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 190 * hs,
                      left: 40 * ws,
                      right: 40 * ws,
                      bottom: 0 * hs),
                  child: Container(
                    child: Center(
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Sign in',
                                style: TextStyle(
                                  color: Color(0xFF2E2E2E),
                                  fontWeight: FontWeight
                                      .w900, 
                                  fontSize: 50 * ((ws + hs) / 2),
                                )),
                            SizedBox(height: 11 * hs),
                            Text(
                              'Welcome back!',
                              style: TextStyle(
                                color: Color(0xFF2E2E2E),
                                fontSize: 18 * ((ws + hs) / 2),
                                fontWeight: FontWeight
                                    .w500, 
                              ),
                            ),
                            SizedBox(height: 67 * hs),
                            MyTextField(
                              controller: emailController,
                              obscureText: false,
                              hintText: 'Enter your email',
                              prefixIcon: const Icon(Icons.email,
                                  color: Color.fromRGBO(149, 228, 168, 100)),
                            ),
                            SizedBox(
                              height: 20 * hs,
                            ),
                            MyTextField(
                              controller: passwordController,
                              obscureText: true,
                              hintText: 'Enter your password',
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color.fromRGBO(149, 228, 168, 100)),
                            ),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: TextButton(
                            //     onPressed: () => Navigator.pushNamed(
                            //         context, '/reset_pass_email'),
                            //     style: ButtonStyle(
                                  
                            //       alignment: Alignment
                            //           .topLeft, // <-- had to set alignment
                            //       padding: MaterialStateProperty.all<
                            //           EdgeInsetsGeometry>(
                            //         EdgeInsets
                            //             .zero, // <-- had to set padding to zero
                            //       ),
                            //       overlayColor: MaterialStateProperty.all(Colors.transparent),
                            //     ),
                            //     child: Text(
                            //       'Forgot password?',
                            //       style: TextStyle(
                            //         color: Color(0xFF2E2E2E),
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 16 * ((ws + hs) / 2),
                            //         fontFamily: 'ReadexPro',
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: hs * 20,
                            ),
                            CustomButtonlink(
                              buttonText: 'Log in',
                              onTapCallback: () async {
                                setState(() {
                                  load = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text);

                                if (result == null) {
                                  setState(() {
                                    error = 'Try again something went wrong';
                                    load = false;
                                  });
                                } else {
                                  print('login successful');
                                  print(result);
                                  Navigator.pushNamed(context, '/');
                                }
                              },
                            ),
                            SizedBox(height: hs * 190),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: const Text('First time here?',
                                          style: TextStyle(
                                            color: Color(0xFF2E2E2E),
                                            fontWeight: FontWeight
                                                .w400, // FontWeight.medium is not directly available, so use FontWeight.w500 for medium
                                            fontSize: 16,
                                            fontFamily: 'ReadexPro',
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      child: TextButton(
                                        onPressed: () => Navigator.pushNamed(
                                            context, '/register_email'),
                                        style: ButtonStyle(
                                          alignment: Alignment
                                              .centerLeft, // <-- had to set alignment
                                          padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            EdgeInsets
                                                .zero, // <-- had to set padding to zero
                                          ),
                                           overlayColor: MaterialStateProperty.all(Colors.transparent),
                                        ),
                                        child: const Text(
                                          'Register',
                                          style: TextStyle(
                                            color: Color(0xFF2E2E2E),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'ReadexPro',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
