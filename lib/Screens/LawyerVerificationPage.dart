import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:project/Screens/lawyerhomepage.dart';
import 'package:mime/mime.dart';

class OTPVerificationPage extends StatefulWidget {
  final String tempKey;
  final File? profileImage;  // Correct property name

  OTPVerificationPage({Key? key, required this.tempKey, this.profileImage}) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController otpController = TextEditingController();
  File? _profilePicture;

  @override
  void initState() {
    super.initState();
    _profilePicture = widget.profileImage;  // Use the passed profileImage directly
  }

  void verifyOTP() async {
    var uri = Uri.parse('http://192.168.10.2:3000/api/lawyers/register-complete');
    var request = http.MultipartRequest('POST', uri);

    request.fields['tempKey'] = widget.tempKey;
    request.fields['otp'] = otpController.text;

    // Add the image to the request with the correct MIME type
if (_profilePicture != null) {
  // Safely access the path with a null check
  String filePath = _profilePicture!.path; // This ensures that path is accessed only if _profilePicture is not null
  String? mimeType = lookupMimeType(filePath); // Use lookupMimeType instead of mime

  if (mimeType != null) {
    List<String> mimeTypes = mimeType.split('/'); // Split mimeType into type and subtype

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
  var decodedResponse = json.decode(responseBody); // Decode the JSON response

  if (response.statusCode == 200) {
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
                  MaterialPageRoute(builder: (context) => LawyerHomepage()),
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
}
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_profilePicture != null)
              Image.file(_profilePicture!),
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
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => verifyOTP(),
              child: Text("Verify"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
