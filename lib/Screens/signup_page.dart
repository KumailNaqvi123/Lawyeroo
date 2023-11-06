import 'package:flutter/material.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';
import 'package:project/Screens/square_tile.dart';

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
  bool rememberMe = false;

  void signUpUser() {}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFD1C5C5),
      body: SafeArea(
        child: Stack(
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
              left: screenWidth * -0.07,
              top: screenHeight * 0.05,
              child: Image.asset(
                'assets/images/ellipse2.png',
                width: screenWidth * 0.3,
                height: screenWidth * 0.3,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.160),
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
                        ),
                        SizedBox(height: screenHeight * 0.010),
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                        SizedBox(height: screenHeight * 0.010),
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        SizedBox(height: screenHeight * 0.010),
                        MyTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value ?? false;
                                });
                              },
                            ),
                            Text(
                              'Remember Me',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0),
                  MyButton2(
                    onTap: signUpUser,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Material(
                            color: const Color(0xFF75A1A7),
                            child: InkWell(
                              onTap: () {
                                // Handle Google button tap
                              },
                              child: SizedBox(
                                width: 40,
                                height: 40,
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
                            color: const Color(0xFF75A1A7),
                            child: InkWell(
                              onTap: () {
                                // Handle Apple button tap
                              },
                              child: SizedBox(
                                width: 40,
                                height: 40,
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
