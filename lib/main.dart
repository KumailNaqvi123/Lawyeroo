import 'package:flutter/material.dart';
import 'package:project/Screens/Option_screen.dart';
import 'package:project/Screens/forgotpassword.dart';
import 'package:project/Screens/lawyerhomepage.dart'; // Import the LawyerHomepage
import 'package:project/Screens/lawyersignup.dart';
import 'package:project/Screens/onboarding_screen2.dart';
import 'package:project/Screens/onboarding_screen3.dart';
import 'package:project/Screens/splash_screen.dart';
import 'package:project/Screens/onboarding_screen.dart'; // Import the OnboardingScreen
import 'package:project/Screens/login_page.dart'; // Import the LoginPage
// import 'package:project/Screens/signup_page.dart';
import 'package:project/Screens/signup2.dart';
import 'package:project/lawyerlogin.dart'; // Import the SignupPage
// import 'package:firebase_core/firebase_core.dart';

void main() async {
    //WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Set the navigatorKey
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route to '/'
      routes: {
        '/': (context) => SplashScreen(), // SplashScreen as the initial route
        '/onboarding': (context) => OnboardingScreen(),
        '/onboarding2': (context) => OnboardingScreen2(),
        '/onboarding3': (context) => OnboardingScreen3(),
        '/options': (context) => Options(),
        '/lawyerhomepage': (context) {
          var args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('token') && args.containsKey('userData')) {
            return LawyerHomepage(token: args['token']!, userData: args['userData']);
          } else {
            // Handle the error or redirect to a default page
            return const SplashScreen(); // Redirecting to SplashScreen or any other appropriate screen
          }
        },
        '/lawyerlogin': (context) => LawyerLoginPage(),
        '/lawyersignup': (context) => LawyerSignupPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/forgotPassword': (context) => ForgotPasswordPage(userData: {}, token: '',),
      },
    );
  }
}
