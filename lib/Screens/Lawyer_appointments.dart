import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/create_case.dart';
import 'package:project/Screens/acceptappointmentpage.dart';
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/LawyerAppointment.dart';


class LawyerAppointmentsPage extends StatefulWidget {
  final String lawyerId;
  final String token;

  LawyerAppointmentsPage({required this.lawyerId, required this.token});

  @override
  _LawyerAppointmentsPageState createState() =>
      _LawyerAppointmentsPageState();
}

class _LawyerAppointmentsPageState extends State<LawyerAppointmentsPage> {
  List<LawyerAppointment> inProgressAppointments = [];
  List<LawyerAppointment> pendingAppointments = [];
  List<LawyerAppointment> pastAppointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    final response = await http.get(
      Uri.parse('${GlobalData().baseUrl}/api/appointments/${widget.lawyerId}'),
      headers: {
        'Authorization': 'Bearer ${widget.token}', // Use the token here
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      setState(() {
        inProgressAppointments = data
            .where((appointment) => appointment['appointment_status'] == 'accepted')
            .map((json) => LawyerAppointment.fromJson(json))
            .toList();
        pendingAppointments = data
            .where((appointment) => appointment['appointment_status'] == 'pending')
            .map((json) => LawyerAppointment.fromJson(json))
            .toList();
        pastAppointments = data
            .where((appointment) => appointment['appointment_status'] == 'past')
            .map((json) => LawyerAppointment.fromJson(json))
            .toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    final response = await http.delete(
      Uri.parse('${GlobalData().baseUrl}/api/appointments/$appointmentId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      // Successfully deleted
      print("Appointment deleted: $appointmentId");
    } else {
      // Handle error
      print("status = ${widget.token}");
      print("Failed to delete appointment: $appointmentId");
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
              Tab(text: 'Pending'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        backgroundColor: Color(0xFFB884D1),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildAppointmentList(inProgressAppointments),
                  _buildPendingRequestsList(),
                  _buildAppointmentList(pastAppointments),
                ],
              ),
      ),
    );
  }

  Widget _buildAppointmentList(List<LawyerAppointment> appointmentList) {
    return ListView.builder(
      itemCount: appointmentList.length,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(appointmentList[index]);
      },
    );
  }

  Widget _buildPendingRequestsList() {
    return pendingAppointments.isEmpty
        ? Center(child: Text('No pending requests'))
        : ListView.builder(
            itemCount: pendingAppointments.length,
            itemBuilder: (context, index) {
              return _buildPendingRequestCard(pendingAppointments[index]);
            },
          );
  }

  Widget _buildAppointmentCard(LawyerAppointment appointment) {
    return GestureDetector(
      onLongPress: () {
        _showCreateCasePopup(appointment);
      },
      child: Card(
        color: Colors.grey[200],
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Client ID: ${appointment.clientId}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('${appointment.appointmentTitle}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Appointment Date: ${_formatDateTime(appointment.appointmentDate)}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Status: ${appointment.appointmentStatus}',
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPendingRequestCard(LawyerAppointment appointment) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Appointment ID: ${appointment.appointmentId}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Client ID: ${appointment.clientId}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Appointment Title: ${appointment.appointmentTitle}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetAppointmentDetailsPage(
                          request: jsonEncode(appointment.toJson()),
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                  child: Text('View'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await deleteAppointment(appointment.appointmentId);
                    setState(() {
                      pendingAppointments.remove(appointment);
                    });
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

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  void _showCreateCasePopup(LawyerAppointment appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create Case"),
          content: Text("Would you like to create a case for this appointment?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CaseCreationPage(
                      token: widget.token,
                      appointment: appointment,
                    ),
                  ),
                );
              },
              child: Text("Create Case"),
            ),
          ],
        );
      },
    );
  }
}
