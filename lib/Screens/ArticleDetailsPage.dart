import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsPage extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String image;
  final String content;
  final String url;  // Add the URL as a parameter

  ArticleDetailsPage({
    required this.title,
    required this.author,
    required this.date,
    required this.image,
    required this.content,
    required this.url,
  });

  // Method to launch URLs
  Future<void> _launchUrl() async {
    // Print the URL to the terminal
    print('Launching URL: $url');

    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details'),
        backgroundColor: Color(0xFFDCBAFF),
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
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/default.jpg',  // Fallback image
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
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
                  Text(
                    'By $author',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Text(content),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: _launchUrl,
                      child: Text(
                        'Read Full Article',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
