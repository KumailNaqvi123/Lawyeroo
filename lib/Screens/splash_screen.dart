import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/Screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => OnboardingScreen()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 1, // Adjust the width factor as needed
            heightFactor: 1, // Adjust the height factor as needed
            child: Image.asset(
              'assets/images/logo.png', // Replace with your image
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}