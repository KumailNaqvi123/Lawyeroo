import 'package:flutter/material.dart';
import 'package:project/Screens/editcasedetails.dart';
import 'package:project/Screens/lawyercases.dart';

class CaseDetailsPage extends StatefulWidget {
  final LawyerCase caseItem;
  final String token;

  CaseDetailsPage({required this.caseItem, required this.token});

  @override
  _CaseDetailsPageState createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  late LawyerCase caseItem;

  @override
  void initState() {
    super.initState();
    caseItem = widget.caseItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Case Details'),
        backgroundColor: Color(0xFFDCBAFF),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final updatedCase = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCasePage(
                    caseItem: caseItem,
                    token: widget.token,
                  ),
                ),
              );

              if (updatedCase != null) {
                setState(() {
                  caseItem = updatedCase;
                });
                Navigator.pop(context, updatedCase);  // Return the updated case
              }
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFB884D1),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          child: ListView(
            children: [
              _buildItem('Case Name', caseItem.caseName),
              _buildItem('Type', caseItem.caseType),
              _buildItem('Status', caseItem.caseStatus),
              _buildItem('Details', caseItem.caseDetails),
              _buildItem('Created At', _formatDate(caseItem.createdAt)),
              _buildItem('Updated At', _formatDate(caseItem.updatedAt)),
            ],
          ),
        ),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
