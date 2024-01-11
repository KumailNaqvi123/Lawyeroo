import 'package:flutter/material.dart';
import 'package:project/Screens/Option_screen.dart';
import 'package:project/Screens/forgot_pass.dart';
import 'package:project/Screens/lawyersignup.dart';
import 'package:project/Screens/onboarding_screen2.dart';
import 'package:project/Screens/onboarding_screen3.dart';
import 'package:project/Screens/splash_screen.dart';
import 'package:project/Screens/onboarding_screen.dart'; // Import the OnboardingScreen
import 'package:project/Screens/login_page.dart'; // Import the LoginPage
import 'package:project/Screens/signup_page.dart';
import 'package:project/lawyerlogin.dart'; // Import the SignupPage


void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Set the navigatorKey
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route to '/'
      routes: {
        '/': (context) => SplashScreen(), // SplashScreen as the initial route
        '/onboarding': (context) => OnboardingScreen(),
        '/onboarding2': (context) => OnboardingScreen2(),
        '/onboarding3': (context) => OnboardingScreen3(),
        '/options':(context) => Options(),
        '/lawyerlogin' : (context) => LawyerLoginPage(),
        '/lawyersignup' : (context) => LawyerSignupPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
      },
    );
  }
}

