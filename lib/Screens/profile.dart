import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClientProfilePage(),
    );
  }
}

class ClientProfilePage extends StatefulWidget {
  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  String firstName = 'John';
  String lastName = 'Doe';
  String email = 'john.doe@example.com';
  String phoneNumber = '+1234567890';
  String address = '123 Main St, City';
  String password = '********';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Client Profile'),
        actions: [
          InkWell(
            onTap: () {
              _editProfile();
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/passport.png', // Use your image asset path
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 16),
            _buildInfoField('First Name', firstName),
            _buildInfoField('Last Name', lastName),
            _buildInfoField('Email', email),
            _buildInfoField('Phone Number', phoneNumber),
            _buildInfoField('Address', address),
            _buildInfoField('Password', password),
            _buildInfoField('Created At', '1/1/2023'),
            _buildInfoField('Updated At', '1/1/2023'),
            _buildInfoField('Verified', 'Verified'),
            _buildInfoField('Account Type', 'Client'),
            SizedBox(height: 16),
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
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  void _editProfile() async {
    var updatedInfo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditClientProfilePage(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
          password: password,
        ),
      ),
    );

    if (updatedInfo != null) {
      setState(() {
        // Update the state with the edited information
        firstName = updatedInfo['firstName'];
        lastName = updatedInfo['lastName'];
        email = updatedInfo['email'];
        phoneNumber = updatedInfo['phoneNumber'];
        address = updatedInfo['address'];
        password = updatedInfo['password'];
      });
    }
  }
}

class EditClientProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String password;

  EditClientProfilePage({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
  });

  @override
  _EditClientProfilePageState createState() => _EditClientProfilePageState();
}

class _EditClientProfilePageState extends State<EditClientProfilePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    addressController = TextEditingController(text: widget.address);
    passwordController = TextEditingController(text: widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('First Name', firstNameController),
            _buildTextField('Last Name', lastNameController),
            _buildTextField('Email', emailController),
            _buildTextField('Phone Number', phoneNumberController),
            _buildTextField('Address', addressController),
            _buildTextField('Password', passwordController),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Create a map with the updated information
                var updatedInfo = {
                  'firstName': firstNameController.text,
                  'lastName': lastNameController.text,
                  'email': emailController.text,
                  'phoneNumber': phoneNumberController.text,
                  'address': addressController.text,
                  'password': passwordController.text,
                };

                // Return the updated information to the previous screen
                Navigator.pop(context, updatedInfo);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
