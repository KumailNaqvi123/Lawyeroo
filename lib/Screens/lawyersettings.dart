import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/Lawyerprofile.dart';
import 'package:project/Screens/MyStatisticsPage.dart';
import 'package:project/Screens/lawyercases.dart';
import 'package:project/Screens/lawyercontactscreen.dart';
import 'dart:convert';
import 'package:project/Screens/lawyerhomepage.dart';
import 'package:project/Screens/lawyernotificiations.dart';
import 'package:project/Screens/reportanissue.dart';

class LawyerSettingsPage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  LawyerSettingsPage({required this.token, required this.userData});

  @override
  _LawyerSettingsPageState createState() => _LawyerSettingsPageState();
}

class _LawyerSettingsPageState extends State<LawyerSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCBAFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFDCBAFF),
        title: Text('My Profile', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Color(0xFFDCBAFF),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(GlobalData().userData['profile_picture'] ?? 'assets/images/profile.png'),
                  ),
                  SizedBox(height: 16),
                  Text('${GlobalData().userData['first_name']} ${GlobalData().userData['last_name']}', style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Card(
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: _buildMenuItems(context),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavBar(context),
    );
  }

Widget _buildListTile(IconData icon, String title, Widget destination) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
  );
}


 List<Widget> _buildMenuItems(BuildContext context) {
  return [
    _buildListTile(Icons.equalizer, 'My Statistics', MyStatisticsPage(token: widget.token, userData: widget.userData)),
    _buildListTile(Icons.edit, 'Edit Profile', LawyerProfilePage(token: widget.token, userData: widget.userData)),
    _buildListTile(Icons.folder, 'Cases', LawyerCasesPage(lawyerId: widget.userData['id'], token: widget.token)),
    _buildListTile(Icons.insert_chart, 'Report', ReportIssuePage(token: widget.token, userData: widget.userData)),
    ListTile(
      leading: Icon(Icons.verified_user),
      title: Text('Verify Me'),
      onTap: () {
        _showVerifyDialog(context);
      },
    ),
  ];
}

void _showVerifyDialog(BuildContext context) {
  TextEditingController registrationController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Verify Lawyer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: registrationController,
              decoration: InputDecoration(labelText: 'Enter Registration Number'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _verifyLawyer(registrationController.text); // Pass registration number to _verifyLawyer
            },
            child: Text('Verify'),
          ),
        ],
      );
    },
  );
}


void _verifyLawyer(String registrationNumber) async {
  var url = Uri.parse('${GlobalData().baseUrl}/api/lawyers/lawyer-verification');
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.token}',
    },
    body: jsonEncode({
      'lawyer_id': widget.userData['id'],
      'first_name': widget.userData['first_name'],
      'last_name': widget.userData['last_name'],
      'registration_no': registrationNumber, // Use the provided registration number
    }),
  );

  // Remaining code...
}


  Widget _buildNavBar(BuildContext context) {
    return Container(
      color: Color(0xFFDCBAFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(icon: Icon(Icons.home), onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LawyerHomepage(token: widget.token, userData: widget.userData)), (route) => false)),
          IconButton(icon: Icon(Icons.chat), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerContactsScreen(context: context)))),
          IconButton(icon: Icon(Icons.notifications), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LawyerNotificationsPage()))),
          IconButton(icon: Icon(Icons.person, color: Color(0xFF912bFF)), onPressed: () {}),
        ],
      ),
    );
  }
}
