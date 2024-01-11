import 'package:flutter/material.dart';
import 'package:project/Screens/News.dart';
import 'package:project/Screens/Settings.dart';
import 'package:project/Screens/calls_screen.dart';
import 'package:project/Screens/home_screen.dart';
import 'package:project/Screens/qna_board.dart';

class Message {
  final String sender;
  final String text;
  final DateTime timestamp;

  Message(this.sender, this.text, this.timestamp);
}

class ChatScreen extends StatefulWidget {
  final String contact;

  ChatScreen({required this.contact});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Map<String, List<Message>> _contactMessages = {};
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add the initial messages
    _addInitialMessages(widget.contact);
    _addInitialMessages2('Ahmed');
    _addInitialMessages3('Hamza');
  }

  // Function to add the initial messages for a specific contact
  void _addInitialMessages(String contact) {
    _contactMessages[contact] = [
      Message(
        contact,
        'Hi, this is $contact. How are you?',
        DateTime.now().subtract(Duration(minutes: 10)),
      ),
    ];
  }

  void _addInitialMessages2(String contact) {
    _contactMessages[contact] = [
      Message(
        contact,
        'Hello, how\'s it going?',
        DateTime.now().subtract(Duration(minutes: 15)),
      ),
    ];
  }

  void _addInitialMessages3(String contact) {
    _contactMessages[contact] = [
      Message(
        contact,
        'Hey there!',
        DateTime.now().subtract(Duration(minutes: 20)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFDCBAFF),
        title: Row(
          children: [
            _buildProfilePicture(),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.contact}',
                  style: TextStyle(
                    color: Color(0xFF30417C),
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () => _makeCall(widget.contact),
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              // Handle video call button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _contactMessages[widget.contact]?.length ?? 0,
                itemBuilder: (context, index) {
                  final message = _contactMessages[widget.contact]![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfilePicture(),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.sender,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(message.text),
                            ],
                          ),
                        ),
                        Text(
                          '${message.timestamp.hour}:${message.timestamp.minute}',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          _buildMessageBox(),
        ],
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 20.0,
      backgroundImage: AssetImage('assets/images/passport.png'),
    );
  }

 Widget _buildMessageBox() {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Adjusted vertical padding
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: '\t\tType a message...',
                contentPadding: EdgeInsets.symmetric(vertical: 12.0), // Adjusted vertical content padding
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onSubmitted: _handleMessageSubmit,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () => _handleMessageSubmit(_textController.text),
        ),
      ],
    ),
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

  void _handleMessageSubmit(String text) {
  if (text.isNotEmpty) {
    setState(() {
      _contactMessages[widget.contact]?.add(
        Message('you', text, DateTime.now()), // Set the sender as "you" for your messages
      );
      _textController.clear();
    });
  }
}

  void _makeCall(String contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallScreen(contact: contact),
      ),
    );
  }
}
