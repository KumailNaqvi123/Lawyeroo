import 'package:flutter/material.dart';
import 'package:project/Screens/my_textfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF9F98C9), // Change background color
      body: SafeArea(
        child: Stack(
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
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            color: Colors.white, // Set text color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          "Enter the email address registered on your account",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Color.fromARGB(255, 109, 108, 108),
                          ),
                          textAlign: TextAlign.center, // Center the text
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      child: Image.asset(
                        'assets/images/lawyer3.png', // Replace with your image path
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.4,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: Column(
                        children: [
                          MyTextField(
                            controller: TextEditingController(), // Replace with your email controller
                            hintText: 'Enter your email',
                            obscureText: false,
                            borderRadius: 30.0,
                          ),
                          SizedBox(height: screenHeight * 0.02), // Add space between text field and button
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add logic for password reset here
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
                            'Reset Password',
                            style: TextStyle(
                              fontSize: screenWidth > 600 ? 18.0 : 16.0,
                              fontFamily: 'Poppins',
                              color: Colors.white, // Set text color
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
