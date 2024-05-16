import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/login_page.dart';
import 'package:mime/mime.dart';

class ClientOTPVerificationPage extends StatefulWidget {
  final String tempKey;
  final File? profileImage;

  ClientOTPVerificationPage({Key? key, required this.tempKey, this.profileImage}) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<ClientOTPVerificationPage> {
  final TextEditingController otpController = TextEditingController();
  File? _profilePicture;

  @override
  void initState() {
    super.initState();
    _profilePicture = widget.profileImage;
  }

void verifyOTP() async {
  var uri = Uri.parse('${GlobalData().baseUrl}/api/clients/register-complete');
  var request = http.MultipartRequest('POST', uri);

  request.fields['tempKey'] = widget.tempKey;
  request.fields['otp'] = otpController.text;

  if (_profilePicture != null) {
    String filePath = _profilePicture!.path;
    String? mimeType = lookupMimeType(filePath);

    if (mimeType != null) {
      List<String> mimeTypes = mimeType.split('/');
      request.files.add(await http.MultipartFile.fromPath(
        'profile_picture',
        filePath,
        contentType: MediaType(mimeTypes[0], mimeTypes[1]),
      ));
    }
  }

  try {
    var response = await request.send();
    final responseBody = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseBody);
print("status code = $response.statusCode");
    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text(decodedResponse['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Failed"),
            content: Text(decodedResponse['message']),
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
  } catch (e) {
    print('Error occurred while sending request: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("An error occurred. Please try again."),
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
}


@override
Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return Scaffold(
    backgroundColor: Color(0xFF9F98C8), // Set background color
    appBar: null, // Remove the app bar
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Enter the OTP sent to your email",
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                    labelText: "OTP",
                    border: OutlineInputBorder(),
                    filled: true, // Set filled to true
                    fillColor: Colors.white, // Set fillColor to white
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => verifyOTP(),
                  child: Text("Verify"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1C798A), // Set button background color
                    foregroundColor: Colors.white, // Set button text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
