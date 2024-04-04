import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthComingSoon extends StatefulWidget {
  const AuthComingSoon({super.key});

  @override
  State<AuthComingSoon> createState() => _AuthComingSoonState();
}

class _AuthComingSoonState extends State<AuthComingSoon> {
  @override
  void initState() {
    super.initState();
    // Add a delay before navigating to the new route
    // Future.delayed(Duration(seconds: 5), () {
    //    Navigator.pushNamed(context, '/mainscreen');
    // });
  }

  @override
  Widget build(BuildContext context) {
    double ws = MediaQuery.of(context).size.width / 428;
    double hs = MediaQuery.of(context).size.height / 926;
    print(hs);
    print(ws);
    var p = ws;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/email_sms_login',
              (route) => false,
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/email_sms_login',
                  (route) => false,
                );
              },
              child: Image.asset(
                'assets/tree.gif',
                height: 300 * hs,
                width: 300 * ws,
              ),
            ),
            Text(
              'This feature \nis coming soon',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF2E2E2E),
                fontWeight: FontWeight.bold,
                fontSize: 32 * ((ws + hs) / 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
