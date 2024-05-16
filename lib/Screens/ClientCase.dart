import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/case_details.dart';

class ClientCasesPage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  ClientCasesPage({required this.token, required this.userData});

  @override
  _ClientCasesPageState createState() => _ClientCasesPageState();
}

class ClientCase {
  final String caseId;
  final String? lawyerId;
  final String caseName;
  final String caseDetails;
  final String caseType;
  final DateTime createdAt;
  final DateTime updatedAt;
  String caseStatus;
  final String? clientFirstName;
  final String? clientLastName;
  final String? clientProfilePicture;
  final String? lawyerFirstName;
  final String? lawyerLastName;
  final String? lawyerProfilePicture;

  ClientCase({
    required this.caseId,
    this.lawyerId,
    required this.caseName,
    required this.caseDetails,
    required this.caseType,
    required this.createdAt,
    required this.updatedAt,
    required this.caseStatus,
    this.clientFirstName,
    this.clientLastName,
    this.clientProfilePicture,
    this.lawyerFirstName,
    this.lawyerLastName,
    this.lawyerProfilePicture,
  });


  factory ClientCase.fromJson(Map<String, dynamic> json) {
    return ClientCase(
      caseId: json['case_id'],
      lawyerId: json['lawyer_id'],
      caseName: json['case_name'],
      caseDetails: json['case_details'],
      caseType: json['case_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      caseStatus: json['case_status'],
      clientFirstName: json['clientDetails']?['first_name'],
      clientLastName: json['clientDetails']?['last_name'],
      clientProfilePicture: json['clientDetails']?['profile_picture'],
      lawyerFirstName: json['lawyerDetails']?['first_name'],
      lawyerLastName: json['lawyerDetails']?['last_name'],
      lawyerProfilePicture: json['lawyerDetails']?['profile_picture'],
    );
  }
}

class _ClientCasesPageState extends State<ClientCasesPage> {
  List<ClientCase> cases = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCases();
  }

  Future<void> fetchCases() async {
    final response = await http.get(
      Uri.parse('${GlobalData().baseUrl}/api/cases/user/client/${widget.userData["id"]}'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        cases = data.map((json) => ClientCase.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to fetch cases: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Client Cases'),
          backgroundColor: Color(0xFFDCBAFF),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Open'),
              Tab(text: 'Closed'),
            ],
          ),
        ),
        backgroundColor: Color(0xFFB884D1),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildCasesTab('Open'),
                  _buildCasesTab('Closed'),
                ],
              ),
      ),
    );
  }

  Widget _buildCasesTab(String statusFilter) {
    final filteredCases =
        cases.where((caseItem) => (statusFilter == 'Open' ? caseItem.caseStatus == 'Open' : caseItem.caseStatus != 'Open')).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (ClientCase caseItem in filteredCases)
              _buildCaseCard(caseItem),
          ],
        ),
      ),
    );
  }

Widget _buildCaseCard(ClientCase caseItem) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => CaseDetailsPage(
      caseId: caseItem.caseId,
      userData: widget.userData,
      token: widget.token,
            clientFirstName: caseItem.clientFirstName ?? "Unknown",
            clientLastName: caseItem.clientLastName ?? "Unknown",
            clientProfilePicture: caseItem.clientProfilePicture ?? "default_image_path",
            lawyerFirstName: caseItem.lawyerFirstName ?? "Unknown",
            lawyerLastName: caseItem.lawyerLastName ?? "Unknown",
            lawyerProfilePicture: caseItem.lawyerProfilePicture ?? "default_image_path",
    ),
  ),
);

    },
    child: Card(
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
            Text(
              caseItem.caseName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Type: ${caseItem.caseType}'),
            Text('Status: ${caseItem.caseStatus}'),
            Text('Details: ${caseItem.caseDetails}'),
            SizedBox(height: 8),
            Text(
              'Created At: ${_formatDate(caseItem.createdAt)}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
}

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
