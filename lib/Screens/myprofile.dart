//THIS IS FOR LAWYER PROFLE
class UserProfile {
  static final UserProfile _instance = UserProfile._internal();

  factory UserProfile() {
    return _instance;
  }

  UserProfile._internal();

  String firstName = 'John';
  String lastName = 'Doe';
  String email = 'john.doe@example.com';
  String phoneNumber = '+1234567890';
  String address = '123 Main St, City';
  String password = '********';
  String specializations = 'Criminal Law';
  String experience = '10 years';
  String universities = 'Harvard';

  void updateProfile(Map<String, String> updatedData) {
    firstName = updatedData['firstName'] ?? firstName;
    lastName = updatedData['lastName'] ?? lastName;
    email = updatedData['email'] ?? email;
    phoneNumber = updatedData['phoneNumber'] ?? phoneNumber;
    address = updatedData['address'] ?? address;
    password = updatedData['password'] ?? password;
    specializations = updatedData['specializations'] ?? specializations;
    experience = updatedData['experience'] ?? experience;
    universities = updatedData['universities'] ?? universities;
  }
}
