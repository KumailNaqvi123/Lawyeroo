import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText; // Define the parameter

  const MyButton({Key? key, required this.onTap, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.7; // Adjust the width as needed
    final buttonHeight = screenWidth * 0.17; // Adjust the height as needed

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth, // Set the width
        height: buttonHeight, // Set the height
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(0xFF75A1A7),
          borderRadius: BorderRadius.circular(buttonWidth * 0.1), // Adjust border radius relative to width
        ),
        child: Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: buttonWidth * 0.1, // Adjust font size relative to width
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}


class MyButton2 extends StatelessWidget {
  final Function()? onTap;

  const MyButton2({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.7; // Adjust the width as needed
    final buttonHeight = screenWidth * 0.17; // Adjust the height as needed

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth, // Set the width
        height: buttonHeight, // Set the height
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(0xFF75A1A7),
          borderRadius: BorderRadius.circular(buttonWidth * 0.1), // Adjust border radius relative to width
        ),
        child: Center(
          child: Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: buttonWidth * 0.1, // Adjust font size relative to width
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}




class MyButton3 extends StatelessWidget {
  final Function()? onTap;

  const MyButton3({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.7; // Adjust the width as needed
    final buttonHeight = screenWidth * 0.17; // Adjust the height as needed

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth, // Set the width
        height: buttonHeight, // Set the height
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(0xFF75A1A7),
          borderRadius: BorderRadius.circular(buttonWidth * 0.1), // Adjust border radius relative to width
        ),
        child: Center(
          child: Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: buttonWidth * 0.1, // Adjust font size relative to width
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}



class MyButton4 extends StatelessWidget {
  final String text; // Define the text parameter
  final VoidCallback onTap;

  const MyButton4({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: Color(0xFF187d89), // Change color as needed
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}