import 'package:flutter/material.dart';
import 'package:schiary/screens/login_screen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: FirstActivity(),
      //home: LoginScreen(),
    );
  }
}

class FirstActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: LoginScreen(),
      image: Image.asset("assets/logos/Schiary.png"),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 200.0,
      loaderColor: Colors.green,
    );
  }
}
///////////////////////////////////////
