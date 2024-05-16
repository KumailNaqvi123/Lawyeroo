import 'package:flutter/material.dart';
import 'package:project/Screens/editprofile.dart';

class ClientProfilePage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  ClientProfilePage({required this.token, required this.userData});

  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  Map<String, dynamic> userData; // Mutable userData

  _ClientProfilePageState() : userData = {};

  @override
  void initState() {
    super.initState();
    userData = Map.from(widget.userData); // Initialize mutable userData with widget.userData
    print("User Data: $userData");
  }

  void updateUserData(Map<String, dynamic> newData) {
    print("NEW DATA $newData" );
    setState(() {
      userData = newData; // Update userData state
    });
  }


 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text('Client Profile'),
      centerTitle: true,
      backgroundColor: Color(0xFFDCBAFF),
      actions: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditClientProfilePage(
                clientId: userData['id'].toString(), // Use userData directly here
                firstName: userData['first_name'], // Use userData directly here
                lastName: userData['last_name'], // Use userData directly here
                email: userData['email'], // Use userData directly here
                phoneNumber: userData['ph_number'], // Use userData directly here
                address: userData['address'], // Use userData directly here
                profilePicture: userData['profile_picture'], // Use userData directly here
                userData: userData, // Use userData directly here
                token: widget.token,
                onUpdateComplete: updateUserData,
              )),
            );
          },
        ),
      ],
    ),
    // Set the entire background color here
    backgroundColor: Color(0xFFDCBAFF),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userData['profile_picture'] ?? 'assets/images/default_avatar.png'), // Use userData directly here
            ),
          ),
          SizedBox(height: 16),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoField('First Name', userData['first_name'] ?? ''), // Use userData directly here
                  _buildInfoField('Last Name', userData['last_name'] ?? ''), // Use userData directly here
                  _buildInfoField('Email', userData['email'] ?? ''), // Use userData directly here
                  _buildInfoField('Phone Number', userData['ph_number'] ?? ''), // Use userData directly here
                  _buildInfoField('Address', userData['address'] ?? ''), // Use userData directly here
                  _buildInfoField('Created At', userData['created_at'] ?? ''), // Use userData directly here
                  _buildInfoField('Updated At', userData['updated_at'] ?? ''), // Use userData directly here
                  _buildInfoField('Verified', userData['verified']?.toString() ?? 'No'), // Use userData directly here
                  _buildInfoField('Account Type', 'Client'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 14),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
