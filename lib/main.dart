import 'package:flutter/material.dart';
import 'package:project/Screens/splash_screen.dart';
import 'package:project/Screens/onboarding_screen.dart'; // Import the OnboardingScreen
import 'package:project/Screens/login_page.dart'; // Import the LoginPage
import 'package:project/Screens/signup_page.dart'; // Import the SignupPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route to '/'
      routes: {
        '/': (context) => SplashScreen(), // SplashScreen as the initial route
        '/onboarding': (context) => OnboardingScreen(), // Add OnboardingScreen
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}