

import 'package:new_money/screens/authenticate/authenticate.dart';
import 'package:new_money/screens/dummy.dart';
import 'package:new_money/screens/e.dart';
import 'package:new_money/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_money/screens/home/index.dart';
import 'package:new_money/screens/home/nav.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return user == null ? const Authenticate() :  MainScreen();
  }
}
