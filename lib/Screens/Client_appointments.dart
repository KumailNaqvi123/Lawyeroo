// main.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'appointmentdetailspage.dart'; // Import the new file

void main() {
  runApp(MyApp());
}

class Appointment {
  final String lawyerName;
  final DateTime dateTime;

  Appointment(this.lawyerName, this.dateTime);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppointmentsPage(),
    );
  }
}

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final List<Appointment> upcomingAppointments = _generateRandomAppointments(3);
  final List<Appointment> pastAppointments = _generateRandomAppointments(3);

  static List<Appointment> _generateRandomAppointments(int count) {
    final List<Appointment> appointments = [];
    final random = Random();
    for (int i = 0; i < count; i++) {
      appointments.add(Appointment("Lawyer ${_generateRandomName()}", _generateRandomDateTime()));
    }
    return appointments;
  }

  static String _generateRandomName() {
    final List<String> names = ["Ali", "Hamza", "Ahmed", "Sara", "Hassan", "Fatima"];
    final random = Random();
    return names[random.nextInt(names.length)];
  }

  static DateTime _generateRandomDateTime() {
    final random = Random();
    final daysToAdd = random.nextInt(30); // Upcoming appointments within the next 30 days
    return DateTime.now().add(Duration(days: daysToAdd));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFDCBAFF),
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Appointments',
              style: TextStyle(color: Color(0xFF30417C)),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Upcoming',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Past',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAppointmentsList(upcomingAppointments),
            _buildAppointmentsList(pastAppointments),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentsList(List<Appointment> appointments) {
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Appointment with ${appointment.lawyerName}'),
            subtitle: Text('Date: ${_formatDate(appointment.dateTime)}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentDetailsPage(appointment: appointment),
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _formatDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} at ${_formatTime(dateTime)}";
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute}";
  }
}
