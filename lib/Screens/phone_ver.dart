import 'package:flutter/material.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';

class PhoneVerificationPage extends StatefulWidget {
  PhoneVerificationPage({super.key});

  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final otpController = TextEditingController();

  void verifyPhoneNumber() {
    // Implement OTP verification logic here
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Retrieve phone number passed as an argument
   final phoneNumber = ModalRoute.of(context)?.settings.arguments as String?;
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
                      "Verification",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "Enter the OTP sent to $phoneNumber",
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
                          controller: otpController,
                          hintText: 'OTP',
                          obscureText: false,
                          borderRadius: 30.0,
                          ),
                          SizedBox(height: screenHeight * 0.020),
                        ],
                      ),
                    ),
                    MyButton3(
                      onTap: verifyPhoneNumber,
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
