import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LawyerProfilePageBrowse(),
    );
  }
}

class LawyerProfilePageBrowse extends StatelessWidget {
  final String firstName = 'John';
  final String lastName = 'Doe';
  final String email = 'john.doe@example.com';
  final String phoneNumber = '+1234567890';
  final String address = '123 Main St, City';
  final String password = '********';
  final String specializations = 'Random Specializations';
  final String experience = 'Random Experience';
  final String universities = 'Random Universities';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildInfoField('First Name', firstName),
          _buildInfoField('Last Name', lastName),
          _buildInfoField('Email', email),
          _buildInfoField('Phone Number', phoneNumber),
          _buildInfoField('Address', address),
          _buildInfoField('Password', password),
          _buildInfoField('Specializations', specializations),
          _buildInfoField('Years of Experience', experience),
          _buildInfoField('Universities', universities),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Replace this with the logic for booking an appointment
              // For example, you can navigate to a new screen for appointment booking
              // Navigator.push(context, MaterialPageRoute(builder: (context) => BookAppointmentScreen()));
            },
            child: Text('Book Appointment'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
