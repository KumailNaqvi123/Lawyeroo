import 'dart:io';

import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String address;
  final String email;
  final String password;
  final String phone;
  final String fees;
  final String experience;
  final String university;
  final List<String> specializations; // Modified specialization parameter
  final File? profileImage; // Add profileImage parameter


  UserInfoPage({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.password,
    required this.phone,
    required this.fees,
    required this.experience,
    required this.university,
    required this.specializations, // Modified specialization parameter
    this.profileImage, // Add profileImage parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lawyer Information'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'First Name: $firstName',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Last Name: $lastName',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Address: $address',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Password: $password',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Phone Number: $phone',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Fees: $fees',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Years of Experience: $experience',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'University: $university',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Specializations:', // Update the label to indicate multiple specializations
              style: TextStyle(fontSize: 16),
            ),
            Column( // Display each specialization in a separate Text widget
              crossAxisAlignment: CrossAxisAlignment.start,
              children: specializations.map((spec) => Text(
                '- $spec',
                style: TextStyle(fontSize: 16),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
