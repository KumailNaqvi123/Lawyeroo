import 'package:flutter/material.dart';
import 'package:project/Screens/login_page.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFD1C5C5),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          double fontSize1 = screenWidth > 600 ? 28.0 : 18.0;
          double fontSize2 = screenWidth > 600 ? 32.0 : 19.0;
          double imageWidth = screenWidth * 0.8;
          double imageHeight = screenHeight * 0.4;

          return Stack(
            children: [
              Positioned(
                left: 0,
                top: -screenHeight * 0.05,
                child: Image.asset(
                  'assets/images/ellipse1.png',
                  width: screenWidth * 0.35,
                  height: screenWidth * 0.35,
                ),
              ),
              Positioned(
                left: screenWidth * -0.07, // Adjust this value to move the ellipse2
                top: screenHeight * 0.05,
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
                          builder: (context) => LoginPage(),
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
                          'Get Started',
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

// class OnboardingScreen extends StatelessWidget {   //current better

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFD1C5C5),
//       body: Center(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             double screenWidth = constraints.maxWidth;
//             double screenHeight = constraints.maxHeight;

//             double fontSize1 = screenWidth > 600 ? 28.0 : 18.0; // Change these values
//             double fontSize2 = screenWidth > 600 ? 32.0 : 19.0; // Change these values

//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Add an Image widget here
//                 Image.asset(
//                   'assets/images/lawyer1.png', // Replace with your image path
//                   width: screenWidth * 0.6,
//                 ),
//                 SizedBox(height: screenHeight * 0.001), // Add space above the first text
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding here
//                   child: Center(
//                     child: Text(
//                       'Find the best lawyers here',
//                       style: TextStyle(
//                         fontSize: fontSize1,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.020 ), // Add space between the two texts
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding here
//                   child: Center(
//                     child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       'Find your ideal legal counsel, explore expert advice, navigate your legal journey with ease and Experience a smarter way to connect with the law',
//                       style: TextStyle(
//                         fontSize: fontSize2,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w100,
//                       ),
//                     ),
//                     )
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.05), // Add space below the second text
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginPage(),
//                       ),
//                     );
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color(0xFF75A1A7),
//                     ),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0), // Adjust the radius for rounded edges
//                       ),
//                     ),
//                   ),
//                   child: Container(
//                     width: screenWidth * 0.6, // Adjust the width of the button
//                     height: screenHeight * 0.1,
//                     child: Center(
//                       child: Text(
//                         'Get Started',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



// class OnboardingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFD1C5C5),
//       body: Center(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             double screenWidth = constraints.maxWidth;
//             double screenHeight = constraints.maxHeight;

//             double fontSize1 = screenWidth > 600 ? 28.0 : 14.0; // Change these values for the text
//             double fontSize2 = screenWidth > 600 ? 32.0 : 18.0; // Change these values for the

//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Add an Image widget here
//                 Image.asset(
//                   'assets/images/lawyer1.png', // Replace with your image path
//                   width: screenWidth * 0.6,
//                 ),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: Text(
//                     'Find the best lawyers here',
//                     style: TextStyle(
//                       fontSize: fontSize1,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: Text(
//                     'Find your ideal legal counsel explore expert advice and navigate your legal journey with ease Experience a smarter way to connect with the law',
//                     style: TextStyle(
//                       fontSize: fontSize2,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.03),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginPage(),
//                       ),
//                     );
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color(0xFF75A1A7),
//                     ),
//                   ),
//                   child: Container(
//                     width: screenWidth * 0.4,
//                     height: screenHeight * 0.08,
//                     child: const Center(
//                       child: Text(
//                         'Get Started',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:project/Screens/home_screen.dart';
// import 'package:project/Screens/login_page.dart';

// class MyOnboardingApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: OnboardingScreen(),
//     );
//   }
// }

// class OnboardingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFD1C5C5),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Add a Row widget to arrange the image and text side by side
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Add an Image widget before the text
//                 Image.asset(
//                   'assets/images/lawyer1.png', // Replace with the path to your image asset
//                   width: 100, // Set the desired width for the image
//                 ),
//                 SizedBox(width: 16), // Add spacing between the image and text
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Find the best lawyers here',
//                       style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       'Find your ideal legal counsel, explore expert advice, and navigate your legal journey with ease. Experience a smarter way to connect with the law',
//                       style: TextStyle(fontSize: 28, fontFamily: 'Poppins'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => LoginPage(),
//                   ),
//                 );
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                   Color(0xFF75A1A7),
//                 ),
//               ),
//               child: Container(
//                 width: 200,
//                 height: 80,
//                 child: Center(
//                   child: Text(
//                     'Get Started',
//                     style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }










