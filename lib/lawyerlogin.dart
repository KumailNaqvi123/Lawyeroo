import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/lawyerhomepage.dart';
import 'dart:convert';  // For handling JSON encoding
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';

class LawyerLoginPage extends StatefulWidget {
  LawyerLoginPage({Key? key}) : super(key: key);

  @override
  _LawyerLoginPageState createState() => _LawyerLoginPageState();
}

class _LawyerLoginPageState extends State<LawyerLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

 void signLawyerIn() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  try {
    http.Response response = await http.post(
      Uri.parse('${GlobalData().baseUrl}/api/login'),  // Use base URL from GlobalData
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var token = responseData['token'];
      var userData = responseData['userData'];
      var id = userData['id'];
      var first_name = userData['first_name'];
      var last_name = userData['last_name']; // Extracting unique id from response
      print('Token: $token'); 
      print('ID: $id');
      print('First name: $first_name'); // Logging for debugging purposes
      print('Last name: $last_name');
      GlobalData().setUserData(id, token, userData);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LawyerHomepage(token: token, userData: userData),
        ),
      );
    } else {
      print('Failed to log in with status code: ${response.statusCode}. Response body: ${response.body}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid email or password.'),
            actions: <TextButton>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print('Error occurred: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Network Error'),
          content: Text('An error occurred. Please try again later.'),
          actions: <TextButton>[
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


void _showDialog(String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void navigateToSignupPage() {
    Navigator.pushReplacementNamed(context, '/lawyersignup');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0Xff9f98c9),
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
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0),
                      child: Image.asset(
                        'assets/images/lawyer2.png',
                        width: screenWidth * 0.6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: MyTextField(
                        controller: emailController,
                        hintText: 'E-mail',
                        obscureText: false,
                        borderRadius: 30.0,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        borderRadius: 30.0,
                      ),
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
                          GestureDetector(
                            onTap: navigateToSignupPage,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    MyButton(
                      onTap: signLawyerIn,
                      buttonText: 'Sign In',  // Ensuring button text is clearly defined
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
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.04),
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
                          onTap: navigateToSignupPage,
                          child: Text(
                            ' Register now',
                            style: TextStyle(
                              color: Color.fromARGB(255, 108, 9, 173),
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