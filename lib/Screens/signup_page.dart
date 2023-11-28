import 'package:flutter/material.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUpUser() {
    // Implement sign-up logic here
  }

  void navigateToLoginPage() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.140),
                  Text(
                    "Welcome aboard",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    "Let's help you meet with the experts",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Column(
                      children: [
                        MyTextField(
                          controller: usernameController,
                          hintText: 'Username',
                          obscureText: false,
                          borderRadius: 30.0,
                        ),
                        SizedBox(height: screenHeight * 0.010),
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                          borderRadius: 30.0,
                        ),
                        SizedBox(height: screenHeight * 0.010),
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          borderRadius: 30.0,
                        ),
                        SizedBox(height: screenHeight * 0.010),
                        MyTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true,
                          borderRadius: 30.0,
                        ),
                        SizedBox(height: screenHeight * 0.020),
                      ],
                    ),
                  ),
                  MyButton2(
                    onTap: signUpUser,
                  ),
                  SizedBox(height: screenHeight * 0.01),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xFF75A1A7),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'lib/images/google.png',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.grey[400],
                                thickness: 1.0,
                                width: 1.0,
                              ),
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                        onTap: navigateToLoginPage,
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
