import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/appointmentdetailspage.dart';

class Appointment {
  final String appointmentTitle;
  final DateTime appointmentDate;
  final String appointmentStatus;
  final Map<String, dynamic> lawyerDetails;
  Map<String, dynamic>? lawyerData;  // Store fetched lawyer data

  Appointment({
    required this.appointmentTitle,
    required this.appointmentDate,
    required this.appointmentStatus,
    required this.lawyerDetails,
    this.lawyerData,
  });

factory Appointment.fromJson(Map<String, dynamic> json) {
  return Appointment(
    appointmentTitle: json['appointment_title'] ?? 'No Title',
    appointmentDate: json['appointment_date'] != null 
                     ? DateTime.parse(json['appointment_date'])
                     : DateTime.now(),
    appointmentStatus: json['appointment_status'] ?? 'Unknown',
    lawyerDetails: json['lawyerDetails'] ?? {},
    lawyerData: json['lawyerData'],
  );
}

}

class AppointmentsPage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  AppointmentsPage({required this.token, required this.userData});

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<Appointment> upcomingAppointments = [];
  List<Appointment> pendingAppointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

Future<Map<String, dynamic>?> fetchLawyerDetails(String lawyerId) async {
  final uri = Uri.parse('${GlobalData().baseUrl}/api/lawyers/$lawyerId');
  final response = await http.get(uri, headers: {'Authorization': 'Bearer ${widget.token}'});
 if (response.statusCode == 200) {
  print("Lawyer Details: ${response.body}");  // This will show what exactly you are getting from the API
  return jsonDecode(response.body);
} else {
  print('Failed to load lawyer details: ${response.statusCode}');
  return null;
}
}

Future<void> fetchAppointments() async {
  final response = await http.get(
    Uri.parse('${GlobalData().baseUrl}/api/appointments/${widget.userData['id']}'),
    headers: {'Authorization': 'Bearer ${widget.token}'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body)['data'];
    List<Appointment> allAppointments = [];

    for (var json in data) {
      if (json != null) {
        try {
          Appointment appointment = Appointment.fromJson(json);

          // Fetch and assign lawyer details if available
          if (json['lawyer_id'] != null ) {
            var lawyerDetails = await fetchLawyerDetails(json['lawyer_id']);
            if (lawyerDetails != null) {
              appointment.lawyerData = {
                'first_name': lawyerDetails['first_name'] ?? 'Unavailable',
                'last_name': lawyerDetails['last_name'] ?? '',
                ...lawyerDetails
              };
            }
            print('lawyer details {$lawyerDetails}');
          }

          allAppointments.add(appointment);
        } catch (e) {
          print("Error parsing appointment data: $e");
        }
      }
    }

    setState(() {
      upcomingAppointments = allAppointments.where((a) => a.appointmentStatus == 'accepted').toList();
      pendingAppointments = allAppointments.where((a) => a.appointmentStatus == 'pending').toList();
      isLoading = false;
    });
  } else {
    print('Failed to fetch appointments: ${response.statusCode}');
    setState(() => isLoading = false);
  }
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
              Tab(child: Text('Accepted', style: TextStyle(color: Colors.black))),
              Tab(child: Text('Pending', style: TextStyle(color: Colors.black))),
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildAppointmentsList(upcomingAppointments),
                  _buildAppointmentsList(pendingAppointments),
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
      // Use null-aware operators to safely access properties
      String lawyerName = 'Unavailable'; // Default if data is null
      if (appointment.lawyerData != null) {
        lawyerName = "${appointment.lawyerData?['first_name'] ?? 'Unavailable'} ${appointment.lawyerData?['last_name'] ?? ''}";
      }

      return Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(appointment.appointmentTitle),
          subtitle: Text(
            'Date: ${_formatDate(appointment.appointmentDate)}\n'
            'Status: ${appointment.appointmentStatus}\n'
            'Lawyer: $lawyerName'
          ),
          onTap: () {
            // Use jsonEncode safely with null checks
            if (appointment.lawyerData != null) {
              print('Lawyer Data: ${jsonEncode(appointment.lawyerData)}');
            } else {
              print('No Lawyer Data available');
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentDetailsPage(
                  appointment: appointment,
                  token: widget.token,
                  userData: widget.userData,
                  lawyerData: appointment.lawyerData!
                ),
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
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}

