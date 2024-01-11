import 'package:flutter/material.dart';
import 'dart:math';

import 'package:project/Screens/acceptappointmentpage.dart';

class Lawyer {
  final int lawyerId;
  final String lawyerName;

  Lawyer({
    required this.lawyerId,
    required this.lawyerName,
  });
}

class LawyerAppointment {
  final int serialNumber;
  final int clientId;
  final int caseId;
  final int lawyerId;
  final Lawyer lawyer;
  final DateTime appointmentTime;
  final DateTime createdAt;
  final String appointmentStatus;
  final String clientName; // Additional field for client name

  LawyerAppointment({
    required this.serialNumber,
    required this.clientId,
    required this.caseId,
    required this.lawyerId,
    required this.lawyer,
    required this.appointmentTime,
    required this.createdAt,
    required this.appointmentStatus,
    required this.clientName,
  });
}

class LawyerAppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<LawyerAppointmentsPage> {
  List<LawyerAppointment> appointments = [];
  List<LawyerAppointment> pastAppointments = [];
  List<String> pendingRequests = [];

  @override
  void initState() {
    super.initState();
    generateDummyAppointments();
    generateDummyPastAppointments();
    generateDummyPendingRequests();
  }

  void generateDummyAppointments() {
    final Random random = Random();
    final List<Lawyer> lawyers = [
      Lawyer(lawyerId: 301, lawyerName: 'John Doe'),
      Lawyer(lawyerId: 302, lawyerName: 'Jane Smith'),
      Lawyer(lawyerId: 303, lawyerName: 'Alice Johnson'),
    ];

    for (int i = 1; i <= 5; i++) {
      final Lawyer randomLawyer = lawyers[random.nextInt(lawyers.length)];
      final DateTime now = DateTime.now();
      final DateTime appointmentTime = now.add(Duration(days: i, hours: random.nextInt(24)));
      final DateTime createdAt = now.subtract(Duration(days: i));

      appointments.add(
        LawyerAppointment(
          serialNumber: i,
          clientId: 101,
          caseId: 201,
          lawyerId: randomLawyer.lawyerId,
          lawyer: randomLawyer,
          appointmentTime: appointmentTime,
          createdAt: createdAt,
          appointmentStatus: 'In Progress',
          clientName: 'Client $i', // Replace with actual client names
        ),
      );
    }
  }

  void generateDummyPastAppointments() {
    final Random random = Random();
    final List<Lawyer> lawyers = [
      Lawyer(lawyerId: 301, lawyerName: 'John Doe'),
      Lawyer(lawyerId: 302, lawyerName: 'Jane Smith'),
      Lawyer(lawyerId: 303, lawyerName: 'Alice Johnson'),
    ];

    for (int i = 1; i <= 5; i++) {
      final Lawyer randomLawyer = lawyers[random.nextInt(lawyers.length)];
      final DateTime now = DateTime.now();
      final DateTime appointmentTime = now.subtract(Duration(days: i));
      final DateTime createdAt = now.subtract(Duration(days: i + 2));

      pastAppointments.add(
        LawyerAppointment(
          serialNumber: i,
          clientId: 101,
          caseId: 201,
          lawyerId: randomLawyer.lawyerId,
          lawyer: randomLawyer,
          appointmentTime: appointmentTime,
          createdAt: createdAt,
          appointmentStatus: 'Past',
          clientName: 'Client $i', // Replace with actual client names
        ),
      );
    }
  }

  void generateDummyPendingRequests() {
    final Random random = Random();
    final List<String> names = ['John Doe', 'Jane Smith', 'Alice Johnson'];

    for (int i = 1; i <= 3; i++) {
      final String randomName = names[random.nextInt(names.length)];
      final String request =
          '$randomName is requesting an appointment regarding his case with you';
      pendingRequests.add(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Appointments'),
          backgroundColor: Color(0xFFDCBAFF),
          bottom: TabBar(
            tabs: [
              Tab(text: 'In Progress'),
              Tab(text: 'Past'),
              Tab(text: 'Pending'),
            ],
          ),
        ),
        backgroundColor: Color(0xFFB884D1),
        body: TabBarView(
          children: [
            _buildAppointmentList(appointments),
            _buildAppointmentList(pastAppointments),
            _buildPendingRequestsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentList(List<LawyerAppointment> appointmentList) {
    return ListView.builder(
      itemCount: min(5, appointmentList.length),
      itemBuilder: (context, index) {
        return _buildAppointmentCard(appointmentList[index]);
      },
    );
  }

  Widget _buildPendingRequestsList() {
    return pendingRequests.isEmpty
        ? Center(child: Text('No pending requests'))
        : ListView.builder(
            itemCount: pendingRequests.length,
            itemBuilder: (context, index) {
              return _buildPendingRequestCard(pendingRequests[index], index);
            },
          );
  }

  Widget _buildAppointmentCard(LawyerAppointment appointment) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Serial Number: ${appointment.serialNumber}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Client ID: ${appointment.clientId}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Case ID: ${appointment.caseId}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Lawyer ID: ${appointment.lawyerId}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Lawyer: ${appointment.lawyer.lawyerName}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Time: ${_formatDateTime(appointment.appointmentTime)}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Created At: ${_formatDateTime(appointment.createdAt)}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Status: ${appointment.appointmentStatus}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            if (appointment.appointmentStatus == 'In Progress') Text('Client: ${appointment.clientName}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingRequestCard(String request, int index) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(request, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the SetAppointmentDetailsPage when "View" is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetAppointmentDetailsPage(request: request),
                      ),
                    );
                  },
                  child: Text('View'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle reject action
                    _rejectPendingRequest(index);
                  },
                  child: Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _rejectPendingRequest(int index) {
    setState(() {
      // Remove the entry from the list
      pendingRequests.removeAt(index);
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}

void main() {
  runApp(MaterialApp(
    home: LawyerAppointmentsPage(),
  ));
}
