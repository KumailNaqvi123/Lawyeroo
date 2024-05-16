import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';

class SetAppointmentDetailsPage extends StatefulWidget {
  final String request;
  final String token;

  SetAppointmentDetailsPage({required this.request, required this.token});

  @override
  _SetAppointmentDetailsPageState createState() =>
      _SetAppointmentDetailsPageState();
}

class _SetAppointmentDetailsPageState extends State<SetAppointmentDetailsPage> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late Map<String, dynamic> requestMap;
  late String appointmentTitle;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    requestMap = jsonDecode(widget.request);
    appointmentTitle = requestMap['appointment_title'] ?? 'No title provided';
    print("You are currently on acceptappointmentpage.dart");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _acceptAppointment() async {
    final DateTime appointmentDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    print('accept appointment check1 ${GlobalData().baseUrl}');
    print('accept appointment check2 ${requestMap['appointment_id']}');

    final response = await http.put(
      Uri.parse('${GlobalData().baseUrl}/api/appointments/status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode({
        'appointment_id': requestMap['appointment_id'],
        'status': 'accepted',
        'date': appointmentDateTime.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      print('Appointment accepted!');
      Navigator.pop(context, true);
    } else {
      print("response ${response.statusCode}");
      print('Failed to accept appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Appointment Details'),
        backgroundColor: Color(0xFFDCBAFF),
      ),
      backgroundColor: Color(0xFFB884D1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointment Title: $appointmentTitle',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Set Date:',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text('Set Date'),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'New Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Set Time:',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () => _selectTime(context),
                                  child: Text('Set Time'),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'New Time: ${_selectedTime.format(context)}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _acceptAppointment,
                    child: Container(
                      width: double.infinity, // Make the button full width
                      child: Center(
                        child: Text('Accept'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

