import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/Screens/home_screen.dart';
import 'package:project/Screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget
{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
 with SingleTickerProviderStateMixin
{

  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);


    Future.delayed(const Duration(seconds: 2), ()
    {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => OnboardingScreen(),
    ),
    );
    });
  }

  @override
  void dispose()
  {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:Container(
        color: const Color(0x99F5CDD2),
        child: Center
        (child:Image.asset('assets/images/lawyer.png', // Replace with your image
            fit: BoxFit.contain, // Center the image within the container))
      ),
        ),
    )
    );
  }

}
