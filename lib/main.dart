import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speach_app/layouts/home_screen.dart';
import 'package:speach_app/shared/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speech App',
      theme: lightMode(),
      home: const HomeScreen(),
      /*AnimatedSplashScreen(
        nextScreen: const HomeScreen(),
        backgroundColor: const Color(0xFF1B2C3B),
        animationDuration: const Duration(
          seconds: 1,
        ),
        splash: 'assets/images/splach_image.png',
        centered: true,
        splashTransition: SplashTransition.scaleTransition,
        curve: Curves.ease,
      ),*/
    );
  }
}
