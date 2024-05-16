import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogle extends StatefulWidget {
  @override
  _SignInWithGoogleState createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Send this information to your backend (e.g., via HTTP)
        print('Token: ${googleAuth.accessToken}');
        print('ID Token: ${googleAuth.idToken}');

        // You can also include user details
        print('User Name: ${googleUser.displayName}');
        print('User Email: ${googleUser.email}');

        // Redirect or perform actions after the successful login
        Navigator.pushReplacementNamed(context, '/home'); // Adjust route as necessary
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Sign-In')),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: Text('Sign In with Google'),
        ),
      ),
    );
  }
}
