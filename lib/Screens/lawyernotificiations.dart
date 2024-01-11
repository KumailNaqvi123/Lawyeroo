import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Screens/lawyercontactscreen.dart';
import 'package:project/Screens/lawyerhomepage.dart';
import 'package:project/Screens/lawyersettings.dart';
import 'package:project/main.dart';

class LawyerNotificationsPage extends StatefulWidget {
  @override
  _LawyerNotificationsPageState createState() => _LawyerNotificationsPageState();
}

class _LawyerNotificationsPageState extends State<LawyerNotificationsPage> {
  final List<LawyerNotificationItem> notifications = [];

  @override
  void initState() {
    super.initState();

    // Schedule the timer to generate a random lawyer notification every 10 seconds
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      setState(() {
        notifications.add(_generateRandomLawyerNotification());
      });
    });
  }

  String _formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lawyer Notifications',
          style: TextStyle(color: Color(0xFF30417c)),
        ),
        backgroundColor: Color(0xFFDCBAFF),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF6e5ed7),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              color: Colors.white,
              child: ListTile(
                title: Text(notifications[index].caseTitle),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notifications[index].content),
                    SizedBox(height: 5),
                    Text(
                      _formatDateTime(notifications[index].time),
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        _markAsRead(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          'Mark as Read',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Handle notification tap
                  // You can navigate to a specific page or perform any other action
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      color: Color(0xFFDCBAFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (context) => LawyerHomepage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.chat, color: Colors.black),
            onPressed: () {
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (context) => LawyerContactsScreen(context: context)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Color(0xFF912bFF)),
            onPressed: () {
              // Handle Notifications navigation
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (context) => LawyerSettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _markAsRead(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  LawyerNotificationItem _generateRandomLawyerNotification() {
    return LawyerNotificationItem(
      caseTitle: 'New Case Assigned',
      content: 'You have been assigned a new case.',
      time: DateTime.now(),
    );
  }
}

class LawyerNotificationItem {
  final String caseTitle;
  final String content;
  final DateTime time;

  LawyerNotificationItem({
    required this.caseTitle,
    required this.content,
    required this.time,
  });
}

void main() {
  runApp(MaterialApp(
    home: LawyerNotificationsPage(),
  ));
}
