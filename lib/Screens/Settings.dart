import 'package:flutter/material.dart';
import 'package:project/Screens/Client_appointments.dart';
import 'package:project/Screens/Lawyerprofile.dart';
import 'package:project/Screens/News.dart';
import 'package:project/Screens/contact_screen.dart';
import 'package:project/Screens/home_screen.dart';
import 'package:project/Screens/profile.dart';
import 'package:project/Screens/qna_board.dart';
import 'package:project/Screens/reportanissue.dart';
import 'package:project/Screens/FavoriteLawyersPage.dart';
import 'package:project/Screens/ClientCase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
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
            leading: Icon(Icons.star), // Add an appropriate icon for favorite lawyers
            title: Text('Favorite Lawyers'),
            onTap: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteLawyersPage(),
                  ),
                );
          },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: () {
              // Simulate user type (replace with your actual logic to determine user type)
              String userType = 'client'; // or 'lawyer'

              if (userType == 'client') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientProfilePage(),
                  ),
                );
              } else if (userType == 'lawyer') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawyerProfilePage(),
                  ),
                );
              }
            },
          ),
          ListTile(
  leading: Icon(Icons.calendar_today),
  title: Text('View Appointments'),
  onTap: () {
    // Navigate to ClientAppointmentsPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentsPage(),
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
              builder: (context) =>ClientCasesPage(),
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
                MaterialPageRoute(builder: (context) => HomeScreen()),
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
                  builder: (context) => ContactsScreen(context: context),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.article),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.question_answer),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QnABoard()),
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

class ClientAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Appointments'),
        backgroundColor: Color(0xFFDCBAFF),
      ),
      body: Center(
        child: Text('Client Appointments Page'),
      ),
    );
  }
}

class LawyerAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lawyer Appointments'),
        backgroundColor: Color(0xFFDCBAFF),
      ),
      body: Center(
        child: Text('Lawyer Appointments Page'),
      ),
    );
  }
}
