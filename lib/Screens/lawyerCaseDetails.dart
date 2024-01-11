import 'package:flutter/material.dart';
import 'package:project/Screens/lawyercases.dart';

class CaseDetailsPage extends StatelessWidget {
  final LawyerCase caseItem;

  CaseDetailsPage({required this.caseItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Case Details'),
        backgroundColor: Color(0xFFDCBAFF), // Set app bar background color to dcbaff
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
              _buildItem(
                'Created At',
                _formatDate(caseItem.createdAt),
              ),
              _buildItem(
                'Updated At',
                _formatDate(caseItem.updatedAt),
              ),
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
