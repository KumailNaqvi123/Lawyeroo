import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services library
import 'dart:convert';


class LawyerProfilePageBrowse2 extends StatelessWidget {
  final Map<String, dynamic> lawyerData2;

  LawyerProfilePageBrowse2({required this.lawyerData2});

  @override
  Widget build(BuildContext context) {
    print("Current Page: Lawyer Profile (Browse Mode)");
    print("Lawyer Data: $lawyerData2"); // This will help verify what is received in the lawyerData2

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFddbafb),
      ),
      backgroundColor: Color(0xFFb884d1),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white.withOpacity(0.8),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoField('First Name', lawyerData2['first_name']),
                      _buildInfoField('Last Name', lawyerData2['last_name']),
                      _buildInfoField('Email', lawyerData2['email']),
                      _buildInfoField('Phone Number', lawyerData2['ph_number']),
                      _buildInfoField('Address', lawyerData2['address']),
                      _buildInfoField('Specializations', _formatSpecializations(lawyerData2['specializations'])),
                      _buildInfoField('Years of Experience', lawyerData2['years_of_experience']),
                      _buildInfoField('Universities', lawyerData2['universities']),
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

 Widget _buildInfoField(String label, dynamic value) {
  IconData iconData = Icons.error; // Default icon
  switch (label) {
    case 'First Name':
    case 'Last Name':
    case 'Email':
    case 'Phone Number':
    case 'Address':
    case 'Specializations':
    case 'Years of Experience':
    case 'Universities':
      iconData = Icons.error;
      break;
  }

  String displayValue = value.toString(); // Convert value to string
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(iconData, size: 30.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Text(displayValue, style: TextStyle(fontSize: 16.0)),
            ],
          ),
        ),
      ],
    ),
  );
}

  String _formatSpecializations(dynamic specializations) {
    if (specializations is List) {
      return specializations.join(", ");
    } else if (specializations is String) {
      return specializations;
    } else {
      return 'Not Available';
    }
  }
}