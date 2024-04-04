import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {

  final controller;
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;

  const EmailField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
  });
  

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
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
    return Container(
      height: 51*hs,
      width: 348*ws,
      child: TextFormField(

        controller: widget.controller,
     
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xDBDBDBDB)),
          borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Color.fromARGB(46, 46, 46, 100),fontSize: 16,fontWeight: FontWeight.w400),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          
        ),
      ),
    );
  }
}