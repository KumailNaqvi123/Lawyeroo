import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Screens/CreatePost.dart';
import 'post_details.dart';

class QnABoard extends StatefulWidget {
  @override
  _QnABoardState createState() => _QnABoardState();
}

class _QnABoardState extends State<QnABoard> {
  List<Post> posts = [];

  // Define user's name and profile picture
  String userName = "Your Name";
  String userProfilePicture = "assets/images/profile_picture.png"; // Replace with actual path

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
      backgroundColor: Color(0xFFB884D1), // Set background color here
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
    );
  }

  void addPost(String title, String content) {
    setState(() {
      posts.add(Post(
        title: title,
        content: content,
        comments: [],
        creationTime: DateTime.now(),
        userName: userName, // Include user's name when creating the post
        userProfilePicture: userProfilePicture, // Include user's profile picture when creating the post
      ));
    });
  }
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
            // Post Title
            Text(
              post.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8), // Added spacing
            // Post Content
            Text(
              post.content,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 12), // Added spacing
            // Post metadata
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getTimeElapsed(post.creationTime),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                // Add additional metadata if needed
              ],
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
  final String userName; // User's name
  final String userProfilePicture; // User's profile picture

  Post({
    required this.title,
    required this.content,
    required this.comments,
    required this.creationTime,
    required this.userName,
    required this.userProfilePicture,
  });
}

class Comment {
  final String text;

  Comment(this.text);
}
