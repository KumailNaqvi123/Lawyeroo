import 'package:flutter/material.dart';
import 'package:project/Screens/onboarding_screen2.dart';

class MyOnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize1 = screenWidth > 600 ? 28.0 : 18.0;
    double fontSize2 = screenWidth > 600 ? 32.0 : 16.0;
    double imageWidth = screenWidth * 1;
    double imageHeight = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                left: 0,
                top: -screenHeight * 0.05,
                child: Image.asset(
                  'assets/images/ellipse1.png',
                  width: screenWidth * 0.30,
                  height: screenWidth * 0.30,
                ),
              ),
              Positioned(
                left: screenWidth * -0.07,
                top: screenHeight * 0.03,
                child: Image.asset(
                  'assets/images/ellipse2.png',
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/lawyer1.png',
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(
                        'Find the best lawyers here',
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
                          'Find your ideal legal counsel, explore expert advice, navigate your legal journey with ease and Experience a smarter way to connect with the law',
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
                          builder: (context) => OnboardingScreen2(),
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
              ),
            ],
          );
        },
      ),
    );
  }
}
