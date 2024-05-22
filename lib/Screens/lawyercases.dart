import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/lawyerCaseDetails.dart';

class LawyerCase {
  final String caseId;
  final String clientId;
  final String lawyerId;
  final String caseName;
  final String caseDetails;
  final String caseType;
  final DateTime createdAt;
  final DateTime updatedAt;
  String caseStatus;

  LawyerCase({
    required this.caseId,
    required this.clientId,
    required this.lawyerId,
    required this.caseName,
    required this.caseDetails,
    required this.caseType,
    required this.createdAt,
    required this.updatedAt,
    required this.caseStatus,
  });

  factory LawyerCase.fromJson(Map<String, dynamic> json) {
    return LawyerCase(
      caseId: json['case_id'] ?? '',
      clientId: json['client_id'] ?? '',
      lawyerId: json['lawyer_id'] ?? '',
      caseName: json['case_name'] ?? '',
      caseDetails: json['case_details'] ?? '',
      caseType: json['case_type'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      caseStatus: json['case_status'] ?? '',
    );
  }
}

class LawyerCasesPage extends StatefulWidget {
  final String lawyerId;
  final String token;

  LawyerCasesPage({required this.lawyerId, required this.token});

  @override
  _LawyerCasesPageState createState() => _LawyerCasesPageState();
}

class _LawyerCasesPageState extends State<LawyerCasesPage> {
  List<LawyerCase> cases = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCases();
  }

  Future<void> _fetchCases() async {
    final response = await http.get(
      Uri.parse('${GlobalData().baseUrl}/api/cases/user/lawyer/${widget.lawyerId}'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> caseList = jsonDecode(response.body);
      setState(() {
        cases = caseList.map((json) => LawyerCase.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      print('Failed to load cases');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lawyer Cases'),
          backgroundColor: Color(0xFFDCBAFF),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Open'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        backgroundColor: Color(0xFFB884D1),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildCasesTab('Open'),
                  _buildCasesTab('Completed'),
                ],
              ),
      ),
    );
  }

  Widget _buildCasesTab(String statusFilter) {
    // Filter cases based on the status filter provided
    final filteredCases = cases.where((caseItem) {
      if (statusFilter == 'Open') {
        // Include cases marked as 'Open' or 'In Progress'
        return caseItem.caseStatus == 'Open' || caseItem.caseStatus == 'In Progress';
      } else {
        // Include cases marked as 'Completed'
        return caseItem.caseStatus == 'Completed' || caseItem.caseStatus == 'Closed';
      }
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (LawyerCase caseItem in filteredCases)
              _buildCaseCard(caseItem, statusFilter),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseCard(LawyerCase caseItem, String statusFilter) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Created At: ${_formatDate(caseItem.createdAt)}',
                  style: TextStyle(color: Colors.grey),
                ),
                InkWell(
                  onTap: () {
                    _navigateToCaseDetails(caseItem);
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              caseItem.caseName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Type: ${caseItem.caseType}'),
            Text('Status: ${caseItem.caseStatus}'),
            Text('Details: ${caseItem.caseDetails}'),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _navigateToCaseDetails(LawyerCase caseItem) async {
    final updatedCase = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CaseDetailsPage(
          caseItem: caseItem,
          token: widget.token,
        ),
      ),
    );

    if (updatedCase != null) {
      // Update the specific case in the list
      setState(() {
        final index = cases.indexWhere((c) => c.caseId == updatedCase.caseId);
        if (index != -1) {
          cases[index] = updatedCase;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
