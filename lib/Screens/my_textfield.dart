import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double borderRadius; // Add this line for border radius

  MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.borderRadius = 12.0, // Set a default value or adjust as needed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust the horizontal padding
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 14.0), // Adjust the font size
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 18.0 , horizontal: 10), // Adjust the vertical padding
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
