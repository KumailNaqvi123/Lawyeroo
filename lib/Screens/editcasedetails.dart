import 'package:flutter/material.dart';
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/lawyercases.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditCasePage extends StatefulWidget {
  final LawyerCase caseItem;
  final String token;

  EditCasePage({required this.caseItem, required this.token});

  @override
  _EditCasePageState createState() => _EditCasePageState();
}

class _EditCasePageState extends State<EditCasePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.caseItem.caseName;
    _detailsController.text = widget.caseItem.caseDetails;
    _statusController.text = widget.caseItem.caseStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Case'),
        backgroundColor: Color(0xFFDCBAFF),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('Case Name', _nameController),
            _buildTextField('Case Details', _detailsController),
            _buildDropdown('Case Status', _statusController),
            ElevatedButton(
              onPressed: _updateCase,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: controller.text,
        onChanged: (newValue) {
          setState(() {
            controller.text = newValue!;
          });
        },
        items: <String>['Open', 'Closed'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _updateCase() async {
    var response = await http.put(
      Uri.parse('${GlobalData().baseUrl}/api/cases/${widget.caseItem.caseId}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode({
        'case_name': _nameController.text,
        'case_details': _detailsController.text,
        'case_status': _statusController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update Successful')));

      // Create the updated case object
      LawyerCase updatedCase = LawyerCase(
        caseId: widget.caseItem.caseId,
        clientId: widget.caseItem.clientId,
        lawyerId: widget.caseItem.lawyerId,
        caseName: _nameController.text,
        caseDetails: _detailsController.text,
        caseType: widget.caseItem.caseType,
        createdAt: widget.caseItem.createdAt,
        updatedAt: DateTime.now(),
        caseStatus: _statusController.text,
      );

      Navigator.pop(context, updatedCase);
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _statusController.dispose();
    super.dispose();
  }
}
