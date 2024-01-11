import 'package:flutter/material.dart';
import 'package:project/Screens/Lawyerprofile.dart';
import 'package:project/Screens/MyStatisticsPage.dart';
import 'package:project/Screens/lawyercontactscreen.dart';
import 'package:project/Screens/lawyerhomepage.dart';
import 'package:project/Screens/lawyernotificiations.dart';
import 'package:project/Screens/reportanissue.dart';
import 'package:project/Screens/lawyercases.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      home: LawyerSettingsPage(),
    );
  }
}

class LawyerSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDCBAFF), // Set the AppBar background color
        title: Text(
          'My Profile',
          style: TextStyle(
            fontSize: 18.0, // Adjust the font size as needed
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFDCBAFF), // Set the container background color
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/passport.png',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Logged in as: John Doe',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Static list of items
          ListTile(
  leading: Icon(Icons.equalizer),
  title: Text('My Statistics'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyStatisticsPage(), // Create a new page for My Statistics
      ),
    );
  },
),

ListTile(
  leading: Icon(Icons.edit),
  title: Text('Edit Profile'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LawyerProfilePage(),
      ),
    );
  },
),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle onTap for Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('Cases'),
            onTap: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>LawyerCasesPage(),
                  ),
                );
            },
          ),
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text('Report'),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) =>ReportIssuePage(),
        ),
      );
    },
),
        ],
      ),
      bottomNavigationBar: _buildNavBar(context), // Pass context here
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return Container(
      color: Color(0xFFDCBAFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Navigate to the HomeScreen and remove all previous routes from the stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LawyerHomepage()),
                (route) => false, // This will remove all previous routes from the stack
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LawyerContactsScreen(context: context),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LawyerNotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Color(0xFF912bFF)),
            onPressed: () {
              // Handle profile button press
            },
          ),
        ],
      ),
    );
  }
}

