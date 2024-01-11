import 'package:flutter/material.dart';

class SetAppointmentDetailsPage extends StatefulWidget {
  final String request;

  SetAppointmentDetailsPage({required this.request});

  @override
  _SetAppointmentDetailsPageState createState() => _SetAppointmentDetailsPageState();
}

class _SetAppointmentDetailsPageState extends State<SetAppointmentDetailsPage> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    // Set initial date and time values
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
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
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
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
                    'Request\n: ${widget.request}',
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
                    onPressed: () {
                      // Handle accept action
                      print('Appointment accepted!');
                    },
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
