import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/Screens/Global.dart';

class ReportIssuePage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  ReportIssuePage({required this.token, required this.userData});

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}



class _ReportIssuePageState extends State<ReportIssuePage> {

// @override
// void initState() {
// super.initState();
//     print("hello! you are now on report issue page!");
//     print("Token: ${widget.token}"); // Print the token
//     print("User Data: ${widget.userData}"); // Print all user data
//     }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();  // Form key for validation
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedType; // Variable to hold the selected type of issue
  final List<String> _issueTypes = ['Bug', 'Feature Request', 'UI Issue', 'Performance Issue', 'Security Issue', 'Other']; // List of issue types

  void _submitReport() async {
    if (!_formKey.currentState!.validate()) {
      return; // If the form is not valid, prevent the submit
    }

    String title = _titleController.text;
    String description = _descriptionController.text;
    String type = _selectedType ?? 'Other'; // Default to 'Other' if nothing is selected
    print("reporter id ${widget.userData['id']}");
    var response = await http.post(
      Uri.parse('${GlobalData().baseUrl}/api/reports'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode(<String, dynamic>{
        'report_title': title,
        'reporter_id': widget.userData['id'],
        'report_text': description,
        'report_type': type,
        'status': 'pending',
        'reported_at': DateTime.now().toIso8601String()  // Use current date-time
      }),
    );

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Issue Reported'),
            content: Text('Thank you for reporting the issue.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to submit the report: ${response.body}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Issue'),
        backgroundColor: Color(0xFFDCBAFF),  // Updated AppBar color
      ),
      body: Container(
        color: Color(0xFFB884D1),  // Updated background color
        padding: EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Issue Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Issue Description'),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Select Issue Type'),
                    value: _selectedType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    },
                    items: _issueTypes.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an issue type';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitReport,
                    child: Text('Submit Report'),
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
