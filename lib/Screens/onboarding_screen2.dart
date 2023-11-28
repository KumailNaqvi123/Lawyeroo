import 'package:flutter/material.dart';
import 'package:project/Screens/onboarding_screen3.dart';

class MyOnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen2(),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          double fontSize1 = screenWidth > 600 ? 28.0 : 18.0;
          double fontSize2 = screenWidth > 600 ? 32.0 : 16.0;
          double imageWidth = screenWidth * 1; // Adjust the width
          double imageHeight = screenHeight * 0.5; // Adjust the height

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/lawyer4.png',
                  width: imageWidth,
                  height: imageHeight,
                ),
              ),
              SizedBox(height: screenHeight * 0),  // Adjust this value for additional spacing
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    'Uncover Leading Legal experts here',
                    style: TextStyle(
                      fontSize: fontSize1,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Discover Your Legal Partner: Our app links you with expert lawyers for your specific needs. From family law to business disputes, find trusted attorneys, schedule consultations, and navigate legal matters effortlessly. Your personalized legal solution is just a tap away!',
                      style: TextStyle(
                        fontSize: fontSize2,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnboardingScreen3(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF75A1A7),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Container(
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.1,
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
