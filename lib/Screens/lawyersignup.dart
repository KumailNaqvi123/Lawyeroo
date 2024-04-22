import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Screens/LawyerVerificationPage.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';
import 'package:http/http.dart' as http;  // Correct import for http package
import 'package:http_parser/http_parser.dart';


class LawyerSignupPage extends StatefulWidget {
  LawyerSignupPage({Key? key}) : super(key: key);

  @override
  _LawyerSignupPageState createState() => _LawyerSignupPageState();
}

class _LawyerSignupPageState extends State<LawyerSignupPage> {
  final AddressController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final feesController = TextEditingController();
  final experienceController = TextEditingController();
  final universityController = TextEditingController();

  List<String> specializations = [
    'Criminal Law',
    'Family Law',
    'Corporate Law',
    'Intellectual Property Law',
    // Add more specializations as needed
  ];
  List<String> selectedSpecializations = []; // Store selected specializations

  File? _image; // Store the selected image


 bool validateInputs() {
  if (firstnameController.text.isEmpty ||
      lastnameController.text.isEmpty ||
      !emailController.text.contains('@') ||
      passwordController.text.length < 6 ||
      phoneController.text.isEmpty ||
      AddressController.text.isEmpty ||
      feesController.text.isEmpty ||
      experienceController.text.isEmpty ||
      universityController.text.isEmpty ||
      selectedSpecializations.isEmpty) {
    print('Validation failed');
    return false;
  }
  return true;
}
  
  bool isValidEmail(String email) {
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regex.hasMatch(email);
}

void signUpLawyer() async {
 if (!validateInputs()) {
    // Show an error message or alert dialog here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please fill all the fields correctly.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
            ),
          ],
        );
      },
    );
    return;  // Stop the function if validation fails
  }

  var uri = Uri.parse('http://192.168.10.2:3000/api/lawyers/register-lawyer');
  var request = http.MultipartRequest('POST', uri);

  // Adding fields to the request
  Map<String, String> fields = {
    'first_name': firstnameController.text,
    'last_name': lastnameController.text,
    'email': emailController.text,
    'password': passwordController.text,
    'ph_number': phoneController.text,
    'address': AddressController.text,
    'fees': feesController.text,
    'years_of_experience': experienceController.text,
    'universities': universityController.text,
    'rating': "3.4",  // Assuming a static rating
    'verified': "false",
    'account_type': "Lawyer",
    'preferences': jsonEncode(selectedSpecializations)
  };

  request.fields.addAll(fields);

  // Handling the file upload for the profile picture

  if (_image == null) {
  print('No image selected.');
  // Show an error or return
  return;
    }
  else 
 if (_image != null) {
    request.files.add(await http.MultipartFile.fromPath(
        'profile_picture',
        _image!.path,
        contentType: MediaType('image', 'jpeg')  // Ensure this matches the image type
    ));
    print('Uploading image: ${_image!.path}');
} else {
    print('No image selected.');
}

  // Send the request
  try {
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Registration successful');
      // Process the response to extract tempKey
      var responseBody = await http.Response.fromStream(response);
      var data = jsonDecode(responseBody.body);
      var tempKey = data['tempKey'];  // Extract tempKey from response
      print('Temporary Key: $tempKey');  // Print the tempKey
      print('Response Body: ${responseBody.body}');
      
       // Print the image file path before navigation
  if (_image != null) {
    print('Image to be passed: ${_image!.path}');
  } else {
    print('No image has been selected.');
  }

     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OTPVerificationPage(tempKey: tempKey, profileImage: _image,)));  // Navigate on success
    } else {
      print('Failed to register lawyer. Status code: ${response.statusCode}');
      var responseBody = await http.Response.fromStream(response);
      print('Failed reason: ${responseBody.body}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}
  void navigateToLoginPage() {
    Navigator.pushReplacementNamed(context, '/lawyerlogin');
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
                      "Welcome, Lawyer",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "Sign up to connect with clients",
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
                            controller: AddressController,
                            hintText: 'Office Address',
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
                          MyTextField(
                            controller: feesController,
                            hintText: 'Fees',
                            obscureText: false,
                            borderRadius: 30.0,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: experienceController,
                            hintText: 'Years of Experience',
                            obscureText: false,
                            borderRadius: 30.0,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          MyTextField(
                            controller: universityController,
                            hintText: 'University',
                            obscureText: false,
                            borderRadius: 30.0,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: screenHeight * 0.010),
                          Wrap(
                            children: specializations.map((String value) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChoiceChip(
                                  label: Text(value),
                                  selected: selectedSpecializations.contains(value),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        selectedSpecializations.add(value);
                                      } else {
                                        selectedSpecializations.remove(value);
                                      }
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: screenHeight * 0.020),
                        ],
                      ),
                    ),
                    MyButton2(
                      onTap: signUpLawyer,
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