import 'package:flutter/material.dart';
import 'package:new_money/components/my_text_field.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
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
        child: Padding(
          padding: EdgeInsets.only(
              top: 198 * hs, left: 40 * ws, right: 40 * ws, bottom: 0 * hs),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Reset',
                  style: TextStyle(
                    height: 1.0,
                    color: Color(0xFF2E2E2E),
                    fontWeight: FontWeight.bold,
                    fontSize: 50 * ((ws + hs) / 2),
                  ),
                ),
                SizedBox(height: 0),
                Text(
                  'password',
                  style: TextStyle(
                    height: 0.8,
                    color: Color(0xFF2E2E2E),
                    fontSize: 50 * ((ws + hs) / 2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 67 * hs),
                MyTextField(
                  controller: phonecontroller,
                  obscureText: false,
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.phone,
                      color: Color.fromRGBO(149, 228, 168, 100)),
                ),
                SizedBox(
                  height: 17 * hs,
                ),
                SizedBox(
                  height: hs * 20,
                ),
                CustomButton(buttonText: 'Get password reset email'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
