import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/Screens/ArticleDetailsPage.dart';
import 'package:project/Screens/lawyerhomepage.dart';

class LawyerBlogsPage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  LawyerBlogsPage({Key? key, required this.token, required this.userData}) : super(key: key);

  @override
  _LawyerBlogsPageState createState() => _LawyerBlogsPageState();
}

class _LawyerBlogsPageState extends State<LawyerBlogsPage> {
  late List<dynamic> articles = [];

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?domains=scotusblog.com%2Claw.com%2Cjurist.org%2Clegalmosaic.com&language=en&sortBy=publishedAt&apiKey=fdf1b308b37c4b1c89b483caaceced1b'));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        articles = result['articles'];
      });
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LawyerHomepage(userData: widget.userData, token: widget.token)), // Ensure this navigates to the correct homepage.
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Legal Blogs'),
          backgroundColor: Color(0xFFDCBAFF),
        ),
        backgroundColor: Color(0xFFB884D1),
        body: articles.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return _buildArticleCard(
                    context: context,
                    title: article['title'],
                    author: article['author'] ?? 'Unknown',
                    date: DateTime.parse(article['publishedAt']).toLocal().toString(),
                    image: article['urlToImage'] ?? 'assets/images/default.jpg',
                    content: article['description'] ?? 'No description available.',
                    url: article['url'] ?? 'link not available'
                  );
                },
              ),
      ),
    );
  }

   Widget _buildArticleCard({
    required BuildContext context,
    required String title,
    required String author,
    required String date,
    required String image,
    required String content,
    required String url, // Add url as a required parameter
  }) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _navigateToArticleDetails(context, title, author, date, image, content, url); // Pass the url here
            },
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
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
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToArticleDetails(
    BuildContext context,
    String title,
    String author,
    String date,
    String image,
    String content,
    String url, // Accept url as an argument
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailsPage(
          title: title,
          author: author,
          date: date,
          image: image,
          content: content,
          url: url, // Pass the url to the ArticleDetailsPage
        ),
      ),
    );
  }
}