import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/UserVerificationPage.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';


class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

   List<String> preferences = [
    'Criminal Law',
    'Family Law',
    'Corporate Law',
    'Intellectual Property Law',
  ];
  List<String> selectedPreferences = [];

  File? _image;

 bool validateInputs() {
  if (firstnameController.text.isEmpty ||
      lastnameController.text.isEmpty ||
      !emailController.text.contains('@') ||
      passwordController.text.length < 6 ||
      phoneController.text.isEmpty ||
      addressController.text.isEmpty) {
    print('Validation failed');
    return false;
  }
  return true;
}
  
  bool isValidEmail(String email) {
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regex.hasMatch(email);
}

void showErrorDialog(String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Error'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    ),
  );
}


void signUpUser() async {
  if (!validateInputs()) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please fill all the fields correctly.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
    return;
  }

  var uri = Uri.parse('${GlobalData().baseUrl}/api/clients/register-client');
  var request = http.MultipartRequest('POST', uri);

  request.fields.addAll({
    'first_name': firstnameController.text.trim(),
    'last_name': lastnameController.text.trim(),
    'email': emailController.text.trim(),
    'ph_number': phoneController.text.trim(),
    'address': addressController.text.trim(),
    'password': passwordController.text.trim(),
    'verified': "False",
    'preferences': jsonEncode(selectedPreferences)
  });

  if (_image != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'profile_picture',
      _image!.path,
      contentType: MediaType('image', 'jpeg')
    ));
  }

  try {
    var response = await request.send();
    var responseBody = await response.stream.bytesToString(); // Read the stream here once
    var data = jsonDecode(responseBody);

    if (response.statusCode == 200) {
      print('Registration successful');
      var tempKey = data['tempKey'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ClientOTPVerificationPage(tempKey: tempKey, profileImage: _image)),
      );
    } else {
      print('Failed to register. Status code: ${response.statusCode}');
      print('Failed reason: $responseBody');
      showErrorDialog('Failed to register. Please try again.');
    }
  } catch (e) {
    print('Error occurred: $e');
    showErrorDialog('An error occurred. Please try again.');
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
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "Let's get you connected to lawyers",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    GestureDetector(
                      onTap: () {
                        _selectImage();
                      },
                      child: Container(
                        width: screenWidth * 0.4,
                        height: screenWidth * 0.4,
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
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: lastnameController,
                            hintText: 'Last Name',
                            obscureText: false,
                            borderRadius: 30.0,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: addressController,
                            hintText: 'Address',
                            obscureText: false,
                            borderRadius: 30.0,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: phoneController,
                            hintText: 'Phone Number',
                            obscureText: false,
                            borderRadius: 30.0,
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: emailController,
                            hintText: 'E-mail',
                            obscureText: false,
                            borderRadius: 30.0,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            borderRadius: 30.0,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.010),
                          Wrap(
                            children: preferences.map((String value) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChoiceChip(
                                  label: Text(value),
                                  selected: selectedPreferences.contains(value),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        selectedPreferences.add(value);
                                      } else {
                                        selectedPreferences.remove(value);
                                      }
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                    MyButton2(
                      onTap: signUpUser,
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
      print('Image Path: ${_image!.path}');  // Log the image path
    } else {
      print('No image selected.');
    }
  });
}
}