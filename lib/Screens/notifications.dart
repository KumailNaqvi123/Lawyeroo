import 'dart:async'; // Import the dart:async library for Timer

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationItem> notifications = [];

  @override
  void initState() {
    super.initState();

    // Schedule the timer to generate a random notification every 10 seconds
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      setState(() {
        notifications.add(_generateRandomNotification());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationTile(notification: notifications[index]);
        },
      ),
    );
  }

  NotificationItem _generateRandomNotification() {
    // Replace this with your logic to generate random notifications
    // For simplicity, a placeholder is used here
    return NotificationItem(
      title: 'Random Notification',
      content: 'This is a random notification.',
      time: DateTime.now(),
    );
  }
}

class NotificationItem {
  final String title;
  final String content;
  final DateTime time;

  NotificationItem({
    required this.title,
    required this.content,
    required this.time,
  });
}

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notification.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification.content),
          SizedBox(height: 5),
          Text(
            _formatDateTime(notification.time),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onTap: () {
        // Handle notification tap
        // You can navigate to a specific page or perform any other action
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationsPage(),
  ));
}
