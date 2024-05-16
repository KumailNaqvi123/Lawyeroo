import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/CreatePost.dart';
import 'package:project/Screens/post_details.dart';
import 'package:project/Screens/post.dart';

class QnABoard extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  QnABoard({required this.token, required this.userData});

  @override
  _QnABoardState createState() => _QnABoardState();
}

class _QnABoardState extends State<QnABoard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Post> allPosts = [];
  List<Post> myPosts = [];
  List<Post> selectedPosts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    print('User ID: ${widget.userData['id']}'); // Print user ID
    print('YOU ARE ON QNA BOARD');
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      // Fetch all posts
      final allResponse = await http.get(
        Uri.parse('${GlobalData().baseUrl}/api/questions'),
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );

      if (allResponse.statusCode == 200) {
        final responseBody = jsonDecode(allResponse.body);
        if (responseBody != null && responseBody['data'] != null) {
          setState(() {
            allPosts = (responseBody['data'] as Map<String, dynamic>).entries.map((entry) {
              return Post.fromJson(entry.key, entry.value);
            }).toList();
          });
        }
      } else {
        print('Failed to load all posts: ${allResponse.statusCode}');
      }

      // Fetch user-specific posts
      final myPostsResponse = await http.get(
        Uri.parse('${GlobalData().baseUrl}/api/questions/client/${widget.userData['id']}'),
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );
        print('User ID: ${widget.userData['id']}');
      if (myPostsResponse.statusCode == 200) {
        final responseBody = jsonDecode(myPostsResponse.body);
        if (responseBody != null && responseBody['data'] != null) {
          setState(() {
            myPosts = (responseBody['data'] as Map<String, dynamic>).entries.map((entry) {
              return Post.fromJson(entry.key, entry.value);
            }).toList();
          });
        }
      } else {
        print('Failed to load my posts: ${myPostsResponse.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _deletePost(String postId) async {
    try {
      final response = await http.delete(
        Uri.parse('${GlobalData().baseUrl}/api/questions/$postId'),
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );

      if (response.statusCode == 200) {
        print('Post deleted successfully.');
        _fetchPosts();
      } else {
        print('Failed to delete post: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Q&A Board'),
      backgroundColor: Color(0xFFDCBAFF),
      bottom: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: 'All Posts'),
          Tab(text: 'My Posts'),
        ],
      ),
    ),
    backgroundColor: Color(0xFFB884D1),
    body: TabBarView(
      controller: _tabController,
      children: [
        RefreshIndicator(
          onRefresh: _fetchPosts,  // Call _fetchPosts when the user swipes down
          child: ListView.builder(
            itemCount: allPosts.length,
            itemBuilder: (context, index) {
              return PostTile(
                post: allPosts[index],
                userData: widget.userData,
                token: widget.token,  // Pass the token
                useUserData: false,
              );
            },
          ),
        ),
        RefreshIndicator(
          onRefresh: _fetchPosts,  // Same function, it will refresh both lists
          child: ListView.builder(
            itemCount: myPosts.length,
            itemBuilder: (context, index) {
              return PostTile(
                post: myPosts[index],
                userData: widget.userData,
                token: widget.token,
                onDelete: (postId) => _deletePost(postId),
                useUserData: true,
              );
            },
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreatePostScreen(
              onSubmit: (title, content) {
                // Handle post submission here
              },
              userData: widget.userData,
              token: widget.token,
              context: context,
              reloadQuestionsAndAnswers: _fetchPosts, // Pass the reload function

            ),
          ),
        );
      },
      child: Icon(Icons.add),
    ),
  );
}
}

class PostTile extends StatelessWidget {
  final Post post;
  final Map<String, dynamic> userData;
  final String token;  // Add token here
  final Function(String)? onDelete;
  final bool useUserData;

  PostTile({
    required this.post,
    required this.userData,
    required this.token,  // Ensure token is required
    this.onDelete,
    this.useUserData = false,
  });

  @override
  Widget build(BuildContext context) {
    // Adding logs to check what userData contains
    print('UserData provided: $userData');

    // Safely access userData with null checks and logging
    String displayPicture = useUserData && userData != null && userData.containsKey('profile_picture')
      ? userData['profile_picture']
      : (post.userProfilePicture ?? 'default_profile_picture.png');  // Provide a default image if none found

    String displayName = useUserData && userData != null && userData.containsKey('first_name') && userData.containsKey('last_name')
      ? "${userData['first_name']} ${userData['last_name']}"
      : (post.userName ?? 'Anonymous');  // Default to 'Anonymous' if no user name is provided

    // Log any potential null issues or data status
    print('Display Picture URL: $displayPicture');
    print('Display Name: $displayName');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailsScreen(post: post, userData: userData, token: token),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(displayPicture),
                    radius: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    displayName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                post.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                post.content,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 12),
              Text(
                _getTimeElapsed(post.creationTime),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

String _getTimeElapsed(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inMinutes} minutes ago';
    }
  }
}
