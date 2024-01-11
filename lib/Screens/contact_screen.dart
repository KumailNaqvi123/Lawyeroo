import 'package:flutter/material.dart';
import 'package:project/Screens/Settings.dart';
import 'package:project/Screens/home_screen.dart';
import 'chat_screen.dart';
import 'calls_screen.dart';
import 'package:project/Screens/News.dart';
import 'package:project/Screens/qna_board.dart';

class Message {
  final String sender;
  final String text;
  final DateTime timestamp;

  Message(this.sender, this.text, this.timestamp);
}

class ContactsScreen extends StatelessWidget {
  final List<Message> messages = [
    Message('Ali', 'Hi, this is Ali. How are you?', DateTime.now().subtract(Duration(minutes: 10))),
    Message('Ahmed', 'Hello, how''s it going?', DateTime.now().subtract(Duration(minutes: 15))),
    Message('Hamza', 'Hey there!', DateTime.now().subtract(Duration(minutes: 20))),
    // Add more messages for other contacts if needed
  ];

  // Pass the context from the parent widget
  ContactsScreen({Key? key, required this.context}) : super(key: key);
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove back button
          backgroundColor: Color(0xFFDCBAFF),
          centerTitle: false,
          titleSpacing: 0.0,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 8.0),
                Text(
                  'Chat',
                  style: TextStyle(color: Color.fromARGB(226, 48, 65, 124), fontSize: 18.0),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Chats'),
              Tab(text: 'Calls'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Color(0xFF9386E6),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.black54, fontSize: 16.0),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 16.0, 8.0),
                          child: ListTile(
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center, // Align children vertically
                              children: [
                                _buildProfilePicture(),
                                SizedBox(width: 12.0), // Adjusted spacing
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message.sender,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      _buildLastMessage(message.sender),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(contact: message.sender),
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
            ),
            CallsScreenPage(),
          ],
        ),
        bottomNavigationBar: _buildNavBar(),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: AssetImage('assets/images/passport.png'),
    );
  }

  Widget _buildNavBar() {
    return Container(
      color: Color(0xFFDCBAFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.message,
              color: Color(0xFF912bFF),
            ),
            onPressed: () {
              // Handle messaging button press
            },
          ),
          IconButton(
            icon: Icon(Icons.article),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.question_answer),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QnABoard()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLastMessage(String contact) {
    // Fetch and display the last message for each contact
    final lastMessage = messages.firstWhere((message) => message.sender == contact, orElse: () => Message('', '', DateTime.now()));
    final formattedTime = '${lastMessage.timestamp.hour}:${lastMessage.timestamp.minute}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align to the right edge
      children: [
        Expanded(
          child: Text(
            lastMessage.text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        SizedBox(width: 15.0), // Adjusted spacing for timestamp
        Text(
          formattedTime,
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
