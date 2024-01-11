import 'package:flutter/material.dart';



class UserInfoPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String address;
  final String email;
  final String password;

  UserInfoPage({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lawyer Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('First Name: $firstName'),
            Text('Last Name: $lastName'),
            Text('Address: $address'),
            Text('Email: $email'),
            Text('Password: $password'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}