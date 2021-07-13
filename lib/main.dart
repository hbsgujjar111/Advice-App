import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'homescreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: HomeScreen(),
      title: Text(
        'Welcome to\nAdvice App',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      ),
      image: Image.asset('assets/advice.png'),
      backgroundColor: Color(0xff262833),
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 150.0,
      loaderColor: Colors.white,
    );
  }
}
