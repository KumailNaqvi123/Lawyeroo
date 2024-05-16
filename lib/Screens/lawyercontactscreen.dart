import 'package:flutter/material.dart';
import 'package:project/Screens/Settings.dart';
import 'package:project/Screens/lawyerhomepage.dart';
import 'package:project/Screens/lawyerchatscreen.dart';
import 'package:project/Screens/lawyernotificiations.dart';
import 'package:project/Screens/lawyersettings.dart';
import 'calls_screen.dart';

class Lawyer {
  
  final String name;
  final String specialization;
  final String lastMessage;
  final DateTime lastMessageTime;

  Lawyer(this.name, this.specialization, this.lastMessage, this.lastMessageTime);
}

class LawyerContactsScreen extends StatelessWidget {
  final List<Lawyer> lawyers = [
    Lawyer('Ali', 'Criminal Defense', 'How can I help you?', DateTime.now().subtract(Duration(minutes: 10))),
    Lawyer('Ahmed', 'Family Law', 'Let\'s discuss your case.', DateTime.now().subtract(Duration(minutes: 15))),
    Lawyer('Hamza', 'Personal Injury', 'Meeting at 2 PM tomorrow.', DateTime.now().subtract(Duration(minutes: 20))),
    // Add more lawyers if needed
  ];

  // Pass the context from the parent widget
  LawyerContactsScreen({Key? key, required this.context}) : super(key: key);
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
                      itemCount: lawyers.length,
                      itemBuilder: (context, index) {
                        final lawyer = lawyers[index];
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
                                        lawyer.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Text(
                                        lawyer.specialization,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      _buildLastMessage(lawyer),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => lawyerChatScreen(contact: lawyer.name),
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
        // bottomNavigationBar: _buildNavBar(),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: AssetImage('assets/images/lawyer_avatar.png'),
    );
  }

  // Widget _buildNavBar() {
  //   return Container(
  //     color: Color(0xFFDCBAFF),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         IconButton(
  //           icon: Icon(Icons.home),
  //           onPressed: () {
  //             Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(builder: (context) => LawyerHomepage()),
  //               (route) => false,
  //             );
  //           },
  //         ),
  //         IconButton(
  //           icon: Icon(
  //             Icons.message,
  //             color: Color(0xFF912bFF),
  //           ),
  //           onPressed: () {
  //             // Handle messaging button press
  //           },
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.notifications),
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => LawyerNotificationsPage()),
  //             );
  //           },
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.person),
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => LawyerSettingsPage()),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLastMessage(Lawyer lawyer) {
    // Display the last message and its timestamp
    final formattedTime = '${lawyer.lastMessageTime.hour}:${lawyer.lastMessageTime.minute}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align to the right edge
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lawyer.lastMessage,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 5.0), // Adjusted spacing between last message and timestamp
            ],
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


