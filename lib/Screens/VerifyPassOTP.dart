import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project/Screens/Global.dart';

class VerifyPassOTPPage extends StatefulWidget {
  @override
  _VerifyPassOTPPageState createState() => _VerifyPassOTPPageState();
}

class _VerifyPassOTPPageState extends State<VerifyPassOTPPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  String _responseMessage = '';

  Future<void> _resetPassword(BuildContext context) async {
    String email = _emailController.text;
    String otp = _otpController.text;
    String newPassword = _newPasswordController.text;

    var response = await http.post(
      Uri.parse('${GlobalData().baseUrl}/api/resetPassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _responseMessage = 'Password reset successfully!';
      });
    } else {
      setState(() {
        _responseMessage = 'Failed to reset password. Please try again later.';
      });

      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to reset password. Check your OTP and Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF9F98C9),
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
                    Text(
                      'Verify Password OTP',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          TextField(
                            controller: _otpController,
                            decoration: InputDecoration(
                              hintText: 'Enter OTP',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          TextField(
                            controller: _newPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Enter new password',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          ElevatedButton(
                            onPressed: () => _resetPassword(context),
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
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            _responseMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
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
