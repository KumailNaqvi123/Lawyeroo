import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services library
import 'dart:convert';


class LawyerProfilePageBrowse extends StatelessWidget {
  final Map<String, dynamic> lawyerData;

  LawyerProfilePageBrowse({required this.lawyerData});

  @override
  Widget build(BuildContext context) {
    print("Current Page: Lawyer Profile (Browse Mode)");
    print("Lawyer Data: $lawyerData"); // This will help verify what is received in the lawyerData

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
                      _buildInfoField('First Name', lawyerData['first_name']),
                      _buildInfoField('Last Name', lawyerData['last_name']),
                      _buildInfoField('Email', lawyerData['email']),
                      _buildInfoField('Phone Number', lawyerData['ph_number']),
                      _buildInfoField('Address', lawyerData['address']),
                      _buildInfoField('Specializations', _formatSpecializations(lawyerData['specializations'])),
                      _buildInfoField('Years of Experience', lawyerData['years_of_experience']),
                      _buildInfoField('Universities', lawyerData['universities']),
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
    case 'First Name': iconData = Icons.person; break;
    case 'Last Name': iconData = Icons.person; break;
    case 'Email': iconData = Icons.email; break;
    case 'Phone Number': iconData = Icons.phone; break;
    case 'Address': iconData = Icons.location_on; break;
    case 'Specializations': iconData = Icons.star; break;
    case 'Years of Experience': iconData = Icons.work; break;
    case 'Universities': iconData = Icons.school; break;
    default: break;
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