import 'package:flutter/material.dart';
import 'package:project/Screens/home_screen.dart';
import 'package:project/Screens/login_page.dart';
import 'package:project/lawyerlogin.dart';
import 'package:project/Screens/lawyerhomepage.dart'; // Correct import statement

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Options(),
    );
  }
}

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Color(0xFF9F98C9),
        child: Stack(
          children: [
            Positioned(
              top: -10,
              left: -10,
              child: Image.asset('assets/images/ellipse1.png', width: width * 0.3, height: width * 0.225),
            ),
            Positioned(
              top: 40,
              left: -30,
              child: Image.asset('assets/images/ellipse2.png', width: width * 0.25, height: width * 0.3),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/transparent.png'),
                  SizedBox(height: 5),
                  SizedBox(
                    width: width * 0.7, // Adjust the width as needed
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF187D89),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "looking for services? (non-lawyer)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: width * 0.7, // Adjust the width as needed
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LawyerLoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF187D89),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "providing services? (lawyers)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: width * 0.7, // Adjust the width as needed
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                           MaterialPageRoute(
                             builder: (context) => HomeScreen(),
                          ),
                         );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF187D89),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Try the Demo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: width * 0.7, // Adjust the width as needed
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                           MaterialPageRoute(
                             builder: (context) => LawyerHomepage(), // Correct class name
                          ),
                         );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF187D89),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Try Demo 2",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
