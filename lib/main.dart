import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 3000,
        nextScreen: const OnboardingScreen(),
        splash: Image.asset(
          'assets/images/splash.jpg',
          fit: BoxFit.cover,
        ),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: double.infinity,
      ),
    );
  }
}

