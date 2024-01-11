import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Screens/CreatePost.dart';
import 'package:project/Screens/News.dart';
import 'package:project/Screens/contact_screen.dart';
import 'package:project/Screens/home_screen.dart';
import 'package:project/Screens/Settings.dart';
import 'post_details.dart';

class QnABoard extends StatefulWidget {
  @override
  _QnABoardState createState() => _QnABoardState();
}

class _QnABoardState extends State<QnABoard> {
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Q&A Board'),
        backgroundColor: Color(0xFFDCBAFF),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePostScreen(onSubmit: addPost),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffefeae2),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PostDetailsScreen(post: posts[index]),
                ),
              );
            },
            child: PostTile(post: posts[index]),
          );
        },
      ),


      //bottomNavigationBar: _buildNavBar(context),


    );
  }

  void addPost(String title, String content) {
    setState(() {
      posts.add(Post(
        title: title,
        content: content,
        comments: [],
        creationTime: DateTime.now(),
      ));
    });
  }

  // Widget _buildNavBar(BuildContext context) {
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
  //               MaterialPageRoute(builder: (context) => HomeScreen()),
  //               (route) => false,
  //             );
  //           },
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.chat),
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => ContactsScreen(context: context),
  //               ),
  //             );
  //           },
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.article),
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => NewsPage()),
  //             );
  //           },
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.question_answer, color: Color(0xFF912bFF)),
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => QnABoard()),
  //             );
  //           },
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.person),
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => SettingsPage()),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Title and Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  post.content,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            // Upvote and Downvote Buttons
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     // Upvote Button
            //     TextButton(
            //       onPressed: () {
            //         // Implement upvote logic here
            //       },
            //       child: Icon(Icons.arrow_upward),
            //     ),
            //     // Downvote Button
            //     TextButton(
            //       onPressed: () {
            //         // Implement downvote logic here
            //       },
            //       child: Icon(Icons.arrow_downward),
            //     ),
            //   ],
            // ),
            // Date and Time (Top right)
            Align(
              alignment: Alignment.topRight,
              child: Text(
                _getTimeElapsed(post.creationTime),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeElapsed(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inMinutes}m';
    }
  }
}

class Post {
  final String title;
  final String content;
  final List<Comment> comments;
  final DateTime creationTime;

  Post({
    required this.title,
    required this.content,
    required this.comments,
    required this.creationTime,
  });
}

class Comment {
  final String text;

  Comment(this.text);
}