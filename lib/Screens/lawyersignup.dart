import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Screens/Global.dart';
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
  int _currentPageIndex = 0;
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController feesController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController universityController = TextEditingController();

  List<String> specializations = [
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
  List<String> selectedSpecializations = [];

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
        addressController.text.isEmpty ||
        feesController.text.isEmpty || // Ensure fees are not empty
        experienceController.text.length < 2 || // Ensure experience is not empty
        universityController.text.isEmpty) { // Ensure university is not empty
      print('Validation failed');
      return false;
    }
    return true;
  }


  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

   bool isValidFees(String fees) {
    final regex = RegExp(r'^\d{1,2}$'); // Regex for 1 or 2 digits
    return regex.hasMatch(fees);
  }

  bool isValidExperience(String experience) {
    final regex = RegExp(r'^\d+$'); // Regex for only digits
    return regex.hasMatch(experience);
  }

  bool isValidUniversity(String university) {
    final regex = RegExp(r'^[a-zA-Z\s]+$'); // Regex for only letters and spaces
    return regex.hasMatch(university);
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

  var uri = Uri.parse('${GlobalData().baseUrl}/api/lawyers/register-lawyer');
  var request = http.MultipartRequest('POST', uri);

  // Adding fields to the request
  Map<String, String> fields = {
    'first_name': firstnameController.text,
    'last_name': lastnameController.text,
    'email': emailController.text,
    'password': passwordController.text,
    'ph_number': phoneController.text,
    'address': addressController.text,
    'fees': feesController.text,
    'years_of_experience': experienceController.text,
    'universities': universityController.text,
    'rating': "3.4",  // Assuming a static rating
    'verified': "false",
    'account_type': "Lawyer",
    'specializations': jsonEncode(selectedSpecializations)
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
                        "Your Clients await you",
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
                      _buildCard5(screenHeight, screenWidth),
                      _buildCard6(screenHeight, screenWidth),
                      _buildCard7(screenHeight, screenWidth),
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

Widget _buildCard4(double screenHeight, double screenWidth) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: screenHeight * 0.010),
        MyTextField(
          controller: universityController,
          hintText: 'University',
          obscureText: false,
          borderRadius: 30.0,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: screenHeight * 0.010),
        MyTextField(
          controller: experienceController,
          hintText: 'Experience',
          obscureText: false,
          borderRadius: 30.0,
          keyboardType: TextInputType.phone,
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

Widget _buildCard5(double screenHeight, double screenWidth) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: screenHeight * 0.010),
        MyTextField(
          controller: feesController,
          hintText: 'Fees',
          obscureText: false,
          borderRadius: 30.0,
          keyboardType: TextInputType.phone,
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

  // Method for the fourth card (No changes needed)
Widget _buildCard6(double screenHeight, double screenWidth) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 1.0, // Horizontal spacing between chips
          runSpacing: 1.0, // Vertical spacing between rows of chips
          children: specializations.map((String value) {
            return Padding(
              padding: const EdgeInsets.all(1.0), // Reduced padding around each chip
              child: ChoiceChip(
                label: Text(
                  value,
                  style: TextStyle(fontSize: 8), // Decreased chip text size
                ),
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



 Widget _buildCard7(double screenHeight, double screenWidth) {
  _currentPageIndex = 6;
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
            width: screenWidth * 0.2,
            height: screenWidth * 0.2,
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
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                    ),
                  ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02), // Added for spacing
        MyButton2(
          onTap: signUpLawyer, // Set the onTap function to signUpUser
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
