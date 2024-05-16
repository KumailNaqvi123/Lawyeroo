import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/Screens/Client_appointments.dart';
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/News.dart';
import 'package:project/Screens/contact_screen.dart';
import 'package:project/Screens/home_screen.dart';
import 'package:project/Screens/profile.dart';
import 'package:project/Screens/qna_board.dart';
import 'package:project/Screens/reportanissue.dart';
import 'package:project/Screens/FavoriteLawyersPage.dart';
import 'package:project/Screens/ClientCase.dart';


class SettingsPage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;
  final List<dynamic> lawyerData;  // Change this to non-nullable if it's expected always

  SettingsPage({
    required this.token,
    required this.userData,
    required this.lawyerData,  // Ensure it's passed when creating the SettingsPage
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
Map<String, dynamic> userData = {}; // Store user data here

@override
void initState() {
super.initState();
// fetchData(); // Fetch user data on init
    print("hello! you are now on settings page!");
    print("Token: ${widget.token}"); // Print the token
    print("User Data: ${widget.userData}"); // Print all user data
     if (widget.lawyerData != null) {
      print("Lawyer Data: ${widget.lawyerData}");  // Print lawyer data if available
    }
    updateUserData(GlobalData().userData);
  }
  void updateUserData(Map<String, dynamic> newData) {
    setState(() {
      userData = GlobalData().userData; // Update user data
    });
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDCBAFF),
        title: Text(
          'My Profile',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Color(0xFFDCBAFF),  // Set the background color for the whole body
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      widget.userData.isNotEmpty ? userData['profile_picture'] : 'assets/images/profile.png'
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.userData.isNotEmpty ? userData['first_name']+" "+userData['last_name'] : 'Loading...',
                    style: TextStyle(color: Colors.white, fontSize: 18)
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )
                ),
                color: Colors.white, // Set the Card color to white
                child: ListView(
                  children: [
                  _buildListTile(context, Icons.star, 'Favorite Lawyers', FavoriteLawyersPage(token: widget.token,userData: widget.userData)),
                  _buildListTile(context, Icons.edit, 'View Profile', ClientProfilePage(token: widget.token, userData: widget.userData, )),
                  _buildListTile(context, Icons.calendar_today, 'View Appointments', AppointmentsPage(token: widget.token, userData: widget.userData)),
                  _buildListTile(context, Icons.folder, 'Cases', ClientCasesPage(token: widget.token, userData: widget.userData)),
                  _buildListTile(context, Icons.insert_chart, 'Report', ReportIssuePage(token: widget.token, userData: widget.userData)),
                 ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavBar(context),
    );
  }
  Widget _buildListTile(BuildContext context, IconData icon, String title, Widget destinationPage) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destinationPage)),
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
                MaterialPageRoute(builder: (context) => HomeScreen(token: widget.token, userData: widget.userData)),
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
                  builder: (context) => ContactsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.article),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage(userId: '${widget.userData['id'].toString()}',)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.question_answer),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QnABoard(token: widget.token, userData:widget.userData)),
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
