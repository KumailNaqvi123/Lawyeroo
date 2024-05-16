//FOR CREATING QUESTIONS

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';

class CreatePostScreen extends StatelessWidget {
  final Function(String, String) onSubmit;
  final Map<String, dynamic> userData;
  final String token;
  final BuildContext context; // Added BuildContext parameter
  final Function() reloadQuestionsAndAnswers; // Added callback function

  CreatePostScreen({
    required this.onSubmit,
    required this.userData,
    required this.token,
    required this.context, // Accept BuildContext
    required this.reloadQuestionsAndAnswers, // Accept callback function

  });

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        backgroundColor: Color(0xFFDCBAFF),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Post Title...',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Post Content...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text;
                final content = _contentController.text;
                if (title.isNotEmpty && content.isNotEmpty) {
                  await _submitPost(title, content); // Wait for post submission
                }
              },

              child: Text('Submit Post'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitPost(String title, String content) async {
  try {
    final response = await http.post(
      Uri.parse('${GlobalData().baseUrl}/api/questions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "client_id": userData['id'],
        "question_title": title,
        "question_text": content,
      }),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      // Post submitted successfully
      onSubmit(title, content);
      reloadQuestionsAndAnswers(); // Trigger reload of questions and answers
      reloadQuestionsAndAnswers();
      Navigator.pop(context); // Navigate back to the previous screen
    } else {
      // Failed to submit post
      print('Failed to submit post: ${response.statusCode}');
    }
  } catch (e) {
    print('Error submitting post: $e');
  }
}
}
