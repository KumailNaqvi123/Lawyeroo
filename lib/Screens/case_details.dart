import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/Screens/Global.dart';
import 'package:intl/intl.dart';  // Import intl to format dates

class CaseDetailsPage extends StatefulWidget {
  final String caseId;
  final Map<String, dynamic> userData;
  final String token;
  final String clientFirstName;
  final String clientLastName;
  final String clientProfilePicture;
  final String lawyerFirstName;
  final String lawyerLastName;
  final String lawyerProfilePicture;

  CaseDetailsPage({
    required this.caseId,
    required this.userData,
    required this.token,
    required this.clientFirstName,
    required this.clientLastName,
    required this.clientProfilePicture,
    required this.lawyerFirstName,
    required this.lawyerLastName,
    required this.lawyerProfilePicture,
  });

  @override
  _CaseDetailsPageState createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  Map<String, dynamic>? caseDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCaseDetails();
  }

  Future<void> fetchCaseDetails() async {
    final response = await http.get(
      Uri.parse('${GlobalData().baseUrl}/api/cases/${widget.caseId}'),
      headers: {'Authorization': 'Bearer ${widget.token}'}
    );

    if (response.statusCode == 200) {
      setState(() {
        caseDetails = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to fetch case details: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(caseDetails?['case_name'] ?? 'Loading...'),
        backgroundColor: Color(0xFFDCBAFF),
      ),
      backgroundColor: Color(0xFFB884D1),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildItem('Case Type', caseDetails?['case_type'] ?? 'N/A'),
                        _buildItem('Status', caseDetails?['case_status'] ?? 'N/A'),
                        _buildItem('Details', caseDetails?['case_details'] ?? 'N/A'),
                        _buildItem('Created At', _formatDate(caseDetails?['created_at'])),
                        _buildItem('Updated At', _formatDate(caseDetails?['updated_at'])),
                        _buildProfileSection('Client', widget.clientFirstName, widget.clientLastName, widget.clientProfilePicture),
                        _buildProfileSection('Lawyer', widget.lawyerFirstName, widget.lawyerLastName, widget.lawyerProfilePicture),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildProfileSection(String role, String firstName, String lastName, String profilePicture) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$role Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profilePicture),
                radius: 20,
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(width: 10),
              Text('$firstName $lastName', style: TextStyle(fontSize: 14)),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    DateTime parsedDate = DateTime.parse(dateStr);
    return DateFormat('yyyy-MM-dd – kk:mm').format(parsedDate);  // Format date and time
  }
}
