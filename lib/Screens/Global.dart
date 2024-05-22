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

  //final String baseUrl = 'http://192.168.10.5:3000';

  final String baseUrl = 'https://74a0-154-81-228-94.ngrok-free.app';  //backend

  void setUserData(String id, String tkn, Map<String, dynamic> data) {
    clientId = id;
    token = tkn;
    userData = data; // Assign userData
  }
}
