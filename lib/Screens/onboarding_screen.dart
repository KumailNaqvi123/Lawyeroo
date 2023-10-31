import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/Screens/home_screen.dart';
import 'package:project/Screens/login_page.dart';

class MyOnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to My App!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'This is a single onboarding page.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  },
  child: Text('Get Started'),
)
          ],
        ),
      ),
    );
  }
}


















/*class OnboardingScreen extends StatefulWidget{
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnboardingScreen>{

  List onBoardingData=[
    {
      "image":'assets/images/getstarted.png',
      "title":'Find lawyer',
      "description":'lawyer'
    }
  ];


  Color whiteColor = Colors.white;
  Color otherColor = const Color(0xFF19173D);

  PageController pageController = PageController();


  @override
  Widget build(BuildContext context)
  {

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
      );


    return Scaffold(
      backgroundColor: whiteColor,

      appBar: AppBar(
      centerTitle:true,
      backgroundColor: Colors.transparent,
        
      ),
      body: Stack(children: [
          PageView.builder(
              controller: PageController,
              itemCount: onBoardingData.length,
               
               itemBuilder: (context, index )
               {
                return Column(
                  children: [
                    Image.asset(onBoardingData[index]['image']),

                    const SizedBox(height: 20,),

                    Text(onBoardingData[index]['title'],style: TextStyle(fontSize: 20, color: otherColor)
                    ),


                  ],
                  );
               },


          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [



          ],)

      ],
      ),
    );
  }
}*/