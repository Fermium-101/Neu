import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_money/components/email_textfield.dart';
import 'package:new_money/components/my_text_field.dart';
import 'package:new_money/components/password_textfield.dart';
import 'package:new_money/services/auth.dart';
import 'package:new_money/services/database.dart';
import 'package:new_money/shared/loading.dart';
import 'package:provider/provider.dart';

class RegisterEmail extends StatefulWidget {
  RegisterEmail({super.key});

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  final Service _databaseService = Service();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final AuthService _auth = AuthService();
  String error = '';
  bool load = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double figmaScreenWidth = 428.0;
    double figmaScreenHeight = 926.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double ws = screenWidth / figmaScreenWidth;
    double hs = screenHeight / figmaScreenHeight;
    final user = Provider.of<User?>(context);

    return load
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 198 * hs,
                    left: 40 * ws,
                    right: 40 * ws,
                    bottom: 0 * hs),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Register',
                            style: TextStyle(
                              color: Color(0xFF2E2E2E),
                              fontWeight: FontWeight
                                  .w900, // FontWeight.bold is also valid
                              fontSize: 50 * ((ws + hs) / 2),
                            )),
                        SizedBox(height: 11 * hs),
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            color: Color(0xFF2E2E2E),
                            fontSize: 18 * ((ws + hs) / 2),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 67 * hs),
                        EmailField(
                          controller: emailcontroller,
                          obscureText: false,
                          hintText: 'Enter your email',
                          prefixIcon: const Icon(Icons.email,
                              color: Color.fromRGBO(149, 228, 168, 100)),
                        ),
                        SizedBox(
                          height: 17 * hs,
                        ),
                        PasswordField(
                          controller: passwordcontroller,
                          obscureText: true,
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock,
                              color: Color.fromRGBO(149, 228, 168, 100)),
                        ),
                        SizedBox(
                          height: hs * 20,
                        ),
                        CustomButtonlink(
                          buttonText: 'Next',
                          onTapCallback: () async {
                            setState(() {
                              load = true;
                            });
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    emailcontroller.text,
                                    passwordcontroller.text);
                            if (result == null) {
                              setState(() {
                                error =
                                    'please supply a valid email and password';
                                load = false;
                              });
                            } else {
                              print(result);
                              setState(() {
                                load = false;
                              });
                              Navigator.pushNamed(context, '/success');
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                        ),
                        SizedBox(height: hs * 210),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: const Text('Have an account?',
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
                                        context, '/email_sms_login'),
                                    style: ButtonStyle(
                                      alignment: Alignment
                                          .centerLeft, // <-- had to set alignment
                                      padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                        EdgeInsets
                                            .zero, // <-- had to set padding to zero
                                      ),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    child: const Text(
                                      'Sign in',
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
          );
  }
}
