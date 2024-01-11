
import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  final Function(String, String) onSubmit;

  CreatePostScreen({required this.onSubmit});

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
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;
                if (title.isNotEmpty && content.isNotEmpty) {
                  onSubmit(title, content);
                  Navigator.pop(context);
                }
              },
              child: Text('Submit Post'),
            ),
          ],
        ),
      ),
    );
  }
}