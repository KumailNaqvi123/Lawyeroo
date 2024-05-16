class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  String clientId = '';
  String token = '';
  Map<String, dynamic> userData = {}; // Add userData variable

  // Add a base URL variable
  final String baseUrl = 'http://192.168.10.6:3000';

  void setUserData(String id, String tkn, Map<String, dynamic> data) {
    clientId = id;
    token = tkn;
    userData = data; // Assign userData
  }
}
