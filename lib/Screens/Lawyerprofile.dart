import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LawyerProfilePage()
    );
  }
}

class LawyerProfilePage extends StatefulWidget {
  @override
  _LawyerProfilePageState createState() => _LawyerProfilePageState();
}

class _LawyerProfilePageState extends State<LawyerProfilePage> {
  String firstName = 'John';
  String lastName = 'Doe';
  String email = 'john.doe@example.com';
  String phoneNumber = '+1234567890';
  String address = '123 Main St, City';
  String password = '********';
  String specializations = 'Random Specializations';
  String experience = 'Random Experience';
  String universities = 'Random Universities';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoField('First Name', firstName),
            _buildInfoField('Last Name', lastName),
            _buildInfoField('Email', email),
            _buildInfoField('Phone Number', phoneNumber),
            _buildInfoField('Address', address),
            _buildInfoField('Password', password),
            _buildInfoField('Specializations', specializations),
            _buildInfoField('Years of Experience', experience),
            _buildInfoField('Universities', universities),


            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                var updatedInfo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      firstName: firstName,
                      lastName: lastName,
                      email: email,
                      phoneNumber: phoneNumber,
                      address: address,
                      password: password,
                      specializations: specializations,
                      experience: experience,
                      universities: universities,
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
                    specializations = updatedInfo['specializations'];
                    experience = updatedInfo['experience'];
                    universities = updatedInfo['universities'];
                  });
                }
              },
              child: Text('Edit Profile'),
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
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildClientFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoField('Created At', 'Client created date'),
        _buildInfoField('Updated At', 'Client updated date'),
        _buildInfoField('Profile Picture', 'Client profile picture URL'),
        _buildInfoField('Verified', 'Client verification status'),
        _buildInfoField('Account Type', 'Client'),
      ],
    );
  }

  Widget _buildLawyerFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoField('Rating', 'Lawyer rating'),
        _buildInfoField('Time Created', 'Lawyer created date'),
        _buildInfoField('Time Updated', 'Lawyer updated date'),
        _buildInfoField('Profile Picture', 'Lawyer profile picture URL'),
        _buildInfoField('Verified', 'Lawyer verification status'),
        _buildInfoField('Account Type', 'Lawyer'),
      ],
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String password;
  final String specializations;
  final String experience;
  final String universities;

  EditProfilePage({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.specializations,
    required this.experience,
    required this.universities,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController passwordController;
  late TextEditingController specializationsController;
  late TextEditingController experienceController;
  late TextEditingController universitiesController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    addressController = TextEditingController(text: widget.address);
    passwordController = TextEditingController(text: widget.password);
    specializationsController = TextEditingController(text: widget.specializations);
    experienceController = TextEditingController(text: widget.experience);
    universitiesController = TextEditingController(text: widget.universities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            _buildTextField('Specializations', specializationsController),
            _buildTextField('Years of Experience', experienceController),
            _buildTextField('Universities', universitiesController),

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
                  'specializations': specializationsController.text,
                  'experience': experienceController.text,
                  'universities': universitiesController.text,
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
