import 'package:flutter/material.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';
import '../main.dart';


void main() {
  runApp(const MyApp());
}

class PhoneRegistrationPage extends StatefulWidget {
  PhoneRegistrationPage({super.key});

  @override
  _PhoneRegistrationPageState createState() => _PhoneRegistrationPageState();
}

class _PhoneRegistrationPageState extends State<PhoneRegistrationPage> {
  final phoneNumberController = TextEditingController();

  void navigateToPhoneVerificationPage() {
    Navigator.pushReplacementNamed(context, '/phone_ver',
        arguments: phoneNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0Xff9f98c9),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
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
                top: screenHeight * 0.02,
                child: Image.asset(
                  'assets/images/ellipse2.png',
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                ),
              ),
              Container(
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
                          controller: phoneNumberController,
                           hintText: 'Phone Number',
                          obscureText: false,
                          borderRadius: 30.0,
                          ),

                          SizedBox(height: screenHeight * 0.020),
                        ],
                      ),
                    ),
                    MyButton3(
                      onTap: navigateToPhoneVerificationPage,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}