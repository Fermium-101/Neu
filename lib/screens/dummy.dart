import 'package:flutter/material.dart';
import 'package:new_money/services/auth.dart';
class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
    final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:Column(
      children: [
        Text('heeee'),
         ElevatedButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushNamed(context, '/');
                    },
                    icon: Icon(Icons.person),
                    label: Text('Logout Fahim'),
                  ),
      ],
    )),);
  }
}