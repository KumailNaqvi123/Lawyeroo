// lawyercases.dart

import 'package:flutter/material.dart';
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
}

class LawyerCasesPage extends StatefulWidget {
  @override
  _LawyerCasesPageState createState() => _LawyerCasesPageState();
}

class _LawyerCasesPageState extends State<LawyerCasesPage> {
  final List<LawyerCase> cases = [
    LawyerCase(
      caseId: '1',
      clientId: 'client_1',
      lawyerId: 'lawyer_1',
      caseName: 'Client v. Opponent',
      caseDetails: 'Description of the case goes here.',
      caseType: 'Civil',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      caseStatus: 'In Progress',
    ),
    LawyerCase(
      caseId: '2',
      clientId: 'client_2',
      lawyerId: 'lawyer_2',
      caseName: 'Company A v. Company B',
      caseDetails: 'Another case description.',
      caseType: 'Business',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      caseStatus: 'Completed',
    ),
    // Add more cases as needed
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lawyer Cases'),
          backgroundColor: Color(0xFFDCBAFF), // Set app bar background color to b884d1
          bottom: TabBar(
            tabs: [
              Tab(text: 'In Progress'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        backgroundColor: Color(0xFFB884D1), // Set page background color to b884d1
        body: TabBarView(
          children: [
            _buildCasesTab('In Progress'),
            _buildCasesTab('Completed'),
          ],
        ),
      ),
    );
  }

  Widget _buildCasesTab(String statusFilter) {
    final filteredCases =
        cases.where((caseItem) => caseItem.caseStatus == statusFilter).toList();

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
      color: Colors.white, // Set card background color to white
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusDropdown(caseItem),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusDropdown(LawyerCase caseItem) {
    return DropdownButton<String>(
      value: caseItem.caseStatus,
      onChanged: (String? newStatus) {
        if (newStatus != null) {
          setState(() {
            caseItem.caseStatus = newStatus;
          });
        }
      },
      items: <String>['In Progress', 'Completed'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _navigateToCaseDetails(LawyerCase caseItem) {
    // Add navigation to case details screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CaseDetailsPage(caseItem: caseItem),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

void main() {
  runApp(MaterialApp(
    home: LawyerCasesPage(),
  ));
}
