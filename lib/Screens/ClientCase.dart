import 'package:flutter/material.dart';

class ClientCasesPage extends StatefulWidget {
  @override
  _ClientCasesPageState createState() => _ClientCasesPageState();
}

class ClientCase {
  final String caseId;
  final String lawyerId;
  final String caseName;
  final String caseDetails;
  final String caseType;
  final DateTime createdAt;
  final DateTime updatedAt;
  String caseStatus;

  ClientCase({
    required this.caseId,
    required this.lawyerId,
    required this.caseName,
    required this.caseDetails,
    required this.caseType,
    required this.createdAt,
    required this.updatedAt,
    required this.caseStatus,
  });
}


class _ClientCasesPageState extends State<ClientCasesPage> {
  final List<ClientCase> cases = [
    ClientCase(
      caseId: '1',
      lawyerId: 'lawyer_1',
      caseName: 'Client v. Opponent',
      caseDetails: 'Description of the case goes here.',
      caseType: 'Civil',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      caseStatus: 'In Progress',
    ),
    ClientCase(
      caseId: '2',
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
          title: Text('Client Cases'),
          backgroundColor: Color(0xFFDCBAFF), // Set app bar background color
          bottom: TabBar(
            tabs: [
              Tab(text: 'In Progress'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        backgroundColor: Color(0xFFB884D1), // Set page background color
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
            for (ClientCase caseItem in filteredCases)
              _buildCaseCard(caseItem, statusFilter),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseCard(ClientCase caseItem, String statusFilter) {
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
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

void main() {
  runApp(MaterialApp(
    home: ClientCasesPage(),
  ));
}