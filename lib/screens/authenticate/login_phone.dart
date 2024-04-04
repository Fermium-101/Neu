import 'package:flutter/material.dart';
import 'package:new_money/components/my_text_field.dart';
import 'package:new_money/screens/authenticate/login_phone_code.dart';

class LoginPhone extends StatelessWidget {
  LoginPhone({super.key});
  final phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double figmaScreenWidth = 428.0;
    double figmaScreenHeight = 926.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double ws = screenWidth / figmaScreenWidth;
    double hs = screenHeight / figmaScreenHeight;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
                top: 198 * hs, left: 40 * ws, right: 40 * ws, bottom: 0 * hs),
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text('Login',
                        style: TextStyle(
                          color: Color(0xFF2E2E2E),
                          fontWeight:
                              FontWeight.bold, // FontWeight.bold is also valid
                          fontSize: 50,
                        )),
                    SizedBox(height: 11 * hs),
                    const Text(
                      'Welcome back!',
                      style: TextStyle(
                        color: Color(0xFF2E2E2E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // You can adjust the fontWeight as needed
                      ),
                    ),
                    SizedBox(height: 67 * hs),
                    MyTextField(
                      controller: phonecontroller,
                      obscureText: false,
                      hintText: 'Enter your phone number',
                      prefixIcon: Icon(Icons.phone,
                          color: Color.fromRGBO(149, 228, 168, 100)),
                    ),
                    SizedBox(
                      height: 17 * hs,
                    ),
                    SizedBox(
                      height: hs * 20,
                    ),
                    CustomButton1(buttonText: 'Get code via SMS'),
                    SizedBox(height: hs * 320),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text('First time here?',
                                  style: TextStyle(
                                    color: Color(0xFF2E2E2E),
                                    fontWeight: FontWeight
                                        .w400, // FontWeight.medium is not directly available, so use FontWeight.w500 for medium
                                    fontSize: 16,
                                    fontFamily: 'ReadexPro',
                                  )),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Container(
                              child: TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/register_email'),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Color(0xFF2E2E2E),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'ReadexPro',
                                  ),
                                ),
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
    );
  }
}

class CustomButton1 extends StatelessWidget {
  final String buttonText; // Argument for dynamic text

  CustomButton1({required this.buttonText});

  @override
  Widget build(BuildContext context) {
    double figmaScreenWidth = 428.0;
    double figmaScreenHeight = 926.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double ws = screenWidth / figmaScreenWidth;
    double hs = screenHeight / figmaScreenHeight;
    print('Scaled Screen Width: $screenWidth * $ws');
    print('Scaled Screen Height: $screenHeight * $hs');
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPhoneCode()),
        );
      },
      child: Container(
        width: 348 * hs,
        height: 51 * ws,
        decoration: BoxDecoration(
          //color: Color.fromARGB(0, 244, 57, 100),
          color: Color.fromARGB(255, 0, 244, 57),
          //color: Color(0xFF00F439),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 15),
              Text(
                buttonText,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
