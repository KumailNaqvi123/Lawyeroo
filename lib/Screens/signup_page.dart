import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}




class _SignupPageState extends State<SignupPage> {
  final AddressController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  File? _image; // Store the selected image

  void signUpUser() async {
  var uri = Uri.parse('http://10.0.2.2:3000/api/clients/register-client'); // Use your computer's IP address if on a real device
  var request = http.MultipartRequest('POST', uri);

  // Add all the text fields as parts of the request
  request.fields['first_name'] = firstnameController.text.trim();
  request.fields['last_name'] = lastnameController.text.trim();
  request.fields['email'] = emailController.text.trim();
  request.fields['ph_number'] = "234242345"; // Ideally, you should have a controller for this
  request.fields['address'] = AddressController.text.trim();
  request.fields['password'] = passwordController.text.trim();
  request.fields['verified'] = "False";  // Since this is a boolean, make sure your backend can parse the string correctly
  request.fields['preferences'] = jsonEncode(["Criminal Law", "Tax Law"]);  // Directly encoding the preferences

  // Handling the file upload for the profile picture
  if (_image != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'profile_picture',
      _image!.path,
    ));
  }

  // Send the request
  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('Registration successful');
      // Navigate or perform other actions upon success
    } else {
      print('Failed to register. Status code: ${response.statusCode}');
      print('Reason: ${response.body}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}
  void navigateToLoginPage() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0Xff9f98c9),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    GestureDetector(
                      onTap: () {
                        _selectImage();
                      },
                      child: Container(
                        width: screenWidth * 0.3,
                        height: screenWidth * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: _image == null
                            ? Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.grey[400],
                              )
                            : Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: Column(
                        children: [
                          MyTextField(
                            controller: firstnameController,
                            hintText: 'First Name',
                            obscureText: false,
                            borderRadius: 30.0,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: lastnameController,
                            hintText: 'Last Name',
                            obscureText: false,
                            borderRadius: 30.0,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: AddressController,
                            hintText: 'Address',
                            obscureText: false,
                            borderRadius: 30.0,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: emailController,
                            hintText: 'E-mail',
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
                              vertical: 9.5,
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
                                    color: Colors.white,
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
                              color: Color.fromARGB(255, 108, 9, 173),
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
      ),
    );
  }

  // Function to select image from gallery
  void _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
