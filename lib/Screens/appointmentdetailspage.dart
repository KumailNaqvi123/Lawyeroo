import 'package:flutter/material.dart';
import 'package:project/Screens/Client_appointments.dart';

class AppointmentDetailsPage extends StatelessWidget {
  final Appointment appointment;

  AppointmentDetailsPage({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDCBAFF),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Appointment Details',
            style: TextStyle(color: Color(0xFF30417C)),
          ),
        ),
      ),
      backgroundColor: Color(0xFFB884D1),
      body: Center(
        child: Card(
          color: Colors.grey[200],
          elevation: 8.0,
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/lawyer_image.jpg'), // Replace with the actual image path
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.lawyerName,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Corporate Law', // Replace with the actual specialization
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 16, right: 16),
                    leading: Icon(Icons.business, color: Colors.black),
                    title: Text('Appointment for', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text('Client Consultation', style: TextStyle(fontSize: 16)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 16, right: 16),
                    leading: Icon(Icons.calendar_today, color: Colors.black),
                    title: Text('Appointment date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text(_formatDate(appointment.dateTime), style: TextStyle(fontSize: 16)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 16, right: 16),
                    leading: Icon(Icons.access_time, color: Colors.black),
                    title: Text('Appointment time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text(_formatTime(appointment.dateTime), style: TextStyle(fontSize: 16)),
                  ),
                ),
                // Add more details here based on your Appointment class
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute}";
  }
}
