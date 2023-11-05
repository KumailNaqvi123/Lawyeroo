import 'package:flutter/material.dart';
import 'package:project/Screens/my_button.dart';
import 'package:project/Screens/my_textfield.dart';
import 'package:project/Screens/square_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD1C5C5), // Change the background color
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),

                // Logo (replace with an image)
                Image.asset(
                  'assets/images/lawyer2.png', // Replace with the actual image path
                  width: 100,
                  height: 100,
                ),

                SizedBox(height: screenHeight * 0.015),

                // Username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                SizedBox(height: screenHeight * 0.015),

                // Password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                SizedBox(height: screenHeight * 0.015),

                // Remember Me and Forgot Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure equal spacing
                    children: [
                      Row(
                        children: [
                          // Checkbox for 'Remember Me'
                        Checkbox(
                        value: rememberMe,
                          onChanged: (value) {
                                  // Toggle the 'Remember Me' state
                                setState(() {
                                      rememberMe = value ?? false; // Use the null-aware operator to handle null
                                                });
                                                }, 
),
                          Text(
                            'Remember Me',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                // Sign in button
                MyButton(
                  onTap: signUserIn,
                ),

                SizedBox(height: screenHeight * 0.05),

                // Or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // Google + Apple sign-in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button
                    SquareTile(imagePath: 'lib/images/google.png'),

                    SizedBox(width: 25),

                    // Apple button
                    SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),

                SizedBox(height: screenHeight * 0.05),

                // Not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Register now',
                      style: TextStyle(
                        color: const Color(0xFF75A1A7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// import 'package:project/Screens/my_button.dart';
// import 'package:project/Screens/my_textfield.dart';
// import 'package:project/Screens/square_tile.dart';

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});

//   // text editing controllers
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   // sign user in method
//   void signUserIn() {}

//   @override
//   Widget build(BuildContext context) {
//     // Get the screen size
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//             backgroundColor: const Color(0xFFD1C5C5), // Change the background color
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: screenHeight * 0.05),

//                 // Logo (replace with an image)
//                 Image.asset(
//                   'assets/images/lawyer2.png', // Replace with the actual image path
//                   width: 100,
//                   height: 100,
//                 ),

//                 SizedBox(height: screenHeight * 0.015),

//                 // Username textfield
//                 MyTextField(
//                   controller: usernameController,
//                   hintText: 'Username',
//                   obscureText: false,
//                 ),

//                 SizedBox(height: screenHeight * 0.015),

//                 // Password textfield
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   obscureText: true,
//                 ),

//                 SizedBox(height: screenHeight * 0.015),

//                 // Forgot password?
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         'Forgot Password?',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: screenHeight * 0.025),

//                 // Sign in button
//                 MyButton(
//                   onTap: signUserIn,
//                 ),

//                 SizedBox(height: screenHeight * 0.05),

//                 // Or continue with
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Text(
//                           'Or continue with',
//                           style: TextStyle(color: Colors.grey[700]),
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: screenHeight * 0.05),

//                 // Google + Apple sign-in buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Google button
//                     SquareTile(imagePath: 'lib/images/google.png'),

//                     SizedBox(width: 25),

//                     // Apple button
//                     SquareTile(imagePath: 'lib/images/apple.png')
//                   ],
//                 ),

//                 SizedBox(height: screenHeight * 0.05),

//                 // Not a member? Register now
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Dont have an account?',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     SizedBox(width: 4),
//                     Text(
//                       'Register now',
//                       style: TextStyle(
//                         color: const Color(0xFF75A1A7),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }