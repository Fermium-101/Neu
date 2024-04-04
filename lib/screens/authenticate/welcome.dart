// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class Welcome extends StatefulWidget {
//   const Welcome({super.key});

//   @override
//   State<Welcome> createState() => _WelcomeState();
// }

// class _WelcomeState extends State<Welcome> {
//   @override
//   Widget build(BuildContext context) {
//     double ws = MediaQuery.of(context).size.width / 428;
//     double hs = MediaQuery.of(context).size.height / 926;
//     print(hs);
//     print(ws);
//     var p = ws;
//     return Scaffold(
//         body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, '/mainscreen');
//               },
//               child: Image.asset(
//                 'assets/tree.gif',
//                 height: 300 * hs,
//                 width: 300 * ws,
//               )),
//           Text('Welcome to \nNew Money App',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Color(0xFF2E2E2E),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 32 * ((ws + hs) / 2),
//               ))
//         ],
//       ),
//     ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/mainscreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    double ws = MediaQuery.of(context).size.width / 428;
    double hs = MediaQuery.of(context).size.height / 926;
    print(hs);
    print(ws);
    var p = ws;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/mainscreen');
              },
              child: Image.asset(
                'assets/tree.gif',
                height: 300 * hs,
                width: 300 * ws,
              ),
            ),
            Text(
              'Welcome to \nNew Money App',
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
