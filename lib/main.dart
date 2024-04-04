import 'package:flutter/services.dart';
import 'package:new_money/screens/authenticate/choose_method.dart';
import 'package:new_money/screens/authenticate/comin_soon.dart';
import 'package:new_money/screens/authenticate/login_phone.dart';
import 'package:new_money/screens/authenticate/login_phone_code.dart';
import 'package:new_money/screens/authenticate/register.dart';
import 'package:new_money/screens/authenticate/register_email.dart';
import 'package:new_money/screens/authenticate/registration_success.dart';
import 'package:new_money/screens/authenticate/reset_pass_email.dart';
import 'package:new_money/screens/authenticate/sign_in.dart';
import 'package:new_money/screens/authenticate/welcome.dart';
import 'package:new_money/screens/dummy.dart';
import 'package:new_money/screens/e.dart';
import 'package:new_money/screens/home/home.dart';
import 'package:new_money/screens/home/index.dart';
import 'package:new_money/screens/home/nav.dart';
import 'package:new_money/services/auth.dart';
import 'package:new_money/shared/splash.dart';
import 'package:new_money/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  //firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.grey[100], // Change this color to the desired color
      statusBarIconBrightness: Brightness.light, // Change the icon color to light or dark
    ),
  );
  
  runApp(
    StreamProvider<User?>.value(
    value: AuthService().user,
    initialData: null,
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/dummy': (context) => DataPlot(),
        '/register_email':((context) => RegisterEmail()),
        '/sign_in':(context) => SignIn(),
        '/home':(context) => Balance(),
        '/success':(context) => Success(),
        '/welcome':(context) => Welcome(),
        '/mainscreen':(context) => MainScreen(),
        '/email_sms_login':(context) => MyHomePage(),
        '/reset_pass_email':(context) => ResetPassword(),
        '/splash':(context) => SplashScreen(),
        '/phone_code':(context) => LoginPhoneCode(),
        '/phone_login':(context) => LoginPhone(),
        '/coming_soon':(context) => ComingSoon(),
      },
    ),
  ));

}
