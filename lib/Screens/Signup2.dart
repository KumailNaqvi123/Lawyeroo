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
  int _currentPageIndex = 0;
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  List<String> preferences = [
    "Personal Injury Law",
    "Estate Planning Law",
    "Bankruptcy Law",
    "Intellectual Property Law",
    "Employment Law",
    "Corporate Law",
    "Immigration Law",
    "Criminal Law",
    "Medical Malpractice Law",
    "Tax Law",
    "Family Law",
    "Worker's Compensation Law",
    "Contract Law",
    "Social Security Disability Law",
    "Civil Litigation Law",
    "General Practice Law"
  ];
  List<String> selectedPreferences = [];

  File? _image;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
      contentType: MediaType('image', 'jpeg'),
    ));
  }

  try {
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    
    if (response.statusCode == 200) {
      print('Registration successful');
      var tempKey = jsonDecode(responseBody)['tempKey'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ClientOTPVerificationPage(
            tempKey: tempKey,
            profileImage: _image,
          ),
        ),
      );
      return; // Exit the method after successful registration
    }
    
    if (response.statusCode == 409) {
      showErrorDialog('Failed to register. The account already exists.');
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.140),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCard1(screenHeight, screenWidth),
                    _buildCard2(screenHeight, screenWidth),
                    _buildCard3(screenHeight, screenWidth),
                    _buildCard4(screenHeight, screenWidth),
                    _buildCard5(screenHeight, screenWidth)
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Added for spacing
              // MyButton2(
              //   onTap: signUpUser, // Set the onTap function to signUpUser
              // ),
              SizedBox(height: screenHeight * 0.01), // Added for spacing
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
        ],
      ),
    ),
  );
}

Widget _buildCard1(double screenHeight, double screenWidth) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: screenHeight * 0.020),
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
        SizedBox(height: screenHeight * 0.020),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios), // Arrow icon
              SizedBox(width: 8), // Adding space between icon and text
              Text(
                "Swipe Left",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  // Method for the second card
// Method for the second card
Widget _buildCard2(double screenHeight, double screenWidth) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
          controller: addressController,
          hintText: 'Address',
          obscureText: false,
          borderRadius: 30.0,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: screenHeight * 0.020),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                "Swipe Left",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(width: 8), // Adding space between icon and text
              Icon(Icons.arrow_back_ios), // Arrow icon pointing backward
            ],
          ),
        ),
      ],
    ),
  );
}


  // Method for the third card
Widget _buildCard3(double screenHeight, double screenWidth) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: screenHeight * 0.010),
        MyTextField(
          controller: emailController,
          hintText: 'Email',
          obscureText: false,
          borderRadius: 30.0,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: screenHeight * 0.010),
        MyTextField(
          controller: passwordController,
          hintText: 'Password (Minimum 6 characters)',
          obscureText: true,
          borderRadius: 30.0,
        ),
        SizedBox(height: screenHeight * 0.020),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios), // Arrow icon pointing backward
              SizedBox(width: 8), // Adding space between icon and text
              Text(
                "Swipe Left",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  // Method for the fourth card (No changes needed)
Widget _buildCard4(double screenHeight, double screenWidth) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 1.0, // Horizontal spacing between chips
          runSpacing: 1.0, // Vertical spacing between rows of chips
          children: preferences.map((String value) {
            return Padding(
              padding: const EdgeInsets.all(1.0), // Reduced padding around each chip
              child: ChoiceChip(
                label: Text(
                  value,
                  style: TextStyle(fontSize: 8), // Decreased chip text size
                ),
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
                labelStyle: TextStyle(fontSize: 8), // Decreased chip label size
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce chip size
              ),
            );
          }).toList(),
        ),
        SizedBox(height: screenHeight * 0.020),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios), // Arrow icon pointing backward
              SizedBox(width: 5), // Adding space between icon and text
              Text(
                "Swipe Left",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


 Widget _buildCard5(double screenHeight, double screenWidth) {
  _currentPageIndex = 4;
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
              borderRadius: BorderRadius.circular(screenWidth * 0.2),
            ),
            child: _image == null
                ? Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.grey[400],
                  )
                : ClipOval(
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                    ),
                  ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02), // Added for spacing
        MyButton2(
          onTap: signUpUser, // Set the onTap function to signUpUser
        ),
        SizedBox(height: screenHeight * 0.02), // Added for spacing
      ],
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
        print('Image Path: ${_image!.path}'); // Log the image path
      } else {
        print('No image selected.');
      }
    });
  }
}
