import 'package:flutter/material.dart';
import 'dart:math';

class CallsScreenPage extends StatefulWidget {
  @override
  _CallsScreenPageState createState() => _CallsScreenPageState();
}

class _CallsScreenPageState extends State<CallsScreenPage> {
  final List<String> calls = ['Ali', 'Ahmed', 'Hamza'];
  List<String> filteredCalls = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCalls = calls.map((call) => _generateCallWithTimestamp(call)).toList();
    searchController.addListener(_onSearchChanged);
  }

  String _generateCallWithTimestamp(String call) {
    // Generating a random timestamp for demonstration purposes
    DateTime randomTimestamp = DateTime.now().subtract(Duration(minutes: Random().nextInt(60 * 24 * 7)));
    String formattedTime = "${randomTimestamp.hour}:${randomTimestamp.minute}";
    return "$call - $formattedTime";
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String searchText = searchController.text.toLowerCase();
    setState(() {
      filteredCalls = calls
          .where((call) => call.toLowerCase().contains(searchText))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xFF9386E6),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: searchController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search Calls...',
                hintStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: filteredCalls.length,
                    itemBuilder: (context, index) {
                      final call = filteredCalls[index];
                      bool isAttended = Random().nextBool(); // Randomly determine if call was attended
                      DateTime callTimestamp = DateTime.now().subtract(Duration(minutes: Random().nextInt(60 * 24 * 7)));
                      String formattedTimestamp = "${callTimestamp.hour}:${callTimestamp.minute}";
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: _buildProfilePicture(), // Profile picture
                          title: Text(
                            call,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          subtitle: Text(
                            '${isAttended ? 'Attended' : 'Missed'} - $formattedTimestamp',
                            style: TextStyle(color: isAttended ? Colors.green : Colors.red),
                          ),
                          trailing: Icon(
                            isAttended ? Icons.call_received : Icons.call_missed,
                            color: isAttended ? Colors.green : Colors.red,
                          ),
                          onTap: () => _makeCall(context, call),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    // You can replace this with the actual profile picture widget
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: AssetImage('assets/images/passport.png'),
    );
  }

  void _makeCall(BuildContext context, String contact) {
    // Navigate to the CallScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallScreen(contact: contact),
      ),
    );
  }
}

class CallScreen extends StatefulWidget {
  final String contact;

  CallScreen({required this.contact});

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isCallEnded = false;
  DateTime callStartTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calling ${widget.contact}'),
        backgroundColor: Colors.green, // You can customize the color for the call screen
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage('assets/images/passport.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Calling ${widget.contact}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            if (isCallEnded)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Call started at: ${callStartTime.hour}:${callStartTime.minute}',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            IconButton(
              icon: Icon(
                Icons.phone,
                size: 64,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  isCallEnded = true;
                });
                Navigator.pop(context); // This will take you back to the CallsScreenPage
              },
            ),
          ],
        ),
      ),
    );
  }
}
