import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';

class Message {
  final String senderId;
  final String text;
  final DateTime timestamp;

  Message(this.senderId, this.text, this.timestamp);
}

class ChatScreen extends StatefulWidget {
  final String? conversationId;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final String senderId;
  ChatScreen({
    this.conversationId,
    required this.senderId,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messages = [];
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.conversationId != null) {
      _fetchMessages();
    }
  }

 Future<void> _fetchMessages() async {
  if(widget.conversationId != null) {
    try {
      final url = '${GlobalData().baseUrl}/api/messages/${widget.conversationId}';
      print('Fetching messages from: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${GlobalData().token}', // Replace with your actual token
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      
 if (response.statusCode == 200) {
  final List<dynamic> data = json.decode(response.body);
  setState(() {
    _messages = data.map((messageData) {
      // Handle parsing errors by providing default values or skipping invalid data
      final senderId = messageData['senderId'] ?? '';
      final messageText = messageData['messageText'] ?? '';
      final timestamp = messageData['timestamp'] is String
          ? DateTime.parse(messageData['timestamp'])
          : DateTime.now(); // Use current time if parsing fails

      return Message(
        senderId,
        messageText,
        timestamp,
      );
    }).toList();
  });
} else {
  throw Exception('Failed to fetch messages');
}

    } catch (error) {
      print('Error fetching messages: $error');
    }
  } else {
    print('Conversation ID is null, cannot fetch messages');
  }
}

Future<void> _sendMessage(String text) async {
  try {
    final senderId = widget.senderId;
    final receiverId = GlobalData().userData['id'];
    
    print('Sending message:');
    print('Sender ID: $senderId');
    print('Receiver ID: $receiverId');
    print('Message Text: $text');

    final response = await http.post(
      Uri.parse('${GlobalData().baseUrl}/api/messages'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GlobalData().token}', // Replace with your actual token
      },
      body: json.encode({
        'senderId': senderId,
        'receiverId': receiverId,
        'messageText': text,
      }),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      // Message sent successfully, fetch messages again to update the UI
      _fetchMessages();
    } else {
      throw Exception('Failed to send message');
    }
  } catch (error) {
    print('Error sending message: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.firstName} ${widget.lastName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.text),
                  subtitle: Text('${message.timestamp}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
IconButton(
  icon: Icon(Icons.send),
  onPressed: () {
    _sendMessage(_textController.text);
    _textController.clear(); // Clear the text field
    FocusScope.of(context).unfocus(); // Dismiss the keyboard
  },
),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
