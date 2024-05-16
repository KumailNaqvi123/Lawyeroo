import 'package:flutter/material.dart';
import 'package:project/Screens/Lnews.dart';
import 'package:project/Screens/Lawyer_appointments.dart';
import 'package:project/Screens/contact_screen.dart';
import 'package:project/Screens/lawyercontactscreen.dart';
import 'package:project/Screens/lawyernotificiations.dart';
import 'package:project/Screens/lawyerqna.dart';
import 'package:project/Screens/lawyersettings.dart';
import 'package:project/Screens/BlogsAndArticles.dart';

class LawyerHomepage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  LawyerHomepage({Key? key, required this.token, required this.userData});

  @override
  _LawyerHomepageState createState() => _LawyerHomepageState();
}

class _LawyerHomepageState extends State<LawyerHomepage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navigatorKey.currentState!.canPop()) {
          navigatorKey.currentState!.pop();
          return false;
        }
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFFDCBAFF),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/L.png',
            height: 30,
            width: 30,
          ),
          SizedBox(width: 8),
          Text(
            'Home',
            style: TextStyle(
              color: Color(0xFF30417c),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBody() {
    return Container(
      color: Color(0xFF6E5ED7),
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return FeatureItemWidget(
                  label: getFeatureLabel(index),
                  image: getFeatureImage(index),
                  onTap: () {
                    handleFeatureTap(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: Color(0xFFDCBAFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: Color(0xFF912bFF)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LawyerHomepage(
                    token: widget.token,
                    userData: widget.userData,
                  ),
                ),
                (route) => false,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
builder: (context) => ContactsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LawyerNotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LawyerSettingsPage(token: widget.token, userData: widget.userData)),
              );
            },
          ),
        ],
      ),
    );
  }

  String getFeatureLabel(int index) {
    switch (index) {
      case 0:
        return 'Appointments';
      case 1:
        return 'News';
      case 2:
        return 'Legal Blogs';
      case 3:
        return 'Q&A Board';
      default:
        return '';
    }
  }

  String getFeatureImage(int index) {
    switch (index) {
      case 0:
        return 'assets/images/Rectangle51.png';
      case 1:
        return 'assets/images/Rectangle52.png';
      case 2:
        return 'assets/images/Rectangle53.png';
      case 3:
        return 'assets/images/Rectangle54.png';
      default:
        return '';
    }
  }

  void handleFeatureTap(int index) {
  switch (index) {
    case 0:
      final lawyerId = widget.userData['id']?.toString() ?? '';
      if (lawyerId.isEmpty) {
        print("Error: Lawyer ID is empty");
        return;
      }
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => LawyerAppointmentsPage(
            lawyerId: lawyerId,
            token: widget.token,
          ),
        ),
      );
      break;
    case 1:
      final lawyerId = widget.userData['id']?.toString() ?? '';
      if (lawyerId.isEmpty) {
        print("Error: Lawyer ID is empty");
        return;
      }
      navigatorKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) => LNewsPage(userId: lawyerId),
          ),
      );
      break;
    case 2:
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => LawyerBlogsPage(token: widget.token, userData: widget.userData)),
      );
      break;
    case 3:
      // Printing token and userData to the console
      print("Navigating to Q&A Board with token: ${widget.token} and userData: ${widget.userData}");
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => LawyerQnABoard(
              token: widget.token, userData: widget.userData),
        ),
      );
      break;
  }
}
}

class FeatureItemWidget extends StatelessWidget {
  final String label;
  final String image;
  final VoidCallback onTap;

  FeatureItemWidget({
    required this.label,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        backgroundColor: Color(0xFF30417C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF30417C),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

