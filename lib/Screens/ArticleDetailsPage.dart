import 'package:flutter/material.dart';

class ArticleDetailsPage extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String image;
  final String content;

  ArticleDetailsPage({required this.title, required this.author, required this.date, required this.image, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details'),
        backgroundColor: Color(0xFFDCBAFF),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By $author',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
