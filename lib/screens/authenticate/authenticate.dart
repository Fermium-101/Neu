import 'package:new_money/screens/authenticate/choose_method.dart';
import 'package:new_money/screens/authenticate/register.dart';
import 'package:new_money/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';



class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}