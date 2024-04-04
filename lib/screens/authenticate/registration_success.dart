import 'package:flutter/material.dart';
import 'package:new_money/components/my_text_field.dart';
import 'package:new_money/screens/authenticate/create_profile.dart';
import 'package:new_money/screens/dummy.dart';

class Success extends StatelessWidget {
  const Success({super.key});

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
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 110 * hs,
              ),
              Container(
                child: Image.asset(
                  'assets/success.png',
                  width: 215.7 * ws,
                  height: 215.7 * hs,
                ),
              ),
              SizedBox(
                height: 120 * hs,
              ),
              Text('Registration Done!',
                  style: TextStyle(
                    color: Color(0xFF2E2E2E),
                    fontWeight:
                        FontWeight.bold, // FontWeight.bold is also valid
                    fontSize: 32 * ((ws + hs) / 2),
                  )),
              SizedBox(height: 11 * hs),
              Text(
                textAlign: TextAlign.center,
                'All your content in one place, it’s \ntime to start exploring.',
                style: TextStyle(
                  color: Color(0xFF2E2E2E),
                  fontSize: 18 * ((ws + hs) / 2),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 180 * hs,
              ),
              CustomButtonlinkC(
                buttonText: 'Get started',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonlinkC extends StatefulWidget {
  final String buttonText; // Argument for dynamic text

  final VoidCallback? onTapCallback; // New argument for custom onTap function

  CustomButtonlinkC({
    required this.buttonText,
    this.onTapCallback,
  });

  @override
  _CustomButtonlinkCState createState() => _CustomButtonlinkCState();
}

class _CustomButtonlinkCState extends State<CustomButtonlinkC> {
  @override
  Widget build(BuildContext context) {
    double figmaScreenWidth = 428.0;
    double figmaScreenHeight = 926.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double ws = screenWidth / figmaScreenWidth;
    double hs = screenHeight / figmaScreenHeight;

    return GestureDetector(
      onTap: widget.onTapCallback ??
          () {
            // If onTapCallback is not provided, use default navigation
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateProfile()),
            );
          },
      child: Container(
        width: 348 * ws,
        height: 51 * hs,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 244, 57),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 15),
              Text(
                widget.buttonText,
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
