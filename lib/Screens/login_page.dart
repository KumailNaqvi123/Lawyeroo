import 'package:flutter/material.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';
import 'package:project/Screens/square_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  void signUserIn() {}

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
              left: screenWidth * -0.07, // Adjust this value to move the ellipse2
              top: screenHeight * 0.05,
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
                    SizedBox(height: screenHeight * 0.2),
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    rememberMe = !rememberMe;
                                  });
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: rememberMe
                                        ? Color(0xFF75A1A7)
                                        : Colors.white,
                                    border: Border.all(
                                      color: Colors.grey[600] ?? Colors.grey,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: rememberMe
                                      ? Icon(
                                          Icons.check,
                                          size: 15,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Remember Me',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    MyButton(
                      onTap: signUserIn,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(imagePath: 'lib/images/google.png'),
                        SizedBox(width: screenWidth * 0.05),
                        SquareTile(imagePath: 'lib/images/apple.png'),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            ' Register now',
                            style: TextStyle(
                              color: const Color(0xFF75A1A7),
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        )
                      ],
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
