import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/LawyerAppointment.dart';



class CaseCreationPage extends StatefulWidget {
  final String token;

  final LawyerAppointment appointment;

  CaseCreationPage({required this.token, required this.appointment}
  );

  @override
  _CaseCreationPageState createState() => _CaseCreationPageState();
}

class _CaseCreationPageState extends State<CaseCreationPage> {
  String _caseName = '';
  String _caseDetails = '';
  String _caseType = 'Family Law'; // Default value
  String _caseStatus = 'Open'; // Default value
  List<String> _caseTypes = [
    "Personal Injury",
    "Estate Planning",
    "Bankruptcy",
    "Intellectual Property",
    "Employment",
    "Corporate",
    "Immigration",
    "Criminal",
    "Medical Malpractice",
    "Tax Law",
    "Family Law",
    "Worker's Compensation ",
    "Contract",
    "Social Security Disability",
    "Civil Litigation",
    "General Practice"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Case'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Case Name',
              ),
              onChanged: (value) {
                setState(() {
                  _caseName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Case Details',
              ),
              onChanged: (value) {
                setState(() {
                  _caseDetails = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Case Type: '),
                DropdownButton<String>(
                  value: _caseType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _caseType = newValue!;
                    });
                  },
                  items: _caseTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Case Status: $_caseStatus'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _createCase();
              },
              child: Text('Create Case'),
            ),
          ],
        ),
      ),
    );
  }

void _createCase() async {
  // Define the request body with the case data
  print("clienttt iddd ${widget.appointment.clientId}");
  print("clienttt iddd ${widget.appointment.lawyerId}");

  Map<String, dynamic> requestBody = {
    "client_id": widget.appointment.clientId,
    "lawyer_id": widget.appointment.lawyerId,
    "case_name": _caseName,
    "case_details": _caseDetails,
    "case_type": _caseType,
    "case_status": _caseStatus,
  };

  // Convert the request body to JSON format
  String requestBodyJson = jsonEncode(requestBody);

  // Define the API endpoint URL
  String apiUrl = '${GlobalData().baseUrl}/api/cases';

  // Make the HTTP POST request
  print("tokennn ${widget.token}");
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.token}', // Assuming token is accessible here
    },
    body: requestBodyJson,
  );

  // Check the response status code
  if (response.statusCode == 201) {
    // Case created successfully
          showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Case Created Successfully'),
            content: Text(' Your case has been created sucessfully.'),
            actions: <TextButton>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        }
         );
    print('Case created successfully');
  } else {
    // Failed to create case, print the response body
    print('Failed to create case: ${response.body}');
  }
}

}
