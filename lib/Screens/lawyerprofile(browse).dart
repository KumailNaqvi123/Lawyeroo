import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services library
import 'package:flutter/gestures.dart'; // Import the gestures library

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LawyerProfilePageBrowse(),
      theme: ThemeData(
        fontFamily: 'Poppins', // Set the default font to Poppins
      ),
    );
  }
}

class LawyerProfilePageBrowse extends StatelessWidget {
  final String firstName = 'John';
  final String lastName = 'Doe';
  final String email = 'john.doe@example.com';
  final String phoneNumber = '+1234567890';
  final String address = '123 Main St, City';
  final String specializations = 'Random Specializations';
  final String experience = 'Random Experience';
  final String universities = 'Random Universities';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFddbafb), // Set app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today), // Icon for booking appointment
            onPressed: () {
              // Add your logic here for booking an appointment
              // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => BookAppointmentScreen()));
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFb884d1), // Set background color
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white.withOpacity(0.8), // Set whitish translucent color
                elevation: 0, // Remove elevation
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoField('First Name', firstName),
                      _buildInfoField('Last Name', lastName),
                      _buildInfoField('Email', email),
                      _buildInfoField('Phone Number', phoneNumber, true), // Pass true to indicate phone number field
                      _buildInfoField('Address', address),
                      _buildInfoField('Specializations', specializations),
                      _buildInfoField('Years of Experience', experience),
                      _buildInfoField('Universities', universities),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value, [bool isPhoneNumber = false]) {
    IconData iconData = Icons.error; // Default icon in case label doesn't match any case

    switch (label) {
      case 'First Name':
        iconData = Icons.person;
        break;
      case 'Last Name':
        iconData = Icons.person;
        break;
      case 'Email':
        iconData = Icons.email;
        break;
      case 'Phone Number':
        iconData = Icons.phone;
        break;
      case 'Address':
        iconData = Icons.location_on;
        break;
      case 'Specializations':
        iconData = Icons.star;
        break;
      case 'Years of Experience':
        iconData = Icons.work;
        break;
      case 'Universities':
        iconData = Icons.school;
        break;
      default:
        break; // No need for action as it will use the default icon
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            size: 30.0, // Set the size of the icon
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  if (isPhoneNumber) // Only show the copy icon if it's the phone number field
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: value)); // Copy to clipboard
                      },
                      child: Icon(Icons.content_copy), // Clipboard icon
                    ),
                  SizedBox(width: 8.0),
                  Text(
                    value,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
