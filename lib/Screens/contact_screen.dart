import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'chat_screen.dart';
import 'package:project/Screens/Global.dart';
import 'calls_screen.dart';

class Message {
  final String senderId;
  final String senderFirstName;
  final String senderLastName;
  final String senderProfilePicture;
  final String text;
  final DateTime timestamp;
 final String conversationId;
  Message(this.senderId, this.senderFirstName, this.senderLastName, this.senderProfilePicture, this.text, this.timestamp, this.conversationId);
}

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    fetchConversations();
  }

  Future<void> fetchConversations() async {
    print("Fetching conversations...");
    try {
      final response = await http.get(
        Uri.parse('${GlobalData().baseUrl}/api/messages/users/${GlobalData().userData['id']}'),
        headers: {
          'Authorization': 'Bearer ${GlobalData().token}', // Replace with your actual token
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> conversationIds = data['conversationIds'];

        print("Conversation IDs: $conversationIds");

        final List<Future<void>> fetchFutures = [];
        
        for (String conversationId in conversationIds) {
          final future = fetchMessagesForConversation(conversationId);
          fetchFutures.add(future);
        }

        await Future.wait(fetchFutures);
        print("Fetched all conversations.");
      } else {
        throw Exception('Failed to fetch conversations');
      }
    } catch (error) {
      print('Error fetching conversations: $error');
    }
  }

Future<void> fetchMessagesForConversation(String conversationId) async {
  try {
    print("Fetching messages for conversation $conversationId");
    final response = await http.get(
      Uri.parse('${GlobalData().baseUrl}/api/messages/$conversationId'),
      headers: {
        'Authorization': 'Bearer ${GlobalData().token}', // Replace with your actual token
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print("body $data");
      if (data.isNotEmpty) {
        final currentUserID = GlobalData().userData['id'];

        // Find the last message in the conversation
        var latestMessageData = data.last;

        final senderId = latestMessageData['senderId'];
        final senderFirstName = latestMessageData['sender']['first_name'] ?? "";
        final senderLastName = latestMessageData['sender']['last_name'] ?? "";
        final senderProfilePicture = latestMessageData['sender']['profile_picture'] ?? "";
        final receiverId = latestMessageData['receiverId'];
        final receiverFirstName = latestMessageData['receiver']['first_name'] ?? "";
        final receiverLastName = latestMessageData['receiver']['last_name'] ?? "";
        final receiverProfilePicture = latestMessageData['receiver']['profile_picture'] ?? "";
        final text = latestMessageData['messageText'];
        final timestamp = DateTime.fromMillisecondsSinceEpoch(latestMessageData['timestamp']);

        // If the current user is the sender, use receiver's information
        final messageSenderID = (currentUserID == senderId) ? receiverId : senderId;
        final messageSenderFirstName = (currentUserID == senderId) ? receiverFirstName : senderFirstName;
        final messageSenderLastName = (currentUserID == senderId) ? receiverLastName : senderLastName;
        final messageSenderProfilePicture = (currentUserID == senderId) ? receiverProfilePicture : senderProfilePicture;

        // Create a message object
        final message = Message(
          messageSenderID,
          messageSenderFirstName,
          messageSenderLastName,
          messageSenderProfilePicture,
          text,
          timestamp,
          conversationId,
        );

        // Print message details
        print("Message details:");
        print("Sender First Name: ${message.senderFirstName}");
        print("Sender Last Name: ${message.senderLastName}");
        print("Sender Profile Picture: ${message.senderProfilePicture}");
        print("Text: ${message.text}");
        print("Timestamp: ${message.timestamp}");

        // Add the message to the messages list
        setState(() {
          messages.add(message);
        });
      }
    } else {
      throw Exception('Failed to fetch messages for conversation: $conversationId');
    }
  } catch (error) {
    print('Error fetching messages for conversation $conversationId: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(message.senderProfilePicture),
                            ),
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${message.senderFirstName} ${message.senderLastName}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Text(
                                        message.text,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChatScreen(
        conversationId: message.conversationId,
        senderId: message.senderId,
        firstName: message.senderFirstName,
        lastName: message.senderLastName,
        profilePicture: message.senderProfilePicture,
      ),
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
      ),
    );
  }
}
