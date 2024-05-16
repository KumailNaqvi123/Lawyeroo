import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/post.dart';
import 'package:project/Screens/post_details.dart';
import 'package:project/Screens/qna_board.dart';

class LawyerQnABoard extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  LawyerQnABoard({required this.token, required this.userData});

  @override
  _LawyerQnABoardState createState() => _LawyerQnABoardState();
}

class _LawyerQnABoardState extends State<LawyerQnABoard> {

  List<Post> allPosts = [];
  @override
  void initState() {
    super.initState();
      print('Token received in LawyerQnABoard: ${widget.token}');
    _fetchPosts();
  }

 bool isLoading = true;
String errorMessage = '';

Future<void> _fetchPosts() async {
  try {
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
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load posts';
      });
      print('Failed to load all posts: ${allResponse.statusCode}');
    }
  } catch (e) {
    setState(() {
      isLoading = false;
      errorMessage = 'Error fetching data: $e';
    });
    print('Error fetching data: $e');
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Q&A Board'), backgroundColor: Color(0xFFDCBAFF)),
    backgroundColor: Color(0xFFB884D1),
    body: isLoading ? Center(child: CircularProgressIndicator()) :
    errorMessage.isNotEmpty ? Center(child: Text(errorMessage)) :
    ListView.builder(
      itemCount: allPosts.length,
      itemBuilder: (context, index) {
        Post currentPost = allPosts[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostDetailsScreen(post: currentPost, userData: widget.userData, token: widget.token,),
              ),
            );
          },
          child: PostTile(post: currentPost, userData: widget.userData, token: widget.token),
        );
      },
    ),
  );
}
}