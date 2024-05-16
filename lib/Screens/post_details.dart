import 'package:flutter/material.dart';
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostDetailsScreen extends StatefulWidget {
  final Post post;
  final Map<String, dynamic> userData;
  final String token;

  PostDetailsScreen({required this.post, required this.userData, required this.token});

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late Post _post;
  
 @override
  void initState() {
    super.initState();
    _post = widget.post;
    print('Token received in PostDetailsScreen: ${widget.token}');
    print('Post Details:');
    print('Title: ${_post.title}');
    print('Content: ${_post.content}');
    print('Comments: ${_post.comments.length}');
    print('User Data:');
    print('User Type: ${widget.userData['account_type']}');
    print('User ID: ${widget.userData['id']}');
  }


  void _addNewComment(Comment newComment) {
    setState(() {
      _post.comments.add(newComment);
    });
  }

Future<void> _fetchPostDetails() async {
  try {
    // Make a GET request to your backend API endpoint
    final response = await http.get(
      Uri.parse('${GlobalData().baseUrl}/api/questions/${_post.id}'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      // Parse the response and update the _post object with the new details
      final responseBody = jsonDecode(response.body);
      setState(() {
        _post = Post.fromJson(responseBody['id'], responseBody);
      });
    } else {
      print('Failed to fetch post details: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching post details: $e');
  }
}


   @override
  Widget build(BuildContext context) {
    bool isLawyer = widget.userData['account_type'] == 'Lawyer';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDCBAFF),
        automaticallyImplyLeading: false,
        title: Text(_post.title),
      ),
      body: Container(
        color: Color(0xFFB884D1),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      color: Colors.white.withOpacity(0.8),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _post.title,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _post.content,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 20),
                    Text(
                      'Comments:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _post.comments.length,
                        itemBuilder: (context, index) {
                          return CommentTile(comment: _post.comments[index]);
                        },
                      ),
                    ),
                    if (isLawyer)
                      CommentInputField(
                        token: '${widget.token}',
                        questionId: _post.id ?? 'default_post_id',
                        lawyerId: widget.userData['id'] ?? 'default_lawyer_id',
                        userData: widget.userData,
                        onNewComment: (newComment) {
                          _addNewComment(newComment);
                          _fetchPostDetails(); // Call method to fetch post details again
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CommentTile extends StatelessWidget {
  final Comment comment;

  CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8), // Translucent white
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reddit style username with profile picture within the post card
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  // Placeholder for user profile picture
                  backgroundImage: NetworkImage(comment.userProfilePicture),
                ),
                SizedBox(width: 8),
                Text(
                  comment.userName, // Display actual username
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              comment.text,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentInputField extends StatefulWidget {
  final String token;
  final String questionId;
  final String lawyerId;
  final Map<String, dynamic> userData; // Add userData parameter
  final Function(Comment) onNewComment;

  CommentInputField({
    required this.token,
    required this.questionId,
    required this.lawyerId,
    required this.userData, // Include userData in the constructor
    required this.onNewComment,
  });

  @override
  _CommentInputFieldState createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _commentController = TextEditingController();

  Future<void> submitComment() async {
    print("TokenInsideFunction ${widget.token}");
    var response = await http.post(
      Uri.parse('${GlobalData().baseUrl}/api/questions/answers'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode({
        'question_id': widget.questionId,
        'lawyer_id': widget.lawyerId,
        'lawyer_text': _commentController.text,
      }),
    );

    if (response.statusCode == 201) {
      print('Response Status: ${response.statusCode}');
      var responseData = jsonDecode(response.body);
      var newComment = Comment(
userName: '${widget.userData['first_name']} ${widget.userData['last_name']}' ?? 'Unknown',
  userProfilePicture: widget.userData['profile_picture'] ?? 'No Image',
  text: _commentController.text ?? 'No Comment Text',
      );

      _commentController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment submitted successfully')),
      );
      widget.onNewComment(newComment);

      // Refresh the post details after submitting the comment
      _fetchPostDetails(); // Call method defined below
    } else {
      print('Failed to submit comment');
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit comment: ${response.reasonPhrase}')),
      );
    }
  }

  // Define the _fetchPostDetails method here
  Future<void> _fetchPostDetails() async {
    try {
      // Make a GET request to your backend API endpoint
      final response = await http.get(
        Uri.parse('${GlobalData().baseUrl}/api/questions/${widget.questionId}'),
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );

      if (response.statusCode == 200) {
        // Parse the response and update the _post object with the new details
        final responseBody = jsonDecode(response.body);
        setState(() {
          // Update the post details here
        });
      } else {
        print('Failed to fetch post details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching post details: $e');
    }
  }




@override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              filled: true, // Add this line
              fillColor: Colors.white, // Background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
                borderSide: BorderSide.none, // No border
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Smaller vertically
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: submitComment,
            child: Text('Comment'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}