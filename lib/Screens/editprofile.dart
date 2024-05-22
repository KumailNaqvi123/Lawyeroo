import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:project/Screens/Global.dart';

class EditClientProfilePage extends StatefulWidget {
  GlobalData globalData = GlobalData();

  final String clientId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String profilePicture;
  final Map<String, dynamic> userData;
  final token;
  final Function(Map<String, dynamic>) onUpdateComplete;

  EditClientProfilePage({
  required this.clientId,
  required this.firstName,
  required this.lastName,
  required this.email,
  required this.phoneNumber,
  required this.address,
  required this.profilePicture,
  required this.userData,
  required this.token,
  required this.onUpdateComplete, // Added callback
});

  @override
  _EditClientProfilePageState createState() => _EditClientProfilePageState();
}

class _EditClientProfilePageState extends State<EditClientProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Map<String, bool> lawyerSpecializations = {
    "Personal Injury Lawyer": false,
    "Estate Planning Lawyer": false,
    "Bankruptcy Lawyer": false,
    "Intellectual Property Lawyer": false,
    "Employment Lawyer": false,
    "Corporate Lawyer": false,
    "Immigration Lawyer": false,
    "Criminal Lawyer": false,
    "Medical Malpractice Lawyer": false,
    "Tax Lawyer": false,
    "Family Lawyer": false,
    "Worker's Compensation Lawyer": false,
    "Contract Lawyer": false,
    "Social Security Disability Lawyer": false,
    "Civil Litigation Lawyer": false,
    "General Practice Lawyer": false
};

void _showSpecializationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return AlertDialog(
              title: Text("Select Preferences"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: lawyerSpecializations.keys.map((String key) {
                    return CheckboxListTile(
                      title: Text(key),
                      value: lawyerSpecializations[key],
                      onChanged: (bool? value) {
                        setStateDialog(() {
                          lawyerSpecializations[key] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Save'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _savePreferences();
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _savePreferences() {
  // Logic to save preferences
  print('Preferences saved: $lawyerSpecializations');
}

 @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _emailController = TextEditingController(text: widget.email);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _addressController = TextEditingController(text: widget.address);

    // Initialize preferences
    initializespecializations();
  }

   void initializespecializations() {
  // Assuming preferences come as a JSON-encoded string from userData
  var specializationsStr = widget.userData['specializations'] as String? ?? '[]';
  List<dynamic> specializationsList;
  try {
    specializationsList = json.decode(specializationsStr);
  } catch (e) {
    specializationsList = [];
    print('Error parsing specializations: $e');
  }

  lawyerSpecializations = {
    'Family Law': specializationsList.contains('Family Law'),
    'Criminal Law': specializationsList.contains('Criminal Law'),
    'Business Law': specializationsList.contains('Business Law'),
    'Employment Law': specializationsList.contains('Employment Law'),
    'Tax Law': specializationsList.contains('Tax Law'),
  };
}

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  ImageProvider<Object> _getImage() {
    if (_imageFile != null) {
      return FileImage(_imageFile!);
    } else if (widget.profilePicture.isNotEmpty) {
      return NetworkImage(widget.profilePicture);
    } else {
      return AssetImage('assets/images/default_avatar.png');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Edit Profile'),
      centerTitle: true,
      backgroundColor: Color(0xFFDCBAFF),
     actions: [
        // Using TextButton for better accessibility and interaction
        TextButton(
          onPressed: _saveProfile,
          child: Text('Save', style: TextStyle(color: Colors.black)), // Set text color to white to match AppBar
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFDCBAFF), // Ensure the ripple effect is also in white
          ),
        ),
      ],
    ),
    backgroundColor: Color(0xFFDCBAFF),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _getImage(),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Light grey circle background
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, size: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),  // Adjusted spacing
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField('First Name', _firstNameController),
                  _buildTextField('Last Name', _lastNameController),
                  _buildTextField('Email', _emailController),
                  _buildTextField('Phone Number', _phoneNumberController),
                  _buildTextField('Address', _addressController),
                  SizedBox(height: 10), // Adjusted spacing
                  ElevatedButton(
                    onPressed: _showSpecializationsDialog,
                    child: Text('Specializations'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDCBAFF),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 5), // Adjusted spacing
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTextField(String labelText, TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0), // Adjusted vertical padding
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjusted content padding
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

void _saveProfile() async {
  var url = Uri.parse('${GlobalData().baseUrl}/api/clients/update-client/${widget.clientId}');
  var request = http.MultipartRequest('PUT', url);

  // Add headers
  request.headers.addAll({
    'Authorization': 'Bearer ${widget.token}',
  });

  // Add text fields
  request.fields['first_name'] = _firstNameController.text;
  request.fields['last_name'] = _lastNameController.text;
  request.fields['email'] = _emailController.text;
  request.fields['ph_number'] = _phoneNumberController.text;
  request.fields['address'] = _addressController.text;

  // Add Specializations as a JSON string
  List<String> selectedSpecializations = lawyerSpecializations.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();
  request.fields['specializations'] = jsonEncode(selectedSpecializations);

  // Handle the profile picture file
  if (_imageFile != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'profile_picture',
      _imageFile!.path,
    ));
  }

  // Send the request
  var response = await request.send();

if (response.statusCode == 200) {
  // Fetch and parse the updated data from the response stream
  response.stream.transform(utf8.decoder).listen((value) {
    Map<String, dynamic> responseData = json.decode(value);
    Map<String, dynamic> updatedUserData = responseData['data'];
    print('Profile updated successfully');
    GlobalData().userData = responseData['data'];
    // Call the callback to update the parent state with new user data
    widget.onUpdateComplete(updatedUserData);

    Navigator.pop(context); // Close the edit profile page
  });
}
 else {
    print('Failed to update profile');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to update profile'))
    );
  }
}
}