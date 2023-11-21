import 'package:flutter/material.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Controllers for text input fields
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Function to handle user sign-up
  void signUpUser() {
    // Implement sign-up logic here
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFD1C5C5),
      body: SafeArea(
        child: Stack(
          children: [
            // Background images
            Positioned(
              left: 0,
              top: -screenHeight * 0.05,
              child: Image.asset(
                'assets/images/ellipse1.png',
                width: screenWidth * 0.30, // Adjust the width
                height: screenWidth * 0.30, // Adjust the height
              ),
            ),
            Positioned(
              left: screenWidth * -0.07,
              top: screenHeight * 0.03,
              child: Image.asset(
                'assets/images/ellipse2.png',
                width: screenWidth * 0.3, // Adjust the width
                height: screenWidth * 0.3, // Adjust the height
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.140),

                  // Text widgets
                  Text(
                    "Welcome aboard",
                    style: TextStyle(
                      fontSize: 24, // Adjust the font size
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    "Let's help you meet with the experts",
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Text input fields
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Column(
                      children: [
                        MyTextField(
                          controller: usernameController,
                          hintText: 'Username',
                          obscureText: false,
                          borderRadius: 30.0, // Adjust the border radius
                        ),
                        SizedBox(height: screenHeight * 0.010),
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                          borderRadius: 30.0, // Adjust the border radius
                        ),
                        SizedBox(height: screenHeight * 0.010),
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          borderRadius: 30.0, // Adjust the border radius
                        ),
                        SizedBox(height: screenHeight * 0.010),
                        MyTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true,
                          borderRadius: 30.0, // Adjust the border radius
                        ),
                        SizedBox(height: screenHeight * 0.020), // Added space
                      ],
                    ),
                  ),

                  // Sign-up button
                  MyButton2(
                    onTap: signUpUser,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // "OR" text
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Social media login buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Color.fromARGB(255, 255, 255, 255),
                            child: InkWell(
                              onTap: () {
                                // Handle Google button tap
                              },
                              child: SizedBox(
                                width: 55, // Adjust the width
                                height: 55, // Adjust the height
                                child: Center(
                                  child: Image.asset('lib/images/google.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        ClipOval(
                          child: Material(
                            color: Color.fromARGB(255, 255, 255, 255),
                            child: InkWell(
                              onTap: () {
                                // Handle Apple button tap
                              },
                              child: SizedBox(
                                width: 55, // Adjust the width
                                height: 55, // Adjust the height
                                child: Center(
                                  child: Image.asset('lib/images/apple.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: const Color(0xFF75A1A7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
