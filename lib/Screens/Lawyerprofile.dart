import 'package:flutter/material.dart';
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/editlawyerprofile.dart';

class LawyerProfilePage extends StatefulWidget {
  final String token;
  Map<String, dynamic> userData;

  LawyerProfilePage({required this.token, required this.userData});

  @override
  _LawyerProfilePageState createState() => _LawyerProfilePageState();
}

class _LawyerProfilePageState extends State<LawyerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDCBAFF),
        automaticallyImplyLeading: false,
        title: Text('Lawyer Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditLawyerProfilePage(
                    lawyerId: GlobalData().userData['lawyer_id'] ?? '',
                    firstName: GlobalData().userData['first_name'] ?? '',
                    lastName: GlobalData().userData['last_name'] ?? '',
                    email: GlobalData().userData['email'] ?? '',
                    phoneNumber: GlobalData().userData['ph_number'] ?? '',
                    address: GlobalData().userData['address'] ?? '',
                    profilePicture: GlobalData().userData['profile_picture'] ?? '',
                    specializations:  GlobalData().userData['specializations'],
                    userData: GlobalData().userData,
                    token: widget.token,
                    onUpdateComplete: (newData) => setState(() {
                      widget.userData = newData;
                    }),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFDCBAFF),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildProfileDetails(),
            ),
          ),
        ),
      ),
    );
  }

List<Widget> _buildProfileDetails() {
  return [
    if (widget.userData.isNotEmpty) ...[
      Center(
        child: CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(widget.userData['profile_picture'] ?? 'assets/images/default_avatar.png'),
        ),
      ),
      SizedBox(height: 16),
      _buildInfoField('First Name', widget.userData['first_name']),
      _buildInfoField('Last Name', widget.userData['last_name']),
      _buildInfoField('Email', widget.userData['email']),
      _buildInfoField('Phone Number', widget.userData['ph_number']),
      _buildInfoField('Address', widget.userData['address']),
      _buildInfoField('Fees', widget.userData['fees']),
      _buildInfoField('Specializations', widget.userData['specializations']),
      _buildInfoField('Years of Experience', widget.userData['years_of_experience']),
      _buildInfoField('Fees', widget.userData['fees']),
      _buildInfoField('Universities', widget.userData['universities']),
      _buildInfoField('Verified', widget.userData['verified']?.toString() ?? 'No'),
      _buildInfoField('Account Type', 'Lawyer'),
    ],
  ];
}


  Widget _buildInfoField(String label, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          Flexible(child: Text(value.toString(), textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
